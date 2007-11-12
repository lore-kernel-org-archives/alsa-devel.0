From: Daniel Mack <daniel@caiaq.org>
Subject: Re: hardware-dependent features
Date: Mon, 12 Nov 2007 21:39:45 +0100
Message-ID: <30B53B6F-F339-429A-9957-7B130DF0BD4F@caiaq.org>
References: <20071112131350.GA25885@buzzloop.caiaq.de>
	<1194888368.31578.1220875067@webmail.messagingengine.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E7482449C
	for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2007 21:39:49 +0100 (CET)
In-Reply-To: <1194888368.31578.1220875067@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Nov 12, 2007, at 6:26 PM, Clemens Ladisch wrote:

> I've used three 'mixer' controls for the three LEDs of the SB Audigy 2
> NX.  Whether this is a good idea depends on how many LEDs there  
> are, and
> how one might want to use them.  Are there LED displays, i.e.,  
> multiple
> LEDs in a row?

Depends. There is one device which has 4 user-assignable LEDs, some
others have up to >35 LEDs which can be dimmed in 64 steps, yet
another one has 7-segment LED displays.

What I would like to achieve is a conventient way of accessing them,
probably from the command line via some procfs or sysfs manner so
users can even use scripts to switch them on and off if they like.

> I think the displays could by controlled by mixer controls of type
> "bytes".  Usual mixer applications can't handle those, but this is
> quite hardware dependent anway ...

But is that really where it belongs to? I would think that LEDs and
input functions are not related to audio and thus should be handled
by some other, more appropriate or maybe even proprietary subsystem.

There are some features which have influcence on the audio
behaviour since they affect the way the signal is processed, but
LEDs are certainly not, are they?

Is it ok to attach own, device-specific sysfs entries to device
folders created by ALSA? I could imagine having a "leds" subdir with
all the possible entries in it. The sysfs layer is easy to handle so
there wouldn't be much overhead. This way, we would have those
features releated to the audio device but wouldn't need to abuse the
mixer API. Or is that a no-go?

Regards,
Daniel
