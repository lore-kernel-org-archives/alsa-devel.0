From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH] alsa-lib: if card driver name is empty
 string, use card name instead
Date: Tue, 20 Sep 2011 14:55:14 +0800
Message-ID: <CAHG8p1CdDzkCyVXNJE9SS3=5jK-250-2Kduxrya1_EGBjW=siw@mail.gmail.com>
References: <1316538944-31853-1-git-send-email-scott.jiang.linux@gmail.com>
	<s5haa9zspcb.wl%tiwai@suse.de>
	<CAHG8p1D=b9-1R6LkkO+39t41F3doGkCN8kPHn19gwif4r03JAg@mail.gmail.com>
	<s5h4o07sooa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 1160D103921
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 09:06:27 +0200 (CEST)
Received: by qyk32 with SMTP id 32so3285307qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2011 00:06:27 -0700 (PDT)
In-Reply-To: <s5h4o07sooa.wl%tiwai@suse.de>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

2011/9/20 Takashi Iwai <tiwai@suse.de>:
> At Tue, 20 Sep 2011 14:37:04 +0800,
> Scott Jiang wrote:
>>
>> 2011/9/20 Takashi Iwai <tiwai@suse.de>:
>> > At Tue, 20 Sep 2011 13:15:44 -0400,
>> > Scott Jiang wrote:
>> >>
>> >> Some drivers don't have a card driver name, but they have a nice card name containing enough info.
>> >> So we can use card name to search card config if we found driver name is not valid.
>> >>
>> >> Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
>> >
>> > It's rather a bug of driver, no?
>> > I don't think we need to work around it.
>> >
>> Mark said it's a bug of app..., he believes driver has provided enough
>> info in card name.
>
> No, the driver name should be set, too.
>
I agree with you, but my driver patch has been rejected by Mark.

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
