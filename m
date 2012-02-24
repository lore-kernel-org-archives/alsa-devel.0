From: David Henningsson <david.henningsson@canonical.com>
Subject: USB Headset, digital profile problem
Date: Fri, 24 Feb 2012 11:39:18 +0100
Message-ID: <4F4768D6.60506@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 360BF24548
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 11:39:21 +0100 (CET)
Received: from hd9483857.selulk5.dyn.perspektivbredband.net ([217.72.56.87]
	helo=[192.168.8.102]) by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1S0sYX-0006VK-WB
	for alsa-devel@alsa-project.org; Fri, 24 Feb 2012 10:39:18 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm researching I problem I'm seeing here. As you might know PulseAudio 
tries to open devices in different ways, and so it is trying to open my 
USB headset (at card index 1) with the device string "iec958:1", and I 
want this to fail (to make sure this device is not shown in the user 
interface).

So far it seems like a cold boot will cause the issue to disappear (i e, 
the call fails), whereas a suspend/resume can cause it to appear; but 
I'm not completely sure this is the actual trigger.

When the call fails (that's what I want), the PulseAudio log looks like:

D: [pulseaudio] alsa-util.c: Trying iec958:1 with SND_PCM_NO_AUTO_FORMAT ...
I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 
'cards.USB-Audio.pcm.iec958.0:CARD=1,AES0=4,AES1=130,AES2=0,AES3=2'
I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned 
error: Filen eller katalogen finns inte
I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: Filen eller katalogen 
finns inte
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM iec958:1
I: [pulseaudio] alsa-util.c: Error opening PCM device iec958:1: Filen 
eller katalogen finns inte

("Filen eller katalogen finns inte" means "File or directory not found")

When the call succeeds, the PulseAudio log looks like:

D: [pulseaudio] alsa-util.c: Trying iec958:1 with SND_PCM_NO_AUTO_FORMAT ...
D: [pulseaudio] alsa-util.c: Managed to open iec958:1

I have yet to master the alsa-lib configuration language fully, but at 
least I'm not changing the files between runs. Do you have an idea of 
what the problem could be, or how I can debug it a little deeper?

For reference, all logs are at
https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/940145

With alsa-infos at:
https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/940145/+attachment/2778111/+files/alsa-info.txt.xWdouSRV4Z
https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/940145/+attachment/2778122/+files/alsa-info.txt.oGGls82x6Q

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
