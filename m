From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Support for floating point controls?
Date: Tue, 02 Feb 2010 08:42:10 +1300
Message-ID: <4B672E92.6020107@audioscience.com>
References: <4B60C841.9010306@audioscience.com>
	<ad2655cb1002011013m15b6c59atcafa9210078e1366@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FA682432C
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 20:42:15 +0100 (CET)
Received: from [192.168.1.6]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KX60021OHEB8A10@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 02 Feb 2010 08:42:12 +1300 (NZDT)
In-reply-to: <ad2655cb1002011013m15b6c59atcafa9210078e1366@mail.gmail.com>
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

James Courtier-Dutton wrote:
> Which hardware supports these 32 bit float controls?

For our
(http://audioscience.com/internet/products/sound_cards/soundcards.htm)
cards,  none officially yet.


However, we are working on extensions to our control protocol that
allows float parameters, which naturally express the parameters of some
of the controlled algorithms on the card/boxes.  (The processor on the
cards is a floating point DSP)

It would then be a pain if ALSA did not support float controls, because
we'd have to convert from float to int in the kernel to pass to
userspace, where probably it would need to be rescaled to int again...

--
Eliot
