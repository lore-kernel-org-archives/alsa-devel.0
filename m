From: Robert Rosengren <robert.rosengren@axis.com>
Subject: Re: [PATCH 1/2] ASoC: adau17x1: Handling of DSP_RUN
 register during fw setup
Date: Wed, 11 Apr 2018 07:16:23 +0200
Message-ID: <759283a1-3231-8d45-1237-0378869dece8@axis.com>
References: <20180403080535.6109-1-robertr@axis.com>
 <4650baa5-d205-2b99-0222-1b08592afe9c@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 51F0A26736F
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 07:16:25 +0200 (CEST)
In-Reply-To: <4650baa5-d205-2b99-0222-1b08592afe9c@metafoo.de>
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
To: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
Cc: Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org


On 04/05/2018 05:44 PM, Lars-Peter Clausen wrote:
> On 04/03/2018 10:05 AM, Robert Rosengren wrote:
>> From: Danny Smith <dannys@axis.com>
>>
>> DSP_RUN needs to be disabled during firmware write otherwise
>> we can end up with undefined behavior if writing to a dsp which
>> is already running firmware.
>>
> 
> Good point, thanks.
> 
> I believe there is a possible (but rare under normal circumstances) race
> condition here though, where DAPM could run at the same time and
> enable/disable the DSP while the firmware is being loaded.
> 
> To avoid this the firmware load sequence should be encapsulated in
> snd_soc_dapm_mutex_lock()/snd_soc_dapm_mutex_unlock().
> 
> Pass struct snd_soc_component instead of struct adau to this function and
> then use snd_soc_component_get_dapm() to get the DAPM context.
> 
> For the next version of the patches please also add the ASoC maintainers to
> the reciver list since they have to apply the patch. The maintainers are:
> 
> Liam Girdwood <lgirdwood@gmail.com>
> Mark Brown <broonie@kernel.org>
> 

Thanks for your comments! New patches are already sent for your review :)

/ Robert

> 
>> Signed-off-by: Danny Smith <dannys@axis.com>
>> ---
>>  sound/soc/codecs/adau17x1.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
