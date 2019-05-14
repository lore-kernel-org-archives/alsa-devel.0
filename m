From: =?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Subject: Re: [PATCH] ASoC: rt1308: Add RT1308 amplifier driver
Date: Tue, 14 May 2019 11:10:58 +0000
Message-ID: <BC6F7617C38F3E4E8CA887E07B35B82805B14BFF@RTITMBSVM07.realtek.com.tw>
References: <20190416022246.10121-1-derek.fang@realtek.com>
 <20190416153510.GE4834@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B8280116192E@RTITMBSVM07.realtek.com.tw>
 <20190417150518.GB5703@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B828011660AC@RTITEXDAG02.realtek.com.tw>
 <20190508064537.GN14916@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B1144E@RTITMBSVM07.realtek.com.tw>
 <20190512080621.GH21483@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B13EE2@RTITMBSVM07.realtek.com.tw>
 <20190513145608.GA5168@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 230BEF806E5
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2019 13:11:06 +0200 (CEST)
In-Reply-To: <20190513145608.GA5168@sirena.org.uk>
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

> Subject: Re: [PATCH] ASoC: rt1308: Add RT1308 amplifier driver
> 
> On Mon, May 13, 2019 at 01:54:08PM +0000, Derek wrote:
> 
> > > I'm confused about what this limit is - is it just some arbatrary limit
> > > imposed in case some board has problems or is it an actual limit that
> > > comes from the chip?  If it's a "just in case" limit then the board
> > > should be the one doing the limiting, yes people can break things but
> > > it's difficult to get decision like that done sensibly in the CODEC
> > > driver in a way that works for everything and the general expectation is
> > > that this is all for use by system integrators rather than end users.
> 
> > It is an actual limit that comes from the chip.
> 
> If there is an actual limit in the chip the driver just shouldn't expose
> anything beyond what that limit is - the original thing I was calling
> out was that you're just hard coding a value for this setting into the
> driver, that just means that the expectation is that the values should
> be user settable within whatever the chip can support.  If there's
> settings that can't be supported at all the driver doesn't need to
> pretend to offer them.

I could remove comment for the limit setting in register patch/init list
to avoid users or integrators have any expectation.
And also there will not be any support at all the driver according to the
limit setting.
 
> ------Please consider the environment before printing this e-mail.
