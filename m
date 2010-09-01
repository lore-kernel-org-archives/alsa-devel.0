From: Andrew Chung <achung@stlglobal.com>
Subject: Mono <-> Stereo
Date: Wed, 01 Sep 2010 22:02:18 +0800
Message-ID: <4C7E5CEA.2080308@stlglobal.com>
Reply-To: achung@stlglobal.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.stlglobal.com (stlglobal.com [118.142.84.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 87E3C245A2
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 16:02:29 +0200 (CEST)
Received: from accomp.stlglobal.com ([192.168.100.107])
	by www.stlglobal.com with esmtp (Exim 4.69)
	(envelope-from <achung@stlglobal.com>) id 1OqntM-0007cG-0W
	for alsa-devel@alsa-project.org; Wed, 01 Sep 2010 22:02:25 +0800
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

  Hi,

I'm completely new to ALSA development. I recently inherited a project 
built on a Freescale i.MX 27 platform, using Linux 2.6.33

The MX27 is connected via I2S to a GSM module, and also a TLV32AIC3007 
codec for local playback. There seems to be some format mismatch causing 
the audio to become garbled.

I called in through the GSM and used "arecord -D plughw:0,1 -f dat 
test.wav" to record some audio. I then played back with "aplay -D 
<device> test.wav"

1. If I play it through the GSM, I can hear what I recorded, but it 
appears to be playing twice as fast

2. If I play it through the codec, I just get garbled junk

I'm told that this may be because the GSM module supports mono only, 
whereas the IMX SSI driver supports only stereo out of the box.

Does anyone have any experience with such a setup, and can provide some 
pointers on where to look at to resolve this issue?

Thanks
Andrew
