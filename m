From: Jack Howarth <howarth@bromo.med.uc.edu>
Subject: re: esound 0.2.26 and alsa 0.9.0-rc1
Date: Thu, 9 May 2002 21:20:12 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205100120.VAA33048@bromo.msbb.uc.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bromo.msbb.uc.edu (bromo.med.uc.edu [129.137.3.146])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id DAA05743
	for <alsa-devel@alsa-project.org>; Fri, 10 May 2002 03:21:09 +0200
Received: (from howarth@localhost)
	by bromo.msbb.uc.edu (SGI-8.9.3/8.9.3) id VAA33048
	for alsa-devel@alsa-project.org; Thu, 9 May 2002 21:20:12 -0400 (EDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  Here is the actual output I get when I attempt to run esd with
the alsa support instead of oss...

Audio device open for 44.1Khz, stereo, 16bit failed
Trying 44.1Khz, 8bit stereo.
ALSA lib pcm_hw.c:776:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Device or resource busy
Audio device open for 44.1Khz, stereo, 8bit failed
Trying 48Khz, 16bit stereo.
ALSA lib pcm_hw.c:776:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Device or resource busy
Audio device open for 44.1Khz, stereo, 8bit failed
Trying 22.05Khz, 8bit stereo.
ALSA lib pcm_hw.c:776:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Device or resource busy
Audio device open for 22.05Khz, stereo, 8bit failed
Trying 44.1Khz, 16bit mono.
ALSA lib pcm_hw.c:776:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Device or resource busy
Audio device open for 44.1Khz, mono, 8bit failed
Trying 22.05Khz, 8bit mono.
ALSA lib pcm_hw.c:776:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Device or resource busy
Audio device open for 22.05Khz, mono, 8bit failed
Trying 11.025Khz, 8bit stereo.
ALSA lib pcm_hw.c:776:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Device or resource busy
Audio device open for 11.025Khz, stereo, 8bit failed
Trying 11.025Khz, 8bit mono.
ALSA lib pcm_hw.c:776:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Device or resource busy
Audio device open for 11.025Khz, mono, 8bit failed
Trying 8.192Khz, 8bit mono.
ALSA lib pcm_hw.c:776:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Device or resource busy
Audio device open for 8.192Khz, mono, 8bit failed
Trying 8Khz, 8bit mono.
ALSA lib pcm_hw.c:776:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Device or resource busy
Sound device inadequate for Esound. Fatal.

Again is this being seen with the other sound drivers for esound 0.2.26
or is it a snd-powermac specific issue? Thanks for any feedback.
                  Jack

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
