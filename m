From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 09:08:08 +0100
Message-ID: <4B7A5268.5050704@ladisch.de>
References: <20100215192451.GA17938@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id A3E98243A7
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 09:08:10 +0100 (CET)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2BE2BE1457
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 03:08:10 -0500 (EST)
Received: from [10.1.2.38] (srv004.schk01.int.dmc-one.com [85.232.8.141])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8E8DAA97B
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 03:08:09 -0500 (EST)
In-Reply-To: <20100215192451.GA17938@tango.0pointer.de>
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

Lennart Poettering wrote:
> Getting back to the invalid dB data from the USB cards: the question
> is whether the USB descriptor data is badly parsed, and the dB
> mismatch hence systematic for USB cards,

USB descriptors use units of 1/256th dB, while ALSA uses 1/100th dB.
When the level is computed from the minimum plus a multiple of the step
size, rounding errors add up considerately.

ALSA 1.0.21 (kernel 2.6.32) added a different TLV type that reports the
range with the min/max values to minimize those rounding errors.


Regards,
Clemens
