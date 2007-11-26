From: "John Utz" <john.utz@dmx.com>
Subject: Re: [RFC] virtual master control (1/3)
Date: Mon, 26 Nov 2007 10:51:43 -0800
Message-ID: <20071126105143.097c045d@jutz-gnto64>
References: <472A113B.7030406@redhat.com>
	<200711161750.09647.maximlevitsky@gmail.com>
	<s5h7ikh6v2o.wl%tiwai@suse.de>
	<200711171236.32749.maximlevitsky@gmail.com>
	<s5hhcjilc87.wl%tiwai@suse.de> <s5hlk8oswjf.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0711231927030.8325@tm8103.perex-int.cz>
	<s5htzncnea0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id A049924894
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 19:51:59 +0100 (CET)
In-Reply-To: <s5htzncnea0.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 24 Nov 2007 11:12:07 +0100
"Takashi Iwai" <tiwai@suse.de> wrote:

> At Fri, 23 Nov 2007 19:36:32 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > On Fri, 23 Nov 2007, Takashi Iwai wrote:
> > 
> > > At Mon, 19 Nov 2007 12:13:28 +0100,
> > > I wrote:
> > > > 
> > > 
> > > OK, here is a series of the patch I promised.
> > > 
> > > The first one is the patch to add virtual master controls.
> > > 
> > > ===
> > > 
> > > [PATCH] Add virtual master control
> > > 
> > > This patch adds the routines to create virtual master controls.
> > > A virtual master control can have multiple slave controls that
> > > are supposed to be identical type.  The master volume will add the
> > > master attenuation and the master switch will add the master mute
> > > switch.
> > > 
> > > ---
> > 
> > I'm really not sure if I like to see such extensions in kernel. We
> > have now user control elements and a small daemon written in C or
> > python will do exactly same job and will be more flexible.

could you flesh this out a teeny bit more? I am interested in this
alternative, but my experiences of the last year with also dont make me
feel super optimistic about it.


> I've thought that a user-space solution would be appropriate, too.
> But, a requirement of a daemon is a very big disadvantage (I believe
> many people would dislike).  A plugin-based solution is another idea,
> but it's also complex and hard to implement consistently (because many
> mixer apps open "hw" device as default).
> 
> What I suggested is the implementation of a quite trivial master
> control.  Of course, it's not so flexible but it covers most of
> hardwares.   So much flexibility isn't needed in reality.  The
> convenience (for user and developer) is more important.

I strongly favor this approach. I am interested in learning more about
Jaroslav's daemon idea, but at this time it would need to really
pleasantly surprise me for me to feel like it would be a better idea.

FWIW, i would be strongly opposed to making it a plugin.
While i am very impressed with the technology of the plugin
architecture, it's need to have all sound apps linked with alsalib for
it to work poses significant complexity for both developers and users.

just my $us 0.02;

johnu

> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
