From: Alex Austin <circuitsoft.alex@gmail.com>
Subject: Re: Trying to get unsupported CODEC to work
Date: Thu, 5 Nov 2009 03:15:52 -0600
Message-ID: <53baa24a0911050115h4ef8cecfjff733dd06c801a7f@mail.gmail.com>
References: <53baa24a0812111428j143c23berb8ba0819b6b55eac@mail.gmail.com>
	<s5hd4fxdgf7.wl%tiwai@suse.de>
	<53baa24a0812120054u6c605987seba0d3066b2d5fa7@mail.gmail.com>
	<s5h1vwdd9xl.wl%tiwai@suse.de>
	<53baa24a0812120129q609e567bjf2286060d7f25da7@mail.gmail.com>
	<s5hy6ylbux6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AD6F1038FC
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 10:15:53 +0100 (CET)
Received: by pwj16 with SMTP id 16so1869744pwj.32
	for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2009 01:15:53 -0800 (PST)
In-Reply-To: <s5hy6ylbux6.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I know this thread is ancient, but the question has come to my forefront
again, so I'll see if I can ask it better now.

On Fri, Dec 12, 2008 at 3:23 AM, Takashi Iwai <tiwai@suse.de> wrote:

> Alex Austin wrote:
> >
> > Shoot. The DAE-3 is a controller for a 5-CH Amplifier card driving
> > speakers directly, but I still need the subwoofer output from the ALC888.
> I
> > may be able to get by without the ALC using high-level inputs on the sub
> amp.
> > Even without it, what do I need to do to enable the DAE-3? I'm
> comfortable in
> > C, but I don't know ALSA much, if at all, yet.
>
> The codec parser isn't present for DAE-3, and the generic parser
> obviously doesn't work for it.  So, you need to create a new codec
> parser such as other patch_*.c.
>
> Takashi
>
>
Since the output of codecgraph looks pretty simple, what codec
parser would you recommend starting with as a base?


On Fri, Dec 12, 2008 at 1:02 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 11 Dec 2008 16:28:28 -0600,
> Alex Austin wrote:
> >
> > Hello,
> > I have an MSI Media Live DIVA motherboard. It has an AMD SB600 HD
> > Audio controller, and two CODECs on the HDA bus.
> >
> > First is an ALC888
> > Second is an Intersil DAE-3.
>
> The analog outputs on both codecs are really used at the same time?
> Then it doesn't work right now.  Simply "not implemented".  And no
> concrete plan to fix it yet.  This might require a fundamental
> re-design.
>
>
> Takashi
>

Is this still the case? Structurally, why can't this be supported now?

Thanks much,
- Alex Austin
