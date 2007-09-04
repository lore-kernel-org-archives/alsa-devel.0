From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] Improved support for different bt87x	board
 configurations
Date: Tue, 4 Sep 2007 14:04:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709041339540.31808@shell4.speakeasy.net>
References: <Pine.LNX.4.58.0708300319210.18152@shell4.speakeasy.net>
	<s5h3ay1i8rs.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709021603380.18152@shell4.speakeasy.net>
	<1188801407.6762.1208578117@webmail.messagingengine.com>
	<Pine.LNX.4.58.0709040447220.31808@shell4.speakeasy.net>
	<1188914079.6535.47.camel@areia> <s5hr6leyy0r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5]) by alsa0.perex.cz (Postfix) with ESMTP id 3901A2417B
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Sep 2007 23:04:55 +0200 (CEST)
In-Reply-To: <s5hr6leyy0r.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 4 Sep 2007, Takashi Iwai wrote:
> At Tue, 04 Sep 2007 14:54:39 +0100,
> Mauro Carvalho Chehab wrote:
> > > +       SND_BT87X_BOARD_HAUPPAUGE878,
> > > +       SND_BT87X_BOARD_OSPREY2x0,
> > > +       SND_BT87X_BOARD_OSPREY440,
> > > +       SND_BT87X_BOARD_ATI_TVWONDER,
> > > +       SND_BT87X_BOARD_WINFAST2000,
> > > +       SND_BT87X_BOARD_VOODOOTV_200,
> > > +       SND_BT87X_BOARD_AVPHONE98,
> >
> > Hmm... Maybe it would be a good idea to move the board numbers from
> > linux/drivers/media/video/bt8xx/bttv.h to a separate header (maybe
> > something like /include/media/bt8xx-cards.h) and use the same board IDs
> > for both -alsa and -v4l drivers.
> >
> > This will make easier to associate the audio and video parts for
> > troubleshooting and newer developments.
>
> Yes, it sounds like a good idea.

There are few drawbacks.

First, there are like 20x more cards supported by the bttv driver than by
the bt87x driver.  It's going to produce a very sparse card database in the
ALSA driver.  Note that for the most part, __initdata doesn't work, so you
can't say "it'll just be dropped after the driver loads."

Secondly, before this patch there was virtually no difference in the
configuration for the different supported cards.  After it, most of the
cards are still exactly the same.  It possible to re-use the same generic
configuration entry for most of the supported cards.  If you use the bttv
IDs, it's not.

And finally, bt87x is under ALSA but bttv is under linuxtv.  What would
include/media/bt8xx-cards.h be under, alsa or linuxtv?  Will people have to
submit patches to both projects (which use different repository formats
locally, so you can't just CC the same patch)?  I did one patch that
touched both linuxtv and alsa files, and it was a PITA, for a very simple
patch.  Took a month.  Emails to different people.  Merge conflicts.

And if both linuxtv and alsa use the same header, what happens if they
don't push the changes to GIT at the exact same time?  You'll have patches
in one subsystem that are dependant on the other subsystem.  How will they
make the same merge window?
