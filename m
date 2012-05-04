From: "Bishop, Mark" <Mark.Bishop@cooperindustries.com>
Subject: Re: ALSA driver issue with the ssm2602.c
Date: Fri, 4 May 2012 13:56:46 -0400
Message-ID: <5D308BD40154E4439D82454FE483A502069CD32A@EVS4.nam.ci.root>
References: <5D308BD40154E4439D82454FE483A5020698F4F3@EVS4.nam.ci.root>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cooperlighting-sw.cooperlighting.com
	(cooperlighting-sw.cooperlighting.com [216.130.131.68])
	by alsa0.perex.cz (Postfix) with ESMTP id C1DE5103D92
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2012 19:57:10 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <5D308BD40154E4439D82454FE483A5020698F4F3@EVS4.nam.ci.root>
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

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of Bishop, Mark
> Sent: Thursday, May 03, 2012 3:31 PM
> To: alsa-devel@alsa-project.org
> Subject: [alsa-devel] ALSA driver issue with the ssm2602.c
> 
> When I enable the 'Output Mixer HiFi' using amixer it also powers up
> the
> Mic input on this codec.  I believe this is incorrect.  I would like
to
> modify the driver to fix it but am having issues with the ALSA
> structures in the driver.
> 
> 
> 
> Would I be off if I attempt to make my changes in the
> snd_soc_dapm_route
> structures?  I am unsure how everything is hooked together in all
those
> structs{}.
> 

Where in ALSA are the simple controls for the codecs created?  As an
example, on this ssm2602 I am looking for the 'Master' simple control
that I would modify in amixer, but these are the only two 'Master'
labels in ssm2602.c:

SOC_DOUBLE_R_TLV("Master Playback Volume", SSM2602_LOUT1V,
SSM2602_ROUT1V,
        0, 127, 0, ssm260x_outmix_tlv),
SOC_DOUBLE_R("Master Playback ZC Switch", SSM2602_LOUT1V,
SSM2602_ROUT1V,
        7, 1, 0),

And:
root:/> amixer |grep  Master
Simple mixer control 'Master',0
Simple mixer control 'Master Playback ZC',0
