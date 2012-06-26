From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: Configuring an audio path within ALSA
Date: Tue, 26 Jun 2012 15:13:18 +0530
Message-ID: <1340703798.1562.205.camel@vkoul-udesk3>
References: <CABTnDnPfGF8AddTSQ4GPyyvosQVa7K6Koda2cz79dknxWMaTVg@mail.gmail.com>
	<4FE924E2.2010504@codeaurora.org>
	<CABTnDnNv4tjHUY4MTTUxT_aiLUof85SpJLqV6ooEiqJF1yTLqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D1452245E3
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 11:52:36 +0200 (CEST)
In-Reply-To: <CABTnDnNv4tjHUY4MTTUxT_aiLUof85SpJLqV6ooEiqJF1yTLqA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rashmi narayan <rashmi.nyn@gmail.com>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-06-26 at 13:22 +0530, rashmi narayan wrote:
Dont TOP Post!!

> Thank you Patrick .
> 
> Currently my codec driver SGTL5000.c has the following audio map
> static const struct snd_soc_dapm_route audio_map[] = {
>  {"ADC Mux", "LINE_IN", "LINE_IN"},
> {"ADC Mux", "MIC_IN", "MIC_IN"},
>  {"ADC", NULL, "ADC Mux"},
> {"DAC Mux", "DAC", "DAC"},
>  {"DAC Mux", "LINE_IN", "LINE_IN"},
> {"LO", NULL, "DAC"},
>  {"HP", NULL, "DAC Mux"},
> {"LINE_OUT", NULL, "LO"},
>  {"HP_OUT", NULL, "HP"},
> };
> 
> This map does not have a link from ADC to DAC.
> You mention "After a set of ALSA mixer commands is issued to create a
> path from one end point to another end point" , how do we issue those
> commands? to create a link , currently my alsa mixer shows no option for a
> ADC to DAC select.
Does the codec data sheet support it, if so please create the DAPM
widgets for this and add them in above map.

> 
> -Rashmi
> 
> 
> On Tue, Jun 26, 2012 at 8:26 AM, Patrick Lai <plai@codeaurora.org> wrote:
> 
> > On 6/25/2012 5:26 AM, rashmi narayan wrote:
> >
> >> Dear ALSA Folks,
> >>
> >> I am a newbie to ALSA .I am trying to configure a path within the driver
> >> to
> >> open up /power up the path within the codec from MIC-IN to LineOUT. How
> >> can
> >> I do this within ALSA. Please send me some pointers.
> >>
> >>  If your CODEC driver is written to plug into ASoC framework, ASoC
> > dynamic audio power management(DAPM) will be able to link MIC-IN to
> > Lineout. After a set of ALSA mixer commands is issued to create a path
> > from one end point to another end point, DAPM will kick in and enable
> > the path according to widgets and audio routing map defined in the
> > CODEC driver.
> >
> >  Thank you,
> >> Rashmi
> >> ______________________________**_________________
> >> Alsa-devel mailing list
> >> Alsa-devel@alsa-project.org
> >> http://mailman.alsa-project.**org/mailman/listinfo/alsa-**devel<http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>
> >>
> >
> >
> > --
> > Sent by an employee of the Qualcomm Innovation Center, Inc.
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
~Vinod
