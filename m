From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: USB device gives wrong data?
Date: Mon, 22 Oct 2007 08:34:54 +0200
Message-ID: <1193034894.13299.1217094833@webmail.messagingengine.com>
References: <47192528.9080403@popdial.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0DAE824895
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Oct 2007 08:53:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <47192528.9080403@popdial.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: william estrada <MrUmunhum@popdial.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

william estrada wrote:
> I think I have found a problem with the USB sound driver?  It appears
> that the current drive returns a x'81' for silence but it should be a
> x'7f'.

The USB audio driver returns whatever data is sent by the device

> When I use my laptop's sound device and record without a mic, I get
> a file full of x'7f's.  If I do the same with my cheap-o USB device
> I get a file full of x'81's.

For unsigned 8-bit samples, silence is x'80'.

Apparently, both devices have some DC offset and are quite noisy.

> I have written a recording program that I have a 'silence' filter
> that filters out segments of dead air.  It works with the laptop's
> sound device but not the USB device.  The filter works by remove
> x'7f's after allowing a selectable amount.

Your filter should be able to detect silence even when noise is present.

> Sorry for the multiple posting, not sure where is should have gone.

The the linux-audio-dev list, of course.  ;-)


Regards,
Clemens
