From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Output frequency configuration for I2S in
	beagleboard? (underrun problem)
Date: Wed, 13 May 2009 13:41:57 +0300
Message-ID: <200905131341.57717.peter.ujfalusi@nokia.com>
References: <fb44c3530905121628i56a92ea8x10f966b7aa4ebc00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id ACC94247AF
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 12:42:03 +0200 (CEST)
In-Reply-To: <fb44c3530905121628i56a92ea8x10f966b7aa4ebc00@mail.gmail.com>
Content-Disposition: inline
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
Cc: ext Ernesto Torres <skullmate@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 13 May 2009 02:28:58 ext Ernesto Torres wrote:
> Hi,
>
> I would like to know the actual configuration for the output of the Beagle
> Board I2S, from the OMAP35x Reference Manual, on page 2887:

Is you external codec supports master mode (provides the needed clocks on t=
he =

I2S bus)?
I would suggest to use it in that way, since configuring OMAP to provide cl=
ose =

enough frequency can be tricky.
I have did this for experimenting on our custom board, just to see how it =

works.
This is the code is taken from the soc board file's hw_params function:

div =3D clk_id =3D freq =3D 0;
switch (params_rate(params)) {
case 44100: /* 44.117 */
	div =3D 68;
	clk_id =3D OMAP_MCBSP_SYSCLK_CLKS_FCLK;
	freq =3D 96000000;
	break;
case 48000: /* 48.032 */
	div =3D 54;
	clk_id =3D OMAP_MCBSP_SYSCLK_CLK;
	freq =3D 83000000;
	break;
default:
	printk(KERN_ERR "hw params: unknown rate %d\n",
		params_rate(params));
	return -EINVAL;
}

ret =3D snd_soc_dai_set_sysclk(cpu_dai, clk_id, freq, SND_SOC_CLOCK_IN);
if (ret < 0) {
	printk(KERN_ERR "can't set cpu system clock\n");
	return ret;
}

ret =3D cpu_dai->dai_ops.set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, div);
if (ret < 0) {
	printk(KERN_ERR "can't set cpu clock divider\n");
}

As you can see I needed to select different clock source for 44.1 and 48 KH=
z =

sample rate for OMAP to use as a base for the dividing...

So: try to use the OMAP as slave, if it is possible.

-- =

P=E9ter
