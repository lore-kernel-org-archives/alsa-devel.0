From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: namehint: Evaluate more possibilities for hw
	devices
Date: Fri, 01 Oct 2010 18:53:09 +0400
Message-ID: <4CA5F5D5.4090508@aknet.ru>
References: <4CA4B6BF.3080503@aknet.ru>
	<alpine.LNX.2.00.1010011332210.20467@eeebox2.perex-int.cz>
	<4CA5CB0D.9030003@aknet.ru>
	<alpine.LNX.2.00.1010011408410.20467@eeebox2.perex-int.cz>
	<4CA5D359.9040400@aknet.ru>
	<alpine.LNX.2.00.1010011512520.20467@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.28])
	by alsa0.perex.cz (Postfix) with ESMTP id BB45024441
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 16:53:10 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1010011512520.20467@eeebox2.perex-int.cz>
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

  Sorry for bothering you again, but I think
even now it is not all that good. :)

---
$ aplay -l
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
card 2: STx7100 [STx7109 audio subsystem], device 0:  [PCM player #0 (HDMI)]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 2: STx7100 [STx7109 audio subsystem], device 1:  [PCM player #1]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 2: STx7100 [STx7109 audio subsystem], device 2:  [SPDIF player (HDMI)]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

$ aplay -L
null
     Discard all samples (playback) or generate zero samples (capture)
default:CARD=Dummy
     Dummy, Dummy PCM
     Default Audio Device
default:CARD=STx7100
     STx7109 audio subsystem, PCM player #0 (HDMI)
     Default Audio Device
---

My question is: why it only lists player 0?
There are also 1 and 2. Is this still a bug,
or am I missing something?
