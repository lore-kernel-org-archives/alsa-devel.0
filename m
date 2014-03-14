From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Fri, 14 Mar 2014 09:38:20 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D739CDD9@RTITMBSV03.realtek.com.tw>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
 <5320CE8C.8090608@metafoo.de>
 <ABFD875FF5FB574BA706497D987D48D7398652@RTITMBSV03.realtek.com.tw>
 <53216DDC.9090502@metafoo.de> <s5h61nizdj5.wl%tiwai@suse.de>
 <20140313192902.GL366@sirena.org.uk> <s5hzjkteufy.wl%tiwai@suse.de>
 <20140313204323.GM366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id E8406265177
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 10:38:35 +0100 (CET)
In-Reply-To: <20140313204323.GM366@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, March 14, 2014 4:43 AM
> To: Takashi Iwai
> Cc: Lars-Peter Clausen; Bard Liao; Oder Chiou; alsa-devel@alsa-project.org;
> lgirdwood@gmail.com; Gustaw Lewandowski; Flove
> Subject: Re: [alsa-devel] [PATCH v5] ASoC: add RT286 CODEC driver
> 
> On Thu, Mar 13, 2014 at 09:04:49PM +0100, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > > We don't really *need* the cache, it just makes it easier to do
> > > resume and gives a bit of a performance boost.
> 
> > Well, the caching isn't just a bit.  Without caching, you'd have to
> > whip the sound hardware powered up/down at each time querying the
> > current mixer value.
> 
> Realistically most hardware can't actually do that - there's a couple of the
> idle_bias_off devices that have built in LDOs which can but it's relatively
> unusual to be able to remove enough power to loose register I/O (and in any
> case you wind up needing to cache the values per control or something in
> order to do system suspend).

Mark,

What's your suggestion of the I/O part of rt286 codec driver?
Can I keep using regmap without using its cache?
Or it is better not using regmap in this driver?

Thanks.

> 
> ------Please consider the environment before printing this e-mail.
