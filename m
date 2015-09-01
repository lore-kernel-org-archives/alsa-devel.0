From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: SSM2518 Device Tree support ?
Date: Tue, 1 Sep 2015 09:06:03 +0200
Message-ID: <alpine.DEB.2.02.1508311753050.4816@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1508131400010.27635@lnxricardw1.se.axis.com>
 <55CC8BE0.4000406@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DC4B261AE4
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 09:06:16 +0200 (CEST)
In-Reply-To: <55CC8BE0.4000406@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Bringing up an old thread becuase i have a similar issue with the =

adau1761-i2c.c driver which should be configurable in the same way - it =

links into the I2C driver framework too. I know my ssm2518.c patch was =

recently applied, but using this driver (prior to the patch) as an =

example as Lars-Peter mentioned that it should be able to work this way.

On Thu, 13 Aug 2015, Lars-Peter Clausen wrote:

> [ ... device tree support in ssm2518.c ... ]
> What's not in the driver is a explicit of match table. It will work witho=
ut
> since the I2C subsystem supports matching based on the I2C ID table.

How does this actually work? I've tried to figure it out but haven't =

gotten anywhere.

From:

http://wiki.analog.com/resources/tools-software/linux-drivers/sound/ssm2518=
 :


i2s: i2c@41600000 {
	compatible =3D "...;
	...

	#size-cells =3D <0>;
	#address-cells =3D <1>;
            =

	ssm2518: ssm2518@34 {
		compatible =3D "adi,ssm2518";
		reg =3D <0x34>;
		gpios =3D <&gpio 5 0>;
	};
};


In codecs/ssm2518.c:


static const struct i2c_device_id ssm2518_i2c_ids[] =3D {
        { "ssm2518", 0 },
        { }
};
MODULE_DEVICE_TABLE(i2c, ssm2518_i2c_ids);

static struct i2c_driver ssm2518_driver =3D {
        .driver =3D {
                .name =3D "ssm2518",
                .owner =3D THIS_MODULE,
        },
        .probe =3D ssm2518_i2c_probe,
        .remove =3D ssm2518_i2c_remove,
        .id_table =3D ssm2518_i2c_ids,
};
module_i2c_driver(ssm2518_driver);


So how does the i2c framework ultimately get the ssm2518 probe function to =

be called? The only real ID here are the strings "ssm2518" but they don't =

show up in the DT entry, except as part of the ssm2518 compatible string.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
