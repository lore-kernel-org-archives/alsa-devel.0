From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re:
	=?iso-8859-1?q?=5BRFC_PATCH_v2_0/5=5D_snd-ice1712=3A?=
	=?iso-8859-1?q?_Add_Philips_PSC724=09Ultimate_Edge?=
Date: Wed, 19 Sep 2012 23:48:29 +0200
Message-ID: <201209192348.30440.linux@rainbow-software.org>
References: <1347994716-10251-1-git-send-email-linux@rainbow-software.org>
 <201209191903.14690.linux@rainbow-software.org>
 <s5hhaqtopxk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A85D265228
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 23:49:08 +0200 (CEST)
In-Reply-To: <s5hhaqtopxk.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 19 September 2012 19:58:15 Takashi Iwai wrote:
> At Wed, 19 Sep 2012 19:03:14 +0200,
>
> Ondrej Zary wrote:
> > On Wednesday 19 September 2012 17:28:21 Takashi Iwai wrote:
> > > At Tue, 18 Sep 2012 20:58:31 +0200,
> > >
> > > Ondrej Zary wrote:
> > > > Hello,
> > > > this is second attempt to add Philips PSC724 Ultimate Edge sound card
> > > > support to snd-ice1712 driver. Unlike other snd-ice1712 subdrivers,
> > > > the codec code is splitted into separate modules and thus reusable by
> > > > other ice1712 subdrivers.
> > >
> > > Well, the problem is that most of ice17xx boards use only a part of
> > > channels on codecs.   Thus you don't want to expose controls for all
> > > channels, too.  Otherwise user will get confusing dead controls.
> >
> > The controls can be easily hidden by setting its name to NULL. It's even
> > used in the psc724 subdriver.
> >
> > > If these new modules are supposed to be used by other ice1712/ice1724
> > > sub drivers, they should provide some good binding mechanism, too.
> > > (And that's one of the good reasons why ASoC has been nominated.)
> >
> > They're easy to use, you just need to provide wm87x6_write() function. I
> > think that other subdrivers could be easily converted to use this (with
> > hardware to test).
>
> OK, but I'd like to have modules only when the code sharing happens.
> Also, it'd be better to have different module names, indicating that
> they are ice17xx-specific.

OK, I'll change the code to not produce modules.

> > > > Working: all analog outputs (front, rear, center+lfe, headphone) and
> > > > inputs (front mic, rear mic, line, cd, aux), mixer, headphone jack
> > > > detection, suspend/resume
> > > >
> > > > Currently untested: SPDIF
> > > >
> > > > Buggy: switching AGC mode in mixer causes alsamixer to crash - looks
> > > > like it does not like notifications about control
> > > > activating/deactivating

What about this? Is it a bug in my code or somewhere else?

-- 
Ondrej Zary
