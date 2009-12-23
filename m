From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: need help with io plugin programming: how to add
 delay ?
Date: Wed, 23 Dec 2009 09:15:00 +0100
Message-ID: <4B31D184.3020300@gmail.com>
References: <4B312435.800@gmail.com> <4B315163.5090404@gmail.com>
	<53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 090C2103827
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 09:15:14 +0100 (CET)
In-Reply-To: <53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Austin <circuitsoft.alex@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Alex Austin wrote:
> Do you really need a socket, or are you just trying to move audio data
> from one app to another? Check out jack and netjack. They may already
> provide the functionality you need.

I need to move PCM samples to/from alsa from/to a DSP board.
As the DSP board uses a serial interface (UART) it would be rather
cumbersome to implement this functionality as kernel driver.
My solution should be a little bit similar to bluetooth audio as it also
uses an alsa io plugin and a daemon that actually talks to different
(hardware-) devices.

cheers,
stefan
