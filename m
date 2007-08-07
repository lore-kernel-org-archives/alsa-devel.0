From: stan <stanl@cox.net>
Subject: Re: SOLVED Re: snd_pcm_hw_params_set_format fails with
 invalid argument
Date: Tue, 7 Aug 2007 08:32:25 -0700
Message-ID: <20070807083225.51e3ebb1@localhost.localdomain>
References: <20070803112049.7ced76ec@localhost.localdomain>
	<20070805131041.67c04d1e@localhost.localdomain>
	<20070806090457.1ec96108@localhost.localdomain>
	<20070806092201.37bdc18e@localhost.localdomain>
	<s5habt31n33.wl%tiwai@suse.de>
	<20070807080242.0da2a0ff@localhost.localdomain>
	<20070807082621.5a557ca4@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_jRC9k2rGZLaeFerKj8NuE=Z"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 8105610386C
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Aug 2007 17:32:27 +0200 (CEST)
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao105.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP id
	<20070807153226.KYMJ26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>
	for <alsa-devel@alsa-project.org>; Tue, 7 Aug 2007 11:32:26 -0400
In-Reply-To: <20070807082621.5a557ca4@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_jRC9k2rGZLaeFerKj8NuE=Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

And here it is with attachments.  

On Tue, 7 Aug 2007 08:26:21 -0700
stan <stanl@cox.net> wrote:

