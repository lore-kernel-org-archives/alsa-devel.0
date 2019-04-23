From: =?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Subject: Re: [PATCH] ASoC: rt1308: Add RT1308 amplifier driver
Date: Tue, 23 Apr 2019 13:39:59 +0000
Message-ID: <BC6F7617C38F3E4E8CA887E07B35B828011660AC@RTITEXDAG02.realtek.com.tw>
References: <20190416022246.10121-1-derek.fang@realtek.com>
 <20190416153510.GE4834@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B8280116192E@RTITMBSVM07.realtek.com.tw>
 <20190417150518.GB5703@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4265EF8070C
 for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2019 15:40:07 +0200 (CEST)
In-Reply-To: <20190417150518.GB5703@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, "bard.liao@intel.com" <bard.liao@intel.com>, =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> 
> On Wed, Apr 17, 2019 at 11:40:28AM +0000, Derek wrote:
> 
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
> 
> > > The ones here with comments look an awful lot like they're system
> > > specific config which should be left up to either platform data (or
> > > DT/ACPI configuration) or done at runtime (like gains).  Some of the
> > > others like the pads configuration might also fit into that.
> 
> > We don't open the DA gain setting for user at runtime, so have to set
> > a default level in the init list.
> 
> That's not the way Linux drivers generally work...  is there some technical reason
> for that or is it just some kind of policy decision?

Maybe I could add a gain control for the user and set the gain to safety max level in init list for speaker protection.

> 
> > > > +static void rt1308_reset(struct regmap *regmap) {
> > > > +	regmap_write(regmap, RT1308_RESET, 0); }
> > >
> > > If we do need the init list shouldn't we also do a reninit every time we do a
> reset?
> 
> > The init list is only set at driver probe, not every time after resetting.
> 
> This is what I'm pointing out; if you don't restore these values then why set them
> at all?

OK, I could reinit after every time resetting.

> ------Please consider the environment before printing this e-mail.
