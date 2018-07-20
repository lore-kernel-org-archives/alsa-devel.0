From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 04/14] conf/ucm: bytcr-rt5651: Configure
 all volumes at 0dB
Date: Fri, 20 Jul 2018 08:48:54 -0500
Message-ID: <0deb9e4d-974f-a01f-a567-912463ef5d90@linux.intel.com>
References: <20180720072741.4632-1-hdegoede@redhat.com>
 <20180720072741.4632-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 98C26267749
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 15:48:56 +0200 (CEST)
In-Reply-To: <20180720072741.4632-5-hdegoede@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 7/20/18 2:27 AM, Hans de Goede wrote:
> The volumes are taken from this commit:
> https://github.com/plbossart/UCM/commit/753e2430cd0e6cafbf10c6b29b689dbd32ac5250
> 
> That commit also adds line-in support, so it has not been
> taken in its entirety.

Was there anything wrong with the line-in? It's been a while and I fried 
my board but I think it worked ok. The settings came from Bard Liao.

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
> index 5dcb11e6..d6e8e48d 100644
> --- a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
> +++ b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
> @@ -117,16 +117,13 @@ SectionDefaults [
>   	cset "name='sprot_loop_out mix 0 sprot_loop_in Switch' off"
>   
>   	# default state
> -	cset "name='ADC Capture Volume' 126"
>   	cset "name='HPO MIX DAC1 Switch' on"
>   	cset "name='HPO MIX HPVOL Switch' off"
> -	cset "name='HP Playback Volume' 0"
>   	cset "name='HPO L Playback Switch' off"
>   	cset "name='HPO R Playback Switch' off"
>   	cset "name='HPOVOL L Switch' on"
>   	cset "name='HPOVOL R Switch' on"
>   	cset "name='IF1 ASRC Switch' on"
> -	cset "name='IN Capture Volume' 27"
>   	cset "name='IN2 Boost' 1"
>   	cset "name='IN1 Boost' 1"
>   	cset "name='LOUT L Playback Switch' on"
> @@ -145,6 +142,13 @@ SectionDefaults [
>   	cset "name='Headphone Switch' off"
>   	cset "name='Speaker Switch' off"
>   
> +	# volumes for 0dB
> +	cset "name='OUT Playback Volume' 31"
> +	cset "name='HP Playback Volume' 31"
> +	cset "name='IN Capture Volume' 23"
> +	cset "name='ADC Capture Volume' 47"
> +	cset "name='DAC1 Playback Volume' 175"
> +
>   	# input
>   	cset "name='Stereo1 ADC L1 Mux' ADC"
>   	cset "name='Stereo1 ADC R1 Mux' ADC"
> 
