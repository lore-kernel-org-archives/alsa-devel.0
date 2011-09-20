From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] alsa-lib: if card driver name is empty
 string, use card name instead
Date: Tue, 20 Sep 2011 11:14:34 +0100
Message-ID: <20110920101434.GD2387@opensource.wolfsonmicro.com>
References: <1316538944-31853-1-git-send-email-scott.jiang.linux@gmail.com>
	<s5haa9zspcb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C376F103935
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 12:14:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5haa9zspcb.wl%tiwai@suse.de>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 20, 2011 at 08:24:52AM +0200, Takashi Iwai wrote:
> Scott Jiang wrote:

> > Some drivers don't have a card driver name, but they have a nice card name containing enough info.
> > So we can use card name to search card config if we found driver name is not valid.

> It's rather a bug of driver, no?
> I don't think we need to work around it.

This was introduced by your commit 873bd4 (ASoC: don't set invalid name
string to snd_card->driver field) which means we no longer provide a
driver name for any ASoC cards as they're all relying on using the card
name as the driver name.  We should be doing something like replacing '
' by '_' in the driver name we generate rather than just not generating
a name.

I have to confess I didn't review the patch at the time as it was
applied too quickly after it was mailed out for me to have a chance to
see it.  Sorry about that.
