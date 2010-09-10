From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: multi-component: SAMSUNG: Modify the
 name of I2S driver
Date: Fri, 10 Sep 2010 13:05:20 +0100
Message-ID: <20100910120520.GM7259@rakim.wolfsonmicro.main>
References: <AANLkTi=20B0K+87HeRjdKAONVjwEhar09QRmj-SB2zbO@mail.gmail.com>
	<AANLkTimV+mJF_Qz2JvDcAUc+pApVApFQMHkLK32w+MWp@mail.gmail.com>
	<1280141088.3072.33.camel@odin>
	<AANLkTi=5JvZup0c9xXrgYkFszLd_T-wPbPZnuu4bRQ9W@mail.gmail.com>
	<20100907153902.GC8678@rakim.wolfsonmicro.main>
	<AANLkTi=h5wGxrkLqYb0+HzZ-zHFe=UhpfBqOLT36G3fr@mail.gmail.com>
	<20100909132259.GF25855@rakim.wolfsonmicro.main>
	<AANLkTimV8hQ6L2j2djDdCp6XJGDj3Hjq2Dv4iLnGJHQ1@mail.gmail.com>
	<20100910093926.GB3068@rakim.wolfsonmicro.main>
	<AANLkTik1eexiDM994Lak_acfGvgz+4VN2-CJSAY5M3M6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7F5211039D2
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 14:05:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTik1eexiDM994Lak_acfGvgz+4VN2-CJSAY5M3M6@mail.gmail.com>
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

On Fri, Sep 10, 2010 at 08:32:46PM +0900, Jassi Brar wrote:
> On Fri, Sep 10, 2010 at 6:39 PM, Mark Brown
> > On Fri, Sep 10, 2010 at 05:43:14PM +0900, Jassi Brar wrote:

> > As I've said in the past the concern I have with all this stuff is that
> > outside of Samsung there's no documentation of the IIS block versions or
> > their relationships, the only references I've seen to versions have been
> > for chips with multiple versions (like the 6410) and there it's just a
> > mention that versions exist and the register documentation is completely

> > cut'n'pasted.
> All this info could be gotten by comparing the I2S chapters of relevant
> SoCs... which is what I do.
> I don't have any special documentation either.... there is none.
> The only luxury I have is to be able to get clarifications via
> appropriate channels of info.

You appear to be at least aware of the versions :)  Most of us were
going on naming based on CPU names.

> > =A0It would be good if you could make sure that any platform
> > data for identifying the versions is sufficiently clear to allow someone
> > to go from datasheet to knowing which IP version they have.

> Actually I plan to use enum for I2S types and assign them alongside
> platform_device
> definition of I2S blocks and their platform_data.
> Any I2S block that matches register description of 2-channel block of
> 6410 is v3,
> that with 5.1 is v4 and that with 5.1 of C100 is v5.

Including a listing of the registers you look at when doing the
comparison would be useful here - some sort of flow chart to work
through, for example.  Bear in mind that the datasheets for the CPUs
aren't (all?) public either so people might not be able to look at the
register maps for older CPUs if they only have the datasheet for the CPU
they have been working on.

> There are no differentiating IDs to be read from any register.

Yup, I'm aware of this.
