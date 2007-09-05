From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] Improved support for	different bt87x	board
 configurations
Date: Wed, 5 Sep 2007 15:34:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709051523390.31808@shell4.speakeasy.net>
References: <Pine.LNX.4.58.0708300319210.18152@shell4.speakeasy.net>
	<s5h3ay1i8rs.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709021603380.18152@shell4.speakeasy.net>
	<1188801407.6762.1208578117@webmail.messagingengine.com>
	<Pine.LNX.4.58.0709040447220.31808@shell4.speakeasy.net>
	<1188914079.6535.47.camel@areia> <s5hr6leyy0r.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709041339540.31808@shell4.speakeasy.net>
	<1188975275.6158.34.camel@areia>
	<Pine.LNX.4.58.0709050120490.31808@shell4.speakeasy.net>
	<s5h3axtv30n.wl%tiwai@suse.de> <1188988371.6158.43.camel@areia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.sea5.speakeasy.net (mail2.sea5.speakeasy.net
	[69.17.117.4]) by alsa0.perex.cz (Postfix) with ESMTP id F11B91038CB
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 00:34:50 +0200 (CEST)
In-Reply-To: <1188988371.6158.43.camel@areia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux and Kernel Video <video4linux-list@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Sep 2007, Mauro Carvalho Chehab wrote:
> > Well, at first I misunderstood that we would share the PCI SSIDs
> > together with enum items.  Sharing only the enum items doesn't give
> > much improvements.  Sharing the card database may do, though.
> >
> > So, I see Trent's point.  The merge work wouldn't pay for the benifit
> > by sharing only the enum id, not the card database.
>
> I like the idea of sharing the database. This probably will mean that
> snd_bt87x would be dependent of bttv driver (or a bttv core driver).
> This have the advantage of helping also to fix some conflicts with dvb
> bttv driver.

I see how that could be an improvement.  Now the bt87x driver has a
whitelist of cards with sound and a blacklist of cards with DVB, while the
bt878 DVB driver has the exact opposite lists.  Except the two driver's
lists aren't in sync of course.

The cx88 driver keeps the database in the core module.  One drawback is
that the database can't be __initdata, as it has to stick around after the
core module is loaded so the other drivers that are loaded later can get at
it.  Of course, __initdata doesn't do any for most configurations and it's
not that big of a drawback in practice.
