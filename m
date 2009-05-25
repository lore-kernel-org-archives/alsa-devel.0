From: Werner Van Belle <werner@yellowcouch.org>
Subject: Re: Third time: Unlink PCM resource ?
Date: Mon, 25 May 2009 21:36:38 +0200
Message-ID: <4A1AF346.9040602@yellowcouch.org>
References: <4A1AB98B.9010604@yellowcouch.org>
	<s5hk54589xd.wl%tiwai@suse.de>	<4A1ADAEF.3070803@yellowcouch.org>
	<s5h8wklvyfc.wl%tiwai@suse.de>	<4A1AE302.8080702@yellowcouch.org>
	<s5h7i05vxol.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0905252036550.4067@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1694521704116236736=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sigtrans.org (sigtrans.org [213.239.213.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 16431244F4
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 21:34:41 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.0905252036550.4067@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1694521704116236736==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig270532DF13B5C4E748D04916"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig270532DF13B5C4E748D04916
Content-Type: multipart/mixed;
 boundary="------------040806040300080707060505"

This is a multi-part message in MIME format.
--------------040806040300080707060505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jaroslav Kysela wrote:
> The question is if it's not better to free also allocated memory=20
> associated to the pcm handle in child process - so snd_pcm_close()=20
> call in child is not a bad idea.
>  =20
Okay, while you both have been discussing some internals, which I didn't
try yet, I created a demonstration program to illustrate the mixed
semantics of the 'sharing' versus 'not sharing' behavior of the dsp
devices. In the example the parent thread will play a sound, then the
child closes the dsp, which affects the playback in the parent (it
either hangs or skips all remaining samples). From this one would
conclude that the pcm device is fully shared between the two processes
(semantics I can live with). However, when the parent then tries to
reopen the device it cannot do so because the device is still 'busy'.

As a solution, a call to an unlink function would maybe solve it but it
is indicative of a deeper unclarity of how the semantics of shared DSP
devices should be. I would propose to let alsa act as a true filehandle.
In such a scenario a close in the child should not affect the playback
in the parent since the parent still has the descriptor open. Please
have a look at the attached code. It is 256 lines :-) The problem is
documented in the main routine.

With kind regards,

Werner,-

--=20
Dr. Werner Van Belle
http://werner.yellowcouch.org/


--------------040806040300080707060505
Content-Type: text/x-c++src;
 name="close-affects-play.cpp"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="close-affects-play.cpp"

using namespace std;
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include <stdarg.h>
#include <alsa/asoundlib.h>
#include "memory.h"
#include <iostream>

typedef unsigned int unsigned4;
typedef signed long long signed8;
typedef signed short signed2;
snd_pcm_t *dsp;
snd_pcm_uframes_t buffer_size;
snd_pcm_uframes_t period_size;
unsigned4 * buffer;
unsigned4 filled;
int        arg_latency;
char *     arg_dev;
const int err_dsp=3D1;
const int err_none=3D0;

void Info(const char* script, ...)
{
  char toexecute[1024];
  va_list ap;
  va_start(ap,script);
  vsnprintf(toexecute,1024,script,ap);
  va_end(ap);
  cout << toexecute << '\n';
  fflush(stdout);
};

void dsp_write(unsigned4 *value)
{
  int err =3D 0;
  while(!err)
    {
      err =3D snd_pcm_writei(dsp,value,1);
    }
  assert(err!=3D-EAGAIN);
  assert(err!=3D-ESTRPIPE);
  if (err=3D=3D-EPIPE)
    {
      Info("underrun occured...");
      err =3D snd_pcm_prepare(dsp);
      if (err < 0)
	Info("cant recover from underrun: %s",snd_strerror(err));
      return;
    }
}

int dsp_open()
{
  int err;
  unsigned int buffer_time, period_time;
  snd_pcm_hw_params_t *hparams;
  snd_pcm_sw_params_t *sparams;
  snd_output_t * output =3D NULL;
  err =3D snd_output_stdio_attach(&output,stdout,0);
  if (err < 0 )
    {
      Info("attaching to stdio didn't succeed: %s",snd_strerror(err));
      return err_dsp;
    }
  err =3D snd_pcm_open(&dsp, arg_dev, SND_PCM_STREAM_PLAYBACK, 0);
  if (err < 0)
    {
      Info("opening alsa device failed : %s",snd_strerror(err));
      return err_dsp;
    }
 =20
  snd_pcm_sw_params_alloca(&sparams);
  snd_pcm_hw_params_alloca(&hparams);
 =20
  err =3D snd_pcm_hw_params_any(dsp, hparams);
  if (err<0)
    {
      Info("Broken configuration file for pcm : %s",snd_strerror(err));
      return err_dsp;
    } =20
  err =3D snd_pcm_hw_params_set_access(dsp, hparams, SND_PCM_ACCESS_RW_IN=
TERLEAVED);
  if (err<0)
    {
      Info("Unable to set interleaved access to pcm device: %s",snd_strer=
ror(err));
      return err_dsp;
    }
  err =3D snd_pcm_hw_params_set_format(dsp, hparams, SND_PCM_FORMAT_S16);=

  if (err<0)
    {
      Info("Unable to set sample format to standard 16 bit: %s",snd_strer=
ror(err));
      return err_dsp;
    }
  err =3D snd_pcm_hw_params_set_channels(dsp, hparams, 2);
  if (err < 0)
    {
      Info("setting dsp to 2 channels failed : %s",snd_strerror(err));
      return err_dsp;
    }
 =20
  unsigned int q =3D 44100;
  err =3D snd_pcm_hw_params_set_rate_near(dsp, hparams, &q, 0);
  if (err < 0)
    {
      Info("setting dsp speed (%d) failed",q);
      return err_dsp;
    }
  if (q !=3D 44100)
    Info("setting dsp speed (%d) failed, resulting rate =3D %d ",44100, q=
);

  period_time =3D arg_latency * 1000;
  buffer_time =3D period_time *2;
  {
    unsigned int t =3D buffer_time;
    int dir =3D 1;
    err =3D snd_pcm_hw_params_set_buffer_time_near(dsp,hparams,&t,&dir);
    if (err<0)
      {
	Info("dsp-alsa: Impossible to set pcm buffer time to %i (%i): %s", buffe=
r_time,t,snd_strerror(err));
	return err_dsp;
      }
   =20
    err =3D snd_pcm_hw_params_get_buffer_size(hparams,&buffer_size);
    if (err<0)
      {
	Info("     impossible to obtain buffer size: %s",snd_strerror(err));
	return err_dsp;
      }
   =20
    t =3D period_time;
    err =3D snd_pcm_hw_params_set_period_time_near(dsp, hparams,&t,&dir);=

    if (err<0)
      {
	Info("     impossible to set pcm period time to %i (%i): %s", period_tim=
e,t,snd_strerror(err));
	return err_dsp;
      }
    err =3D snd_pcm_hw_params_get_period_size(hparams,&period_size,&dir);=

    if (err<0)
      {
	Info("     ompossible to obtain period data size: %s",snd_strerror(err))=
;
	return err_dsp;
      }
    if (period_size*2 - 1>buffer_size)
      {
	Info("The alsa driver cannot allocate sufficiently large buffers due to =
the "
	      "large requested latency. (playbuffer size   =3D %li, "
	      "total buffer size =3D %li). Try decreasing the latency.",period_s=
ize,buffer_size);
	return err_dsp;
      }
    dir =3D 0;
  }
  err =3D snd_pcm_hw_params(dsp,hparams);
  if (err < 0)
    {
      Info("unable to set hw parameters for pcm: %s",snd_strerror(err));
      return err_dsp;
    }
 =20
  err =3D snd_pcm_sw_params_current(dsp,sparams);
  if (err < 0)
    {
      Info("unable to determine sw parameters for pcm: %s",snd_strerror(e=
rr));
      return err_dsp;
    }=20
  err =3D snd_pcm_sw_params_set_start_threshold(dsp,sparams,buffer_size);=

  if (err < 0)
    {
      Info("unable to set start to treshold mode: %s",snd_strerror(err));=

      return err_dsp;
    }
  err =3D snd_pcm_sw_params_set_avail_min(dsp,sparams,period_size);
  if (err < 0 )
    {
      Info("unable to set minimum start size: %s",snd_strerror(err));
      return err_dsp;
    }
  err =3D snd_pcm_sw_params(dsp,sparams);
  if (err < 0)
    {
      Info("unable to set software parameters: %s",snd_strerror(err));
      return err_dsp;
    }
  snd_pcm_dump(dsp,output);
  buffer =3D (unsigned4*)malloc(period_size*sizeof(unsigned4));
  return err_none;
}

void dsp_close()
{
  int err =3D snd_pcm_close(dsp);
  if (err < 0)
    Info("cant close pcm device: %s",snd_strerror(err));
  dsp=3D0;
}

void stream_wave()
{
  for(int t=3D10; t>=3D0; t--)
    {
      cerr << "Parent plays (" << t << "s left)\n";
      for(int i =3D 0 ; i < 44100; i++)
	{
	  float x=3Di;
	  float y=3D16384.*sin(x*2*M_PI*220./44100.)/4;
	  struct {signed2 l; signed2 r;} lr;
	  lr.l=3Dy;
	  lr.r=3Dy;
	  dsp_write((unsigned4*)&lr);
	}
    }
}

/**
 * This example first shows that a close in the child will=20
 * affect the playback in the parent. Sometimes the parents
 * just hangs in the write call, sometimes it just skips
 * all samples.
 *=20
 * However, the device in the parent is actually not=20
 * closed at all since we cannot reopen it.
 */
int main (int argc, char* argv[])
{
  arg_dev =3D "hw:0";
  dsp =3D NULL;
  filled =3D 0;
  buffer_size =3D 0;
  period_size =3D 0;
  arg_latency =3D 150;
  // first open the DSP device.
  Info("Opening DSP Device in parent thread");
  dsp_open();
  int childpid=3Dfork(); assert(childpid>-1);
  if (childpid)
    {
      // the parent thread now waits two seconds and the closes the devic=
e
      Info("Parent thread playing");
      stream_wave();
      Info("Parent tries to reopen the device");
      dsp_open();
      stream_wave();
    }
  else
    {
      sleep(5);
      Info("Child closes the dsp device");
      dsp_close();
    }
}

--------------040806040300080707060505--

--------------enig270532DF13B5C4E748D04916
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoa80YACgkQYJM5sO5rAR3ZxQCfVCJBxp/A4jTKuknLq3a0q/Tz
p34AoMGlu1NK4YNas51e21i/Lxg2buZC
=iVt+
-----END PGP SIGNATURE-----

--------------enig270532DF13B5C4E748D04916--

--===============1694521704116236736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1694521704116236736==--
