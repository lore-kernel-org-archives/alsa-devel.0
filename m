From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] Improved support for	different	bt87x	board
	configurations
Date: Wed, 05 Sep 2007 11:32:51 +0100
Message-ID: <1188988371.6158.43.camel@areia>
References: <Pine.LNX.4.58.0708300319210.18152@shell4.speakeasy.net>
	<s5h3ay1i8rs.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709021603380.18152@shell4.speakeasy.net>
	<1188801407.6762.1208578117@webmail.messagingengine.com>
	<Pine.LNX.4.58.0709040447220.31808@shell4.speakeasy.net>
	<1188914079.6535.47.camel@areia> <s5hr6leyy0r.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709041339540.31808@shell4.speakeasy.net>
	<1188975275.6158.34.camel@areia>
	<Pine.LNX.4.58.0709050120490.31808@shell4.speakeasy.net>
	<s5h3axtv30n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 97D5F1038D0
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 12:32:29 +0200 (CEST)
In-Reply-To: <s5h3axtv30n.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>, alsa-devel@alsa-project.org, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org


> Well, at first I misunderstood that we would share the PCI SSIDs
> together with enum items.  Sharing only the enum items doesn't give
> much improvements.  Sharing the card database may do, though.
> 
> So, I see Trent's point.  The merge work wouldn't pay for the benifit
> by sharing only the enum id, not the card database.

I like the idea of sharing the database. This probably will mean that
snd_bt87x would be dependent of bttv driver (or a bttv core driver).
This have the advantage of helping also to fix some conflicts with dvb
bttv driver.

This change, if agreed by all, will require some extra work. The better
is to commit Trent's patch first. Then, we can work on re-designing bttv
driver in a way that the database can be shared, without needing to load
the entire bttv drive.

Probably, we should first push the bttv v4l2 series of patches before
starting this change at bttv.

-- 
Cheers,
Mauro
