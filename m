From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: dmic codec: Support for DT
Date: Wed, 09 May 2012 14:28:23 +0300
Message-ID: <4FAA54D7.3090604@ti.com>
References: <1336478157-27526-1-git-send-email-peter.ujfalusi@ti.com>
	<20120508125837.GN15893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id DA39624562
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 14:34:47 +0200 (CEST)
Received: by laap9 with SMTP id p9so194866laa.8
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2012 05:34:45 -0700 (PDT)
In-Reply-To: <20120508125837.GN15893@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 05/08/2012 03:58 PM, Mark Brown wrote:
> On Tue, May 08, 2012 at 02:55:57PM +0300, Peter Ujfalusi wrote:
> =

>> +dmic_codec: dmic_codec@0 { /* generic DMIC codec */
>> +	compatible =3D "generic,dmic-codec";
>> +};
> =

> Why is this called "dmic-codec" and not "dmic"?

This is a really good question. Should have been "dmic".

> We probably need to have a think about this in the context of the
> handling of random on-board passive components in general - things
> like jacks and so on - is the most sensible thing to have a
> platform device for everything, or is that getting too noisy?

It is true that there's no real device (in a sense that it is not
programmable at least via the current dmic-codec.c driver) behind of the
dmic codec as such.
However in our setup it is a vital part of the audio setup since the CPU
dai (omap4-dmic) need to be connected to _somthing_ in order to have a link.
It could be argued that if the SW has no control over a component there
should not be dts section for it either. However when we move to the
audio machine driver level (or audio setup description) we are going to
have quiet different looking (I would say confusing) implementation
among devices, platforms.

For example tegra-seaboard have this for the link:

nvidia,i2s-controller =3D <&tegra_i2s1>;
nvidia,audio-codec =3D <&wm8903>;

It is clearly tells me that i2s1 is connected to wm8903 codec.

Now without dts entry for dmic codec on omap4:

dai-link,dai =3D <&dmic>;

In the background we create the device for the dmic at runtime but it
does not help the readability of the dts file. Especially if someone is
looking at the tegra version at the same type.

I would prefer to have something like this in our dts for audio support:

dai-link,dai =3D <&dmic>;
dai-link,codec =3D <&dmic_codec>;


I might be as well just plain wrong here.

-- =

P=E9ter
