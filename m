From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio syncronisation problem
Date: Tue, 26 Feb 2008 12:36:31 +0100
Message-ID: <47C3F9BF.3080600@ladisch.de>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>	
	<47BEFFFC.8030301@ladisch.de>	
	<43e8c7320802220902j3a4ff3a1wdae77ec25f2d3785@mail.gmail.com>	
	<47C2B822.7000507@ladisch.de>	
	<43e8c7320802251032j7541ac02t1459ef83d95dfd4e@mail.gmail.com>	
	<47C3C07B.2040104@ladisch.de>	
	<43e8c7320802252353p2798488at87163c75a4511c4f@mail.gmail.com>	
	<47C3CA77.5070104@ladisch.de>	
	<43e8c7320802260038x17c2c350wade07dcd4f32cb3e@mail.gmail.com>	
	<47C3D29B.9070708@ladisch.de>
	<43e8c7320802260120u241d2c83r97d7e00d4896992c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 28B49243BA
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 12:34:49 +0100 (CET)
In-Reply-To: <43e8c7320802260120u241d2c83r97d7e00d4896992c@mail.gmail.com>
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
> I wanted to mention that (from what I noticed until now), it is not
> possible to get correct playback on this device unless the sampling
> frequency it is set to (it defaults to 48k when powered on) matches
> the sampling frequency of the audio stream you send to it. So how is
> this supposed to work, if the device is set to 48k and my stream has
> 192k (and I cannot set the device to 192k)?

The alternate setting of the interface is supposed to set the sampling
frequency, and this is exactly what the driver does.

The returned frequency value is correct, so it seems the device knows
that it is supposed to run at 192 kHz.

Does recording work with all sample rates?


Regards,
Clemens
