From: Ernesto Torres <skullmate@gmail.com>
Subject: Re: Output frequency configuration for I2S in
	beagleboard? (underrun problem)
Date: Wed, 13 May 2009 13:08:20 -0500
Message-ID: <fb44c3530905131108x20d309b7k244f5e26de711502@mail.gmail.com>
References: <fb44c3530905121628i56a92ea8x10f966b7aa4ebc00@mail.gmail.com>
	<200905131341.57717.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 57B361038BD
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 20:08:21 +0200 (CEST)
Received: by bwz11 with SMTP id 11so864490bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 11:08:20 -0700 (PDT)
In-Reply-To: <200905131341.57717.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
thanks for your replies, unfortunately, the codec has to be slave, it
doesn't support yet to send clock via i2s. I have another question, it might
be seem simple but it will clarify some of my thoughts.

>From omap3beagle.c hw_params:

*    /* Set the codec system clock for DAC and ADC */
    ret =3D snd_soc_dai_set_sysclk(codec_dai, 0, 26000000,
                     SND_SOC_CLOCK_IN);*

The sysclk is set to 26Mhz and it is coming from the TWL which acts as
master.

I had it configured to 12288000(info from datasheet) which was suppose to
work until I knew the codec I'm using can't be master. (It is still is on
12288000)

How should it be configured to make the OMAP Master? Should I leave it as
26Mhz and do manually all the divisions?
I'm using SND_SOC_DAIFMT_CBS_CFS for the Beagle.


Thank you for your help

BR,
Ernesto

On Wed, May 13, 2009 at 5:41 AM, Peter Ujfalusi <peter.ujfalusi@nokia.com>w=
rote:

> On Wednesday 13 May 2009 02:28:58 ext Ernesto Torres wrote:
> > Hi,
> >
> > I would like to know the actual configuration for the output of the
> Beagle
> > Board I2S, from the OMAP35x Reference Manual, on page 2887:
>
> Is you external codec supports master mode (provides the needed clocks on
> the
> I2S bus)?
> I would suggest to use it in that way, since configuring OMAP to provide
> close
> enough frequency can be tricky.
> I have did this for experimenting on our custom board, just to see how it
> works.
> This is the code is taken from the soc board file's hw_params function:
>
> div =3D clk_id =3D freq =3D 0;
> switch (params_rate(params)) {
> case 44100: /* 44.117 */
>        div =3D 68;
>        clk_id =3D OMAP_MCBSP_SYSCLK_CLKS_FCLK;
>        freq =3D 96000000;
>        break;
> case 48000: /* 48.032 */
>        div =3D 54;
>        clk_id =3D OMAP_MCBSP_SYSCLK_CLK;
>        freq =3D 83000000;
>        break;
> default:
>        printk(KERN_ERR "hw params: unknown rate %d\n",
>                params_rate(params));
>        return -EINVAL;
> }
>
> ret =3D snd_soc_dai_set_sysclk(cpu_dai, clk_id, freq, SND_SOC_CLOCK_IN);
> if (ret < 0) {
>        printk(KERN_ERR "can't set cpu system clock\n");
>        return ret;
> }
>
> ret =3D cpu_dai->dai_ops.set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, div);
> if (ret < 0) {
>        printk(KERN_ERR "can't set cpu clock divider\n");
> }
>
> As you can see I needed to select different clock source for 44.1 and 48
> KHz
> sample rate for OMAP to use as a base for the dividing...
>
> So: try to use the OMAP as slave, if it is possible.
>
> --
> P=E9ter
>



-- =

___________
EhTd
