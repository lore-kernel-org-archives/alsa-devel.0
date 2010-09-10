From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG: Modify the
 name of I2S driver
Date: Fri, 10 Sep 2010 10:39:27 +0100
Message-ID: <20100910093926.GB3068@rakim.wolfsonmicro.main>
References: <4C4CEDE1.5010605@samsung.com>
	<B9F57799-417E-4006-80D4-7768EE347BF5@opensource.wolfsonmicro.com>
	<AANLkTi=20B0K+87HeRjdKAONVjwEhar09QRmj-SB2zbO@mail.gmail.com>
	<AANLkTimV+mJF_Qz2JvDcAUc+pApVApFQMHkLK32w+MWp@mail.gmail.com>
	<1280141088.3072.33.camel@odin>
	<AANLkTi=5JvZup0c9xXrgYkFszLd_T-wPbPZnuu4bRQ9W@mail.gmail.com>
	<20100907153902.GC8678@rakim.wolfsonmicro.main>
	<AANLkTi=h5wGxrkLqYb0+HzZ-zHFe=UhpfBqOLT36G3fr@mail.gmail.com>
	<20100909132259.GF25855@rakim.wolfsonmicro.main>
	<AANLkTimV8hQ6L2j2djDdCp6XJGDj3Hjq2Dv4iLnGJHQ1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5DD0D10396D
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 11:39:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimV8hQ6L2j2djDdCp6XJGDj3Hjq2Dv4iLnGJHQ1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Kyungmin Park <kmpark@infradead.org>, Joonyoung Shim <jy0922.shim@samsung.com>, "jassi.brar@samsung.com" <jassi.brar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, ben-linux <ben-linux@fluff.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 05:43:14PM +0900, Jassi Brar wrote:

> It's I2S that's PITA.
> I am thinking of leaving 24xx-i2s, i.e pre-64xx(shared with 2412),
> unchanged and letting
> them die of old age (obsoleted and dropped duly if no stakeholder keeps up).

This seems resonable; there is a reasonable degree of interest in them
so probably the community support will keep them going.

> I plan to categorize the newer I2S blocks into i2s_v2(s3c2412),
> i2s_v3(v2 with minor variation in
> reg field order), i2s_v4 (v3 plus 5.1 channel support) and v5 (v4 plus
> Secondary Stereo-Channel
> for h/w mixing support).  A new flag 'version' in 'struct
> s3c_audio_pdata' passed via
> platform_data can be used to differentiate quirks and features
> run-time in a single CPU driver.

As I've said in the past the concern I have with all this stuff is that
outside of Samsung there's no documentation of the IIS block versions or
their relationships, the only references I've seen to versions have been
for chips with multiple versions (like the 6410) and there it's just a
mention that versions exist and the register documentation is completely
cut'n'pasted.  It would be good if you could make sure that any platform
data for identifying the versions is sufficiently clear to allow someone
to go from datasheet to knowing which IP version they have.
