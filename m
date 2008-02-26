From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio syncronisation problem
Date: Tue, 26 Feb 2008 09:49:31 +0100
Message-ID: <47C3D29B.9070708@ladisch.de>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>	<47BEF8FE.4030408@ladisch.de>	<43e8c7320802220846g7d7c8b61jb29e8ca3028d2c24@mail.gmail.com>	<47BEFFFC.8030301@ladisch.de>	<43e8c7320802220902j3a4ff3a1wdae77ec25f2d3785@mail.gmail.com>	<47C2B822.7000507@ladisch.de>	<43e8c7320802251032j7541ac02t1459ef83d95dfd4e@mail.gmail.com>	<47C3C07B.2040104@ladisch.de>	<43e8c7320802252353p2798488at87163c75a4511c4f@mail.gmail.com>	<47C3CA77.5070104@ladisch.de>
	<43e8c7320802260038x17c2c350wade07dcd4f32cb3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 84D1B1038BF
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 09:47:48 +0100 (CET)
In-Reply-To: <43e8c7320802260038x17c2c350wade07dcd4f32cb3e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Stancu <adrian.stancu.82@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian Stancu wrote:
> OK, I tried playing the stereo file but still getting the same error:
> deathu@vader:~/Desktop$ aplay -D hw:1 testtone192.wav
> Playing WAVE 'testtone192.wav' : Signed 16 bit Little Endian, Rate 192000 Hz, Stereo
> aplay: set_params:918: Sample format non available

Oops, the device supports only 24-bit samples, and this isn't supported
by .wav files, so using hw:1 won't ever work with aply.

> Well, my test file contained a single constant frequency tone; it is
> still there while I play the 192k file through plughw:1,0, but burried
> under:
> - periodic series of clicks
> - other high frequency tones
>
> Here is  /proc/asound/card1/stream0 while playing through plughw:1,0:
> ...
>     Momentary freq = 192000 Hz (0x18.0000)

Does this value ever change?
Could you again try inserting a printk to see whether the driver thinks
it gets invalid frequency values?


Regards,
Clemens
