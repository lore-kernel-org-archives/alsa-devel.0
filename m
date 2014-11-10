From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 3/4] ASoC: simple-card: add multi-CODECs in DT
Date: Mon, 10 Nov 2014 10:04:54 +0100
Message-ID: <88485116.3X2aHuesdU@wuerfel>
References: <cover.1415605716.git.moinejf@free.fr> <3271244.uSgBKXChSS@wuerfel> <20141110100526.76790f55@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141110100526.76790f55@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Monday 10 November 2014 10:05:26 Jean-Francois Moine wrote:
> On Mon, 10 Nov 2014 09:39:57 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Sunday 09 November 2014 12:22:21 Jean-Francois Moine wrote:
> > > -- sound-dai                            : phandle and port of CPU/CODEC
> > > +either
> > > +  - sound-dai                          : phandle and port of CPU/CODEC
> > > +or
> > > +  - sound-dais                         : list of phandle and port of CODECs
> > 
> > Is it really necessary to change the property name here? I woudl think
> > that you can make it all work more consistently with just the existing
> > 'sound-dai' property, just extend it to allow multiple codecs
> 
> This was an idea from Benoit Cousson:
> 
>  "Something like that:
> 
>    sound-dais = <&spdif_codec 1>, <&hdmi 0>;
> 
>  That being said, it will require changing the name with a plural form,"
> 
> As I coded it, both names are accepted for a single or many codecs.

I don't see a strong reason for coming up with a plural form. If you really
have to, then please list the old form as a deprecated alias and make the
document talk about "sound-dais" as the preferred form independent of the
number of arguments.

	Arnd
