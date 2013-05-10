From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH v5 2/2] ASoC: sgtl5000: Fix driver probe
	after reset
Date: Fri, 10 May 2013 13:13:52 -0700
Message-ID: <518D5500.4050101@boundarydevices.com>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
 <1368144947-23775-2-git-send-email-festevam@gmail.com>
 <518C4A8E.6020501@boundarydevices.com>
 <CAOMZO5AoWqhSdH5WVu=TFgejis=8mWNGYyHneRc5idwCd8RZWA@mail.gmail.com>
 <518D4660.9070202@boundarydevices.com> <518D4781.30507@boundarydevices.com>
 <CAOMZO5Dj83WqD2tQBQDBz9FzvLQGyuv-4yvb4gwL=rRq6DxPuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 by alsa0.perex.cz (Postfix) with ESMTP id B2855261688
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 22:13:56 +0200 (CEST)
Received: by mail-pb0-f45.google.com with SMTP id mc8so1114045pbc.18
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 13:13:55 -0700 (PDT)
In-Reply-To: <CAOMZO5Dj83WqD2tQBQDBz9FzvLQGyuv-4yvb4gwL=rRq6DxPuw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 5/10/2013 12:18 PM, Fabio Estevam wrote:
> On Fri, May 10, 2013 at 4:16 PM, Troy Kisky
> <troy.kisky@boundarydevices.com> wrote:
>
>> Since Sabrelite uses "dummy" regulators (always on), have you tested with a
>> boards that
>> actually uses regulators?
> I don't have any board that drives the sgtl5000 power supplies from a
> PMIC, for example.
>
>> I would think that some regulators would need to be on before you could even
>> read
>> the ID register.
> Sure. That's why I placed the ID reading after turning on the regulators :-)
>
Hmm. Maybe I need some remedial classes. This is what the flow looks 
like to me.

sgtl5000_i2c_probe
	regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
         snd_soc_register_codec(&client->dev,&sgtl5000_driver, &sgtl5000_dai, 1);

	sgtl5000_probe
		sgtl5000_enable_regulators
