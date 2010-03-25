From: "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>
Subject: Re: Problem adding support for digital mixer in codec
Date: Thu, 25 Mar 2010 11:56:40 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B904BDE91@dlee01.ent.ti.com>
References: <2256F256009DAA4CBE661E9F41EAC84B904BD8A0@dlee01.ent.ti.com>
	<201003250917.59531.peter.ujfalusi@nokia.com>
	<1269508416.3758.19.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id A57452437D
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 17:56:46 +0100 (CET)
In-Reply-To: <1269508416.3758.19.camel@odin>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter@alsa-project.org, Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> On Thu, 2010-03-25 at 09:17 +0200, Peter Ujfalusi wrote:
>> 
>> What I did with the TWL4030 codec, is that I have moved the actual
>> DAC power control from the DAPM_DAC to different widget (the
>> DAPM_DAC is kind of a fake one). This was needed to support the
>> digital loopback functionality. 
>> 
>> So if you reorder the DAPM widgets (making sure that the switch
>> order still OK), than I think you can treat one of the paths as
>> normal playback path (fake DAPM_DAC -> mixer (have the DAC power bit
>> handled here) -> ...). Than you might consider of adding the rest of
>> the paths as DAPM_INPUT, and connect them to the mixer (which after
>> the fake DAC). 
>> So you kind of have digital loopback from those to the analog domain.
>> 
> 
> This approach currently works well on the twl4030. However,
> you may want
> to consider using SND_SOC_DAPM_AIF_IN() for your input paths
> here. e.g.
> 
> AIF_IN -> MIXER -> DAC -> rest of codec

I see now, this is exactly what I was looking for. I will give it a try
then. Thanks.
