From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Wed, 10 Jun 2009 14:20:01 +0200
Message-ID: <4A2FA4F1.8070208__15449.4572816931$1244636423$gmane$org@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<200906101112.32635.peter.ujfalusi@nokia.com>
	<200906101227.39856.jkrzyszt@tis.icnet.pl>
	<200906101353.43411.peter.ujfalusi@nokia.com>
Reply-To: postmaster@icnet.pl
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200906101353.43411.peter.ujfalusi@nokia.com>
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
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Peter Ujfalusi wrote:
> On Wednesday 10 June 2009 13:27:38 ext Janusz Krzysztofik wrote:
>> Not only this. AFAICS, there is no way of specifying single phase stereo
>> (with XPHASE/RPHASE unset), 2 words per frame (XFRLEN1/RFRLEN1(2 - 1)).
>> Isn't this required for correct DSP_A/DSP_B support?
> 
> Sure it is possible:
> 	format = mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
> 	wpf = channels = params_channels(params);
> 	switch (channels) {
> 	case 2:
> 		if (format == SND_SOC_DAIFMT_I2S) {
> 			/* Use dual-phase frames */
> 			regs->rcr2	|= RPHASE;
> 			regs->xcr2	|= XPHASE;
> 			/* Set 1 word per (McBSP) frame for phase1 and phase2 */
> 			wpf--;
> 			regs->rcr2	|= RFRLEN2(wpf - 1);
> 			regs->xcr2	|= XFRLEN2(wpf - 1);
> 		}
> 	case 1:
> 	case 4:
> 		/* Set word per (McBSP) frame for phase1 */
> 		regs->rcr1	|= RFRLEN1(wpf - 1);
> 		regs->xcr1	|= XFRLEN1(wpf - 1);
> 		break;
> 	default:
> 		/* Unsupported number of channels */
> 		return -EINVAL;
> 	}
> 
> wpf = channels == 2, format is not I2S --> RFRLEN1(wpf - 1), XFRLEN1(wpf - 1), 
> RFRLEN1(2 - 1), XFRLEN1(2 - 1)

OK, I see I have to update my base before commenting the code ;).

Thanks,
Janusz
