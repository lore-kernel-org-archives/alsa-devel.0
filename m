From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2]ASoC:blackfin:add ad73311 card driver
	name
Date: Fri, 16 Sep 2011 10:47:11 +0100
Message-ID: <20110916094710.GK22062@opensource.wolfsonmicro.com>
References: <1315940366-20515-1-git-send-email-scott.jiang.linux@gmail.com>
	<20110913105328.GA11214@opensource.wolfsonmicro.com>
	<CAHG8p1CUveaYFkE+=FOZhTpPoKXTWB3UdTJpwtDq8pGTp17CzQ@mail.gmail.com>
	<20110915100036.GC7988@opensource.wolfsonmicro.com>
	<CAHG8p1B9Oxx5Td_qxdC=eWBsKSuio+1izi2w1izDf0w3A6ffnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 040B810385F
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 11:47:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHG8p1B9Oxx5Td_qxdC=eWBsKSuio+1izi2w1izDf0w3A6ffnw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 11:53:16AM +0800, Scott Jiang wrote:
> 2011/9/15 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Wed, Sep 14, 2011 at 11:27:28AM +0800, Scott Jiang wrote:

> >> in alsa lib snd_config_hook_load_for_all_cards(), use
> >> sndrv_ctl_card_info->driver to determine card config,
> >> not sndrv_ctl_card_info->name, though card name contains enough info.

> > So the issue isn't that the driver doesn't have a name, it's that you
> > don't like the name it was given.

> Do you mean alsa lib needs to modify its way to determine which card
> config to load?
> I don't think alsa lib guys will agree.

Well, that's one option.

> >The changelog needs to explain this,
> > and also explain why this is an issue in this one driver.

> Not only for this one driver, it's a problem for all drivers under
> asoc. Because sndrv_ctl_card_info->driver is an empty string now.

So if that's the case then it seems very clear that a driver specific
change isn't a good way of addressing the issue.  If the driver name is
null it actually seems like modifying userspace should be very easy, we
simply need to fall back to reading the card name if the driver name is
empty.

> > This sounds like you should fix userspace. =A0It does go back to the is=
sue
> > I regularly raise with the Blackfin code constantly assuming that there
> > can be a single driver which covers all combinations of a Blackfin CPU
> > with a given CODEC.

> As I have said it was caused by ASoC before. It is not a guilt of blackfi=
n.
> All drivers under ASoC must name their card config the same as their
> codec driver's name because asoc copy codec name to snd_card->driver
> and alsa lib get it through sndrv_ctl_card_info->driver. They must
> match.

Right, but if the Blackfin community had been alert to the idea that not
all machines using a given CODEC are the same it should have been
obvious that this was a poor identifier to use for this and something
was wrong.

> Now ASoC doesn't copy codec name to snd_card->driver so we can rename
> it to bfin-ad73311 if you like this kind of name style.

No, doing something that requires updates to every single machine driver
isn't good (unless you're going to go through and update every one of
them I guess, but even then it's not great).
