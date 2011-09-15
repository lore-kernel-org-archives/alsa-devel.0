From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2]ASoC:blackfin:add ad73311 card driver
	name
Date: Thu, 15 Sep 2011 11:00:37 +0100
Message-ID: <20110915100036.GC7988@opensource.wolfsonmicro.com>
References: <1315940366-20515-1-git-send-email-scott.jiang.linux@gmail.com>
	<20110913105328.GA11214@opensource.wolfsonmicro.com>
	<CAHG8p1CUveaYFkE+=FOZhTpPoKXTWB3UdTJpwtDq8pGTp17CzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3332010393F
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 12:00:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHG8p1CUveaYFkE+=FOZhTpPoKXTWB3UdTJpwtDq8pGTp17CzQ@mail.gmail.com>
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

On Wed, Sep 14, 2011 at 11:27:28AM +0800, Scott Jiang wrote:
> 2011/9/13 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Tue, Sep 13, 2011 at 02:59:26PM -0400, Scott Jiang wrote:

> > All my comments about the previous revision of the patch continue to
> > apply here. =A0The changlog doesn't explain the issue well (the driver
> > should already end up with a unique name)

> in alsa lib snd_config_hook_load_for_all_cards(), use
> sndrv_ctl_card_info->driver to determine card config,
> not sndrv_ctl_card_info->name, though card name contains enough info.

So the issue isn't that the driver doesn't have a name, it's that you
don't like the name it was given.  The changelog needs to explain this,
and also explain why this is an issue in this one driver.

> > and the name you've picked
> > is less distinctive than the existing name.

> I know the name is not good enough, but it is a historical result.
> Asoc copy codec name to card->driver before, cause all cards config
> file in alsa lib conf dir have this kind of name.

This sounds like you should fix userspace.  It does go back to the issue
I regularly raise with the Blackfin code constantly assuming that there
can be a single driver which covers all combinations of a Blackfin CPU
with a given CODEC.
