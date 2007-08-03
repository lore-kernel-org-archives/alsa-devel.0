From: stan <stanl@cox.net>
Subject: snd_pcm_hw_params_set_format fails with invalid
	argument
Date: Fri, 3 Aug 2007 11:20:49 -0700
Message-ID: <20070803112049.7ced76ec@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 26481103840
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Aug 2007 20:20:51 +0200 (CEST)
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao105.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP id
	<20070803182050.WQST26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>
	for <alsa-devel@alsa-project.org>; Fri, 3 Aug 2007 14:20:50 -0400
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

Fedora 7 upgraded alsa to 1.0.14 from RC3.  I was going to test the
default device sound for my prior problem (as requested by Takashi
weeks ago). Unfortunately when I try to run my app it won't start.  The
snd_pcm_hw_params_set_format fails when I try to use it as follows.

  err = snd_pcm_hw_params_set_access (alsa_dev, hw_params, ND_PCM_ACCESS_RW_INTERLEAVED);
	if (err < 0)
	{	fprintf (stderr, "cannot set access type (%s)\n", snd_strerror (err)) ;
		goto catch_error ;
		} ;

  err = snd_pcm_hw_params_set_format (alsa_dev, hw_params, SND_PCM_FORMAT_FLOAT64_LE);
  //err = snd_pcm_hw_params_set_format (alsa_dev, hw_params, SND_PCM_FORMAT_S32_LE);
	if (err < 0)
	{	fprintf (stderr, "cannot set sample format (%s)\n", snd_strerror (err)) ;
		goto catch_error ;
		} ;


cannot set sample format (Invalid argument)

It compiles cleanly.  When I replace the SND_PCM_FORMAT_FLOAT64_LE
with the S32_LE, it sets it, but of course the sound is garbage
as it is still receiving doubles.

This code worked fine under RC3.
Is there some change that occurred in the step from 1.0.14.rc3 to
1.0.14 that would explain the above and suggest a fix?

Thank you.

$ uname -r
2.6.22.1-41.fc7

$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.14 (Thu May 31
09:03:25 2007 UTC).

$ ls /proc/asound/card0
ice1724  id  oss_mixer  pcm0c  pcm0p  pcm1p  pcm2p
