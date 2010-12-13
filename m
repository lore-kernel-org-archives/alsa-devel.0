From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Unable to set ALSA buffer size
Date: Mon, 13 Dec 2010 09:59:18 +0100
Message-ID: <4D05E066.2090300@ladisch.de>
References: <16F32A3F9AF4E441B752BCD79C151ACA635A7480C5@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id CA2BB1037E3
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 09:56:31 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA635A7480C5@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Irfan Shaikh wrote:
> I am trying to set my alsa buffer size as 1024*8. But my playback
> device is not able to set to requested ALSA buffer size.
> 
> Is there any other forcible way to do the above.

No; you cannot use buffer/period size that are not supported by your
hardware.  If your program isn't designed to run with some specific
device, it must be able to cope with any buffer size.

> SASKEN BUSINESS DISCLAIMER: This message may contain bla bla bla ...

This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any confidentiality notices in
those e-mails.  Additionally, confidentiality notices in those e-mails
will incur legal processing fees of $42 per line; you have agreed to
this by reading this confidentiality notice.


Regards,
Clemens
