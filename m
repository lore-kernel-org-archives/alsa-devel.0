From: Jerry Geis <geisj@pagestation.com>
Subject: Gigabyte ALC889A Function ID: 0x01
Date: Wed, 15 Apr 2009 10:00:33 -0400
Message-ID: <49E5E881.5020507@pagestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unifiedpaging.messagenetsystems.com
	(mail.emergencycommunicationsystems.com [24.123.23.170])
	by alsa0.perex.cz (Postfix) with ESMTP id B8F7E1038CF
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 16:00:34 +0200 (CEST)
Received: from devcentos5x64.msgnet.com (devcentos5x64 [192.168.1.8])
	by unifiedpaging.messagenetsystems.com (8.13.1/8.13.1) with ESMTP id
	n3FE0VY8009241
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 10:00:31 -0400
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

I am using the gigabyte MA78GM-US2H motherboard. it has the ALC889A audio.

I am trying 1.0.19 and audio works out the analog back port but not over 
HDMI.

Codec: Realtek ALC889A
Address: 0
Function Id: 0x1                                     
<--------------------------------- this is different
Vendor Id: 0x10ec0885
Subsystem Id: 0x1458a002
Revision Id: 0x100101
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo

I have been looking but havent found a solution yet. I tried grabbing 
the snapshot tar ball for today but I get errors on the compile.

I had a similiar motherboard but it does not report Function ID: 01 : - 
HDMI audio on this board works correctly.
Codec: Realtek ALC889A
Address: 0
Vendor Id: 0x10ec0885
Subsystem Id: 0x1458a002
Revision Id: 0x100101
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000

Any thoughts????

Jerry
