From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Additing a new Hardware Specific feature in the
 ALSA driver
Date: Tue, 23 Dec 2008 10:48:32 +1300
Message-ID: <49500B30.8030201@audioscience.com>
References: <35fa40850812200554y7523520aq27a427732ab87a8e@mail.gmail.com>
	<494EAEAD.3080001@audioscience.com>
	<35fa40850812212118i479dcd57s35c3d50b7b8ab40d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id D13841037F4
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 22:48:47 +0100 (CET)
Received: from [192.168.1.100]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KCA001A0SKWKH20@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 23 Dec 2008 10:48:35 +1300 (NZDT)
In-reply-to: <35fa40850812212118i479dcd57s35c3d50b7b8ab40d@mail.gmail.com>
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
Cc: SUBHRANIL CHOUDHURY <subhra85@gmail.com>
List-Id: alsa-devel@alsa-project.org

SUBHRANIL CHOUDHURY wrote:
> Eliot,
> Suppose i need to change the DAC gain, ADC gain of the audio codec and
> also disable and enable AGC of the codec i need to put some IOCTLs in 
> the driver.
> So, in case of ALSA how do i implement those IOCTLs in the driver and
> also expose them to the application through the ALSA library.

No! For this kind of control You just need to implement standard alsa
controls in your driver.

BOOLEAN:  AGC ON/OFF
INTEGER: DAC gain.

See "writing an ALSA driver" for details, and study the source of any
ALSA driver.

http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/c843.htm
--
Eliot
