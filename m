From: Sven Zeisberg <sven.zeisberg@googlemail.com>
Subject: Problem to init AD1938 on i.MX25
Date: Mon, 16 Aug 2010 06:51:17 +0200
Message-ID: <4C68C3C5.5030701@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id CD3F9245DA
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 06:51:37 +0200 (CEST)
Received: by bwz10 with SMTP id 10so1796777bwz.38
	for <alsa-devel@alsa-project.org>; Sun, 15 Aug 2010 21:51:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  Hello,

we're working on an ALSA  driver for AD1938 for i.MX25 based system.
On the I=B2S the CODEC is Master. On the SPI, the MCU is Master.

SSI seems to work (when we set the CODEC as Master by Hardware).

We have problems to get the communication via SPI working. The CODEC =

requires 24Bit words and we can set SPI according to this in the =

board-file and verify this also with a logic analyzer. However, we can =

send only one word to the CODEC! This first word is transferred =

correctly, but all subsequent transfers show no activity on the SPI =

lines. We do not get any error messages from the SPI drivers! All SPI =

writes after the first word seem to be executed in software but show not =

effect in hardware. All reads return 0xff.

We assume that something with the set-up of the platform device is =

wrong: if we do not set the 24 Bit word size for each message, the SPI =

transfer is only 8 bit long - only when we set 24 bit in the =

spi_transfer struct for a transmission, the correct signals appear on =

the logic analyzer.

Could anybody point us to an example of platform device set-up for a =

similar CODEC on this MCU?
Are there known limitations of SPI transfers on the i.MX24 (like it can =

do only 8-Bit transfers)?

Any idea for further investigations would be highly appreciated...!

We have the following SPI / SSI set-up in the board file:

static struct pad_desc stk5_ad1938_pads[] =3D {
	MX25_PAD_RW__AUD4_TXFS,
	MX25_PAD_EB0__AUD4_TXD,
	MX25_PAD_EB1__AUD4_RXD,
	MX25_PAD_OE__AUD4_TXC,
};

static int stk5_ad1938_plat_init(void)
{
	int ret;
	DBG(0, "%s: \n", __FUNCTION__);
	ret =3D mxc_iomux_v3_setup_multiple_pads(stk5_ad1938_pads,
					ARRAY_SIZE(stk5_ad1938_pads));
	return ret;
}

static void stk5_ad1938_plat_finit(void)
{
	DBG(0, "%s: \n", __FUNCTION__);

	mxc_iomux_v3_release_multiple_pads(stk5_ad1938_pads,
					ARRAY_SIZE(stk5_ad1938_pads));
}

static struct mxc_audio_platform_data stk5_ad1938_data =3D {
	.ssi_num =3D 0,
	.src_port =3D 1,
	.ext_port =3D 4,
	.sysclk =3D 11289600,
	.init =3D stk5_ad1938_plat_init,
	.finit =3D stk5_ad1938_plat_finit,
};


static struct platform_device stk5_ad1938_device =3D {
	.name =3D "imx-ad1938",
	.dev =3D {
		.platform_data =3D&stk5_ad1938_data,
	},
};

static int __init stk5_ad1938_init(void)
{
		DBG(0, "%s: Registering device %s\n", __FUNCTION__,
			stk5_ad1938_device.name);
		return platform_device_register(&stk5_ad1938_device);
}
arch_initcall(stk5_ad1938_init);

static int stk5_spi_chipselect[] =3D {
	MXC_SPI_CS(0),
};

static struct pad_desc stk5_cspi1_pads[] =3D {
	MX25_PAD_CSPI1_MOSI__CSPI1_MOSI,
	MX25_PAD_CSPI1_MISO__CSPI1_MISO,
	MX25_PAD_CSPI1_SS0__CSPI1_SS0,
	MX25_PAD_CSPI1_SS1__CSPI1_SS1,
	MX25_PAD_CSPI1_SCLK__CSPI1_SCLK,
	MX25_PAD_CSPI1_RDY__CSPI1_RDY,
};

static struct spi_device ad1938_spi_chip_info =3D {
         .bits_per_word =3D 24,
};

static struct spi_board_info stk5_spi_info[] =3D {
     {
         .modalias =3D "ad1938",
		.max_speed_hz =3D 10000000,
		.bus_num =3D 0,
		.chip_select =3D 0,
		.controller_data =3D&ad1938_spi_chip_info,
		.mode =3D SPI_MODE_0,
	},
};

static struct spi_imx_master stk5_spi1_data =3D {
	.chipselect =3D stk5_spi_chipselect,
	.num_chipselect =3D ARRAY_SIZE(stk5_spi_chipselect),
};

static int __init stk5_spi_register(void)
{
	int ret;

	ret =3D mxc_iomux_v3_setup_multiple_pads(stk5_cspi1_pads,
					ARRAY_SIZE(stk5_cspi1_pads));
	if (ret) {
		printk(KERN_ERR "Failed to configure CSPI1 pads\n");
		return ret;
	}
	ret =3D spi_register_board_info(stk5_spi_info,
				ARRAY_SIZE(stk5_spi_info));
	if (ret) {
		printk(KERN_ERR "%s: Failed to register SPI board_info: %d\n",
			__FUNCTION__, ret);
		goto err;
	}
	ret =3D mxc_register_device(&mxc_spi_device0,&stk5_spi1_data);
	DBG(0, "%s: mxc_register_device() returned: %d\n", __FUNCTION__, ret);
	return 0;

err:
	mxc_iomux_v3_release_multiple_pads(stk5_cspi1_pads,
					ARRAY_SIZE(stk5_cspi1_pads));
	return ret;
}
device_initcall(stk5_spi_register);


And the following functino to write to the CODEC Registers:

static int ad1938_write_reg(struct snd_soc_codec *codec, unsigned int reg,
		unsigned int value)
{
	u8 *reg_cache =3D codec->reg_cache;
	int ret =3D 0;

	if (value !=3D reg_cache[reg]) {
		uint8_t buf[AD1938_SPI_BUFLEN];
		struct spi_transfer t =3D {
			.tx_buf =3D buf,
			.len =3D AD1938_SPI_BUFLEN,
			.bits_per_word =3D 24,
			.cs_change =3D 0,
		};
		struct spi_message m;

		buf[2] =3D AD1938_SPI_ADDR<<  1;
		buf[1] =3D reg;
		buf[0] =3D value;
		spi_message_init(&m);
		spi_message_add_tail(&t,&m);
		m.is_dma_mapped =3D0;
         printk(KERN_ERR "SPI-WRITE->Reg=3D %x, value=3D%x\n",reg,buf[2]);
		ret =3D spi_sync(codec->control_data,&m);
		printk(KERN_ERR "SPI-WRITE->Return %i\n",ret);
		if (ret =3D=3D 0)
			reg_cache[reg] =3D value;
	}

	return ret;
}


BR,
Sven Zeisberg
