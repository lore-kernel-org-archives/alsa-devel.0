From: "Hugo Villeneuve" <hugo.villeneuve@lyrtech.com>
Subject: Re: [PATCH] ARM DaVinci: Add Right-Justified mode and
	Codec clock master to davinci-i2s
Date: Mon, 10 Nov 2008 10:06:18 -0500
Message-ID: <42848A5C5A0D1E47B026E644DD49B08E02C45361@mail>
References: <1226168769-17776-1-git-send-email-hugo.villeneuve@lyrtech.com>
	<20081110114223.GB12804@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tomts45-srv.bellnexxia.net (tomts45.bellnexxia.net
	[209.226.175.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 41336243BB
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 16:07:08 +0100 (CET)
Received: from toip40-bus.srvr.bell.ca ([67.69.240.41])
	by tomts45-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20081110150642.OOCL22185.tomts45-srv.bellnexxia.net@toip40-bus.srvr.bell.ca>
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 10:06:42 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20081110114223.GB12804@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Sat, Nov 08, 2008 at 01:26:09PM -0500, hugo.villeneuve@lyrtech.com
> wrote: =

>> From: Hugo Villeneuve <hugo.villeneuve@lyrtech.com>
> =

>> ARM DaVinci: Add Right-Justified mode and Codec clock master to
>> davinci-i2s =

> =

> Not a big deal but you shouldn't repeat the subject line of your patch
> in the body - it causes automated tools like git am to duplicate it in
> the commit mesage.

That=B4s right. Thanks for the tip!

>> The TI DVEVM board uses the SND_SOC_DAIFMT_CBM_CFM & I2S formats,
>> but the Lyrtech SFFSDR board uses the SND_SOC_DAIFMT_CBM_CFS &
>> RIGHT-JUSTIFIED formats. =

> =

> Is there any news on the progress of the new DaVinci DMA API to
> mainline?

I=B4m not familiar with that, maybe someone from the DaVinci list can answe=
r.

Hugo V.

Hugo Villeneuve
Hardware developer | Concepteur mat=E9riel
Lyrtech
Phone/T=E9l. : (1) (418) 877-4644 #2395
Toll-free/Sans frais - Canada & USA : (1) (888) 922-4644 #2395
Fax/T=E9l=E9c. : (1) (418) 877-7710
www.lyrtech.com
Infinite possibilities...TM
