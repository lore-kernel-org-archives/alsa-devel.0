From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Unable to set recording sample rate to 44100
Date: Fri, 24 Sep 2004 09:47:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924074714.GA13857@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

As part of research project, I am writing an application for audio=20
transfer over UDP/IP.  I am new to ALSA programming, but luckily I found
Jeff Tranters helpful introductory article at=20
<URL: http://http://www.linuxjournal.com/article.php?sid=3D6735 >, with=20
example listings downloadable from
<URL: ftp.ssc.com/pub/lj/listings/issue126/6735.tgz >.

I am however having a problem using his example code.  The capture progra=
m,
listing 4, in most cases exits with an error:
"unable to set hw parameters: Invalid argument".
(See snippet of relevant code below.)

I have tried to change the setup parameters, and it seems that the proble=
m=20
is the sample rate, which is set to 44100.  If I change this to 88200,=20
the program will run (but the captured audio is not good, with a lot of n=
oise).

The system is Debian Sarge on a Dell Dimension, with a SoundBlaster Live =
card.
(It is a real SoundBlaster card, not the Dell variety.)  And sound works =
well
on the box otherwise, I may both record (using krec) and play back sound=20
(alsaplayer, Jeff Tranters listing 3 ...).

Can anyone offer an explanation of what the problem is, and what I can do=
=20
solve it?  Any help would be greatly appreciated.

With regards=20
Asbj=F8rn S=E6b=F8




  /* Open PCM device for recording (capture). */
  rc =3D snd_pcm_open(&handle, "default",
                    SND_PCM_STREAM_CAPTURE, 0);
  if (rc < 0) {
    fprintf(stderr,=20
            "unable to open pcm device: %s\n",
            snd_strerror(rc));
    exit(1);
  }
 =20
  /* Allocate a hardware parameters object. */
  snd_pcm_hw_params_alloca(&params);

  /* Fill it in with default values. */
  snd_pcm_hw_params_any(handle, params);

  /* Set the desired hardware parameters. */

  /* Interleaved mode */
  snd_pcm_hw_params_set_access(handle, params,
                      SND_PCM_ACCESS_RW_INTERLEAVED);

  /* Signed 16-bit little-endian format */
  snd_pcm_hw_params_set_format(handle, params,
                              SND_PCM_FORMAT_S16_LE);

  /* Two channels (stereo) */
  snd_pcm_hw_params_set_channels(handle, params, 2);

  /* 44100 bits/second sampling rate (CD quality) */
  val =3D 44100;
  snd_pcm_hw_params_set_rate_near(handle, params,=20
                                  &val, &dir);

  /* Set period size to 32 frames. */
  frames =3D 32;
  snd_pcm_hw_params_set_period_size_near(handle,=20
                              params, &frames, &dir);

  /* Write the parameters to the driver */
  rc =3D snd_pcm_hw_params(handle, params);
  if (rc < 0) {
    fprintf(stderr,
            "unable to set hw parameters: %s\n",
            snd_strerror(rc));
    exit(1);
  }




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
