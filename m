From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: namehint: Evaluate more possibilities for hw
	devices
Date: Fri, 01 Oct 2010 16:26:01 +0400
Message-ID: <4CA5D359.9040400@aknet.ru>
References: <4CA4B6BF.3080503@aknet.ru>
	<alpine.LNX.2.00.1010011332210.20467@eeebox2.perex-int.cz>
	<4CA5CB0D.9030003@aknet.ru>
	<alpine.LNX.2.00.1010011408410.20467@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 003F72444B
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 14:26:01 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1010011408410.20467@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  01.10.2010 16:08, Jaroslav Kysela wrote:
> This patch should definitely fix it:
>
> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=c049d48407ff0459ff15e466edeeee6ecff67fcd 
>
Much better now, thanks!
I still have an issue though.
If the device registers only the playback
substreams and no record substreams,
it is still not listed. To reproduce, set the
"/capture_count" param of /*snd_pcm_new()
*to 0 in dummy.c, and then it disappears
from the list, as follows:
---
aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Dummy [Dummy], device 0: Dummy PCM [Dummy PCM]
   Subdevices: 8/8
   Subdevice #0: subdevice #0
   Subdevice #1: subdevice #1
   Subdevice #2: subdevice #2
   Subdevice #3: subdevice #3
   Subdevice #4: subdevice #4
   Subdevice #5: subdevice #5
   Subdevice #6: subdevice #6
   Subdevice #7: subdevice #7
card 2: STx7109 [STx7109 audio subsystem], device 0:  [PCM player #0 (HDMI)]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 2: STx7109 [STx7109 audio subsystem], device 1:  [PCM player #1]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 2: STx7109 [STx7109 audio subsystem], device 2:  [SPDIF player (HDMI)]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

$ aplay -L
null
     Discard all samples (playback) or generate zero samples (capture)
---

Here you can see also the STx7109 driver, which
is not yet in an alsa tree, having the same problem.
Could you please fix also this?
