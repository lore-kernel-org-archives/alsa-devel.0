From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: hardware-dependent features
Date: Tue, 13 Nov 2007 08:31:32 +0100
Message-ID: <1194939092.7896.1220996479@webmail.messagingengine.com>
References: <20071112131350.GA25885@buzzloop.caiaq.de>
	<1194888368.31578.1220875067@webmail.messagingengine.com>
	<30B53B6F-F339-429A-9957-7B130DF0BD4F@caiaq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 1A6B42464F
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 08:31:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <30B53B6F-F339-429A-9957-7B130DF0BD4F@caiaq.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On Nov 12, 2007, at 6:26 PM, Clemens Ladisch wrote:
> What I would like to achieve is a conventient way of accessing them,
> probably from the command line via some procfs or sysfs manner so
> users can even use scripts to switch them on and off if they like.

The amixer tool can access any control.

> > I think the displays could by controlled by mixer controls of type
> > "bytes".  Usual mixer applications can't handle those, but this is
> > quite hardware dependent anway ...
> 
> But is that really where it belongs to? I would think that LEDs and
> input functions are not related to audio and thus should be handled
> by some other, more appropriate or maybe even proprietary subsystem.
> 
> There are some features which have influcence on the audio
> behaviour since they affect the way the signal is processed, but
> LEDs are certainly not, are they?

The LEDs are part of the device, so it makes sense to use them in some
manner related to audio.

> Is it ok to attach own, device-specific sysfs entries to device
> folders created by ALSA?

It's possible, but so far, it hasn't been necessary.

> This way, we would have those features releated to the audio device
> but wouldn't need to abuse the mixer API.

It's actually called the "control API" because it can be used to
provide controls of all kinds, not only related to mixing.

I'd stronly recommend to use the control API.  While it is possible to
use sysfs for the same purpose, I don't see any advantage over the
control API.


Regards,
Clemens
