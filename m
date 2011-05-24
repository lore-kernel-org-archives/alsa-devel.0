From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm - fix prefix for DAPM muxes
Date: Tue, 24 May 2011 20:40:51 +0100
Message-ID: <4DDC09C3.9030609@ti.com>
References: <1306255149-4519-1-git-send-email-lrg@ti.com>
	<20110524214504.bc02203f.jhnikula@gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A482A3@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E89A10380D
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 21:40:56 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A482A3@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 24/05/11 20:37, Stephen Warren wrote:
> Jarkko Nikula wrote at Tuesday, May 24, 2011 12:45 PM:
>> On Tue, 24 May 2011 17:39:09 +0100 Liam Girdwood <lrg@ti.com> wrote:
>>> Make sure DAPM muxes have a valid kcontrol name instead of NULL.
>>>
>>> Signed-off-by: Liam Girdwood <lrg@ti.com>
>>> ---
>>>  sound/soc/soc-dapm.c |    4 ++--
>>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
>>> index 456617e..c5d98e3 100644
>>> --- a/sound/soc/soc-dapm.c
>>> +++ b/sound/soc/soc-dapm.c
>>> @@ -489,10 +489,10 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
>>>  	wlist->widgets[wlistentries - 1] = w;
>>>
>>>  	if (!kcontrol) {
>>> -		if (dapm->codec)
>>> +		if (dapm->codec && dapm->codec->name_prefix)
>>>  			prefix = dapm->codec->name_prefix;
>>>  		else
>>> -			prefix = NULL;
>>> +			prefix = w->name;
>>>
>> This didn't look correct to play with prefix. A quick look revealed
>> that there is indeed breakage from commit af46800 ("ASoC: Implement mux
>> control sharing") and this fix doesn't fix it on rx51.
>>
>> I think the breakage must come from dapm_is_shared_kcontrol() that
>> returns always 1 and dapm_new_mux() ends up using w->kcontrol_news
>> [0].name instead of previous w->name.
>>
>> dapm_is_shared_kcontrol() returns always 1 since it gets
>> &w->kcontrol_news[0] as an argument and &w->kcontrol_news[i] will
>> match when iterating the same widget with i==0.
>>
>> 	list_for_each_entry(w, &dapm->card->widgets, list) {
>> 		for (i = 0; i < w->num_kcontrols; i++) {
>> 			if (&w->kcontrol_news[i] == kcontrol_new) {
>> 				if (w->kcontrols)
>> 					*kcontrol = w->kcontrols[i];
>> 				return 1;
>> 			}
>> 		}
>> 	}
>>
>> It works rx51 if I start the iteration from i==1 but it looks the
>> actual fix is to the check that we are not iterating the same widget.
> 
> Yes, I think just add a "struct snd_soc_dapm_widget *kcontrolw" parameter
> to dapm_is_shared_kcontrol(), and make the list_for_each continue if
> w == kcontrolw.
> 
> Sorry, I didn't test this on a system with control name prefixes.
> 
> I can whip up the patch if you want, but won't be able to test that
> it fixes your problems, since none of my systems have prefixes.
> Let me know either way.
> 

Please do. I'll give it a test tomorrow.

Thanks !

Liam