> I sent this directly to Takashi by mistake.  I could have sworn I saw
> the list in the to field but I must be mistaken.  Here it is for the
> list.
> 
> On Tue, 7 Aug 2007 08:02:42 -0700
> stan <stanl@cox.net> wrote:
> 
> > On Tue, 07 Aug 2007 15:38:40 +0200
> > Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > > At Mon, 6 Aug 2007 09:22:01 -0700,
> > > stan wrote:
> > > > 
> > > > On Mon, 6 Aug 2007 09:04:57 -0700
> > > > stan <stanl@cox.net> wrote:
> > > > 
> > > > > I downloaded the hg alsa-lib snapshot of July 14, 2007,
> > > > > compiled it, (on Fedora 7 you will have to make a link to
> > > > > compile, cd /usr/include
> > > > > ln -s python2.5 python)
> > > > > and linked my program against it.  It works again so the issue
> > > > > has been fixed in the latest version of alsa lib.  Any
> > > > > estimate of when this version will be released for public
> > > > > consumption? My app is dead in the water with the current
> > > > > version of alsa, so anyone trying to use it will have a
> > > > > terrible user experience.  :-(  I want to give some
> > > > > indication of when people can expect it to start working
> > > > > again. In the meantime I'll create instructions on how to
> > > > > install the hg version to usr/local and change the library
> > > > > linking.
> > > > > 
> > > > > Thanks.
> > > > > 
> > > > For anyone interested, these are the formats that fail in 1.0.14
> > > > final
> > > > 
> > > > Value of last format 43
> > > > test of sample format 14 failed (Invalid argument)
> > > > test of sample format 15 failed (Invalid argument)
> > > > test of sample format 16 failed (Invalid argument)
> > > > test of sample format 17 failed (Invalid argument)
> > > > test of sample format 18 failed (Invalid argument)
> > > > test of sample format 19 failed (Invalid argument)
> > > > test of sample format 23 failed (Invalid argument)
> > > > test of sample format 24 failed (Invalid argument)
> > > > test of sample format 25 failed (Invalid argument)
> > > > test of sample format 26 failed (Invalid argument)
> > > > test of sample format 27 failed (Invalid argument)
> > > > test of sample format 28 failed (Invalid argument)
> > > > test of sample format 29 failed (Invalid argument)
> > > > test of sample format 30 failed (Invalid argument)
> > > > test of sample format 31 failed (Invalid argument)
> > > > Format returned (0)
> > > > 
> > > > 
> > > > and these are the formats that fail in the hg version.
> > > > 
> > > > Value of last format 43
> > > > test of sample format 18 failed (Invalid argument)
> > > > test of sample format 19 failed (Invalid argument)
> > > > test of sample format 23 failed (Invalid argument)
> > > > test of sample format 24 failed (Invalid argument)
> > > > test of sample format 25 failed (Invalid argument)
> > > > test of sample format 26 failed (Invalid argument)
> > > > test of sample format 27 failed (Invalid argument)
> > > > test of sample format 28 failed (Invalid argument)
> > > > test of sample format 29 failed (Invalid argument)
> > > > test of sample format 30 failed (Invalid argument)
> > > > test of sample format 31 failed (Invalid argument)
> > > > Format returned (16)
> > > 
> > > Could you give me the simple test case for checking the same thing
> > > on my system?
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > 
> > They are attached as file test_case.c and shell script mktest.
> > 
> > Running ./mktest should generate an executable named test_case.
> > Running that should generate the above output.
> > 
> > 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MP_jRC9k2rGZLaeFerKj8NuE=Z
Content-Type: application/octet-stream; name=mktest
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=mktest

IyEvYmluL2Jhc2gKCk9QVD0nLVdhbGwgLVcgLU8yIC1zICcKTElCUz0nIC1sYXNvdW5kICcKCmdj
YyAkT1BUIHRlc3RfY2FzZS5jICRMSUJTIC1vIHRlc3RfY2FzZSB8fCBleGl0IDEK

--MP_jRC9k2rGZLaeFerKj8NuE=Z
Content-Type: text/x-csrc; name=test_case.c
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=test_case.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <ctype.h>
#include <alsa/asoundlib.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <sys/times.h>
#include <sys/soundcard.h>
#include <samplerate.h>
#include <sndfile.h>
#include <math.h>
#include <stdarg.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>
#include <getopt.h>
#include <poll.h>
#include <pthread.h>
#include <dlfcn.h>
int main ();
void alsa_open ();

// START OF PROGRAMS
//
// M A I N
//

int
main ()
{
  alsa_open ();
  return 0;
}
/*------------------------------------------------------------------------------
**	Linux alsa functions for playing a sound.
*/

void
alsa_open ()
{	
  //char *default_device = "default" ;
  char *device = "plughw:0,0" ;
	int err ;
	snd_pcm_t *alsa_dev = NULL ;
	snd_pcm_hw_params_t *hw_params ;

  err = snd_pcm_open (&alsa_dev, device, SND_PCM_STREAM_PLAYBACK, 0);
	if (err < 0)
	{	fprintf (stderr, "cannot open audio device \"%s\" (%s)\n", device, snd_strerror (err)) ;
		goto catch_error ;
		} ;

  err = snd_pcm_hw_params_malloc (&hw_params);
	if (err < 0)
	{	fprintf (stderr, "cannot allocate hardware parameter structure (%s)\n", snd_strerror (err)) ;
		goto catch_error ;
		} ;

  err = snd_pcm_hw_params_any (alsa_dev, hw_params);
	if (err < 0)
	{	fprintf (stderr, "cannot initialize hardware parameter structure (%s)\n", snd_strerror (err)) ;
		goto catch_error ;
		} ;

  err = snd_pcm_hw_params_set_access (alsa_dev, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED);
	if (err < 0)
	{	fprintf (stderr, "cannot set access type (%s)\n", snd_strerror (err)) ;
		goto catch_error ;
		} ;

  int iformat;
  fprintf (stderr, "Value of last format %lu\n", 
                          (unsigned long) SND_PCM_FORMAT_LAST) ;
  for (iformat = 0; iformat <= SND_PCM_FORMAT_LAST; iformat++)
  {
    err = snd_pcm_hw_params_test_format (alsa_dev, hw_params, iformat);
    if (err < 0)
      fprintf (stderr, "test of sample format %lu failed (%s)\n", 
                          (unsigned long) iformat, snd_strerror (err)) ;
  }

  err = snd_pcm_hw_params_set_format (alsa_dev, hw_params, SND_PCM_FORMAT_FLOAT64);
	if (err < 0)
	{	fprintf (stderr, "cannot set sample format %lu (%s)\n", 
                        (unsigned long) SND_PCM_FORMAT_FLOAT64, snd_strerror (err)) ;
		goto catch_error ;
		} ;

  snd_pcm_format_t fval;
  snd_pcm_hw_params_get_format (hw_params, &fval);
  fprintf (stderr, "Format (%lu)\n", (unsigned long) fval);
  if ((unsigned long) fval != (unsigned long) SND_PCM_FORMAT_FLOAT64)
    fprintf (stderr, "Format (%lu) differs from requested (%lu)\n", 
              (unsigned long) fval, (unsigned long) SND_PCM_FORMAT_FLOAT64);

  snd_pcm_close (alsa_dev) ;

catch_error :

	if (err < 0 && alsa_dev != NULL)
	{	snd_pcm_close (alsa_dev) ;
		} ;
}              

--MP_jRC9k2rGZLaeFerKj8NuE=Z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MP_jRC9k2rGZLaeFerKj8NuE=Z--
