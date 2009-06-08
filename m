From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: EMU 0404USB: Odd sample rate shown during playback.
Date: Mon, 08 Jun 2009 09:24:58 +0200
Message-ID: <4A2CBCCA.7040704@ladisch.de>
References: <d9690f190906051353o23c9b0ffg1c41291b60f62c6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A753824445
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 09:24:48 +0200 (CEST)
In-Reply-To: <d9690f190906051353o23c9b0ffg1c41291b60f62c6a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Klaus Schulz <kls.schlz@googlemail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Klaus Schulz wrote:
> The EMU 0404 is running in async USB mode as you know. When looking at the
> stream parameters  during playback the sample rate shown is always slightly
> below 44100 -- something like 44098 is shown.

This is what "asynchronous" means: The computer's clock and the device's
clock run independently from each other, so they can have slightly
different speeds.


Best regards,
Clemens
