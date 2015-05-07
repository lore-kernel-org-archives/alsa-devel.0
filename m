From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add cache to speed up
	adding of routes
Date: Thu, 7 May 2015 13:35:57 +0100
Message-ID: <20150507123557.GA3480@opensource.wolfsonmicro.com>
References: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430994839-32584-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <554B4ADF.3000801@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C4522619E9
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 14:35:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <554B4ADF.3000801@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 07, 2015 at 01:22:07PM +0200, Lars-Peter Clausen wrote:
> On 05/07/2015 12:33 PM, Charles Keepax wrote:
>> Some CODECs have a significant number of DAPM routes and for each route,
>> when it is added to the card, the entire card widget list must be
>> searched. When adding routes it is very likely, however, that adjacent
>> routes will require adjacent widgets. For example all the routes for a
>> mux are likely added in a block and the sink widget will be the same
>> each time and it is also quite likely that the source widgets are
>> sequential located in the widget list.
>>
>> This patch adds an optional cache argument to snd_soc_dapm_add_route, if
>> given, this argument will hold the source and sink widgets from the last
>> call to snd_soc_dapm_add_route. A small search of the widget list will
>> be made from those points for both the sink and source. Currently this
>> search only checks both the last widget and the one adjacent to it.
>>
>> On wm8280 which has approximately 500 widgets and 30000 routes (one of
>> the largest CODECs in mainline), the number of paths that hit the cache
>> is 24000, which significantly improves probe time.
>
> That's crazy! ;)
>
> I wonder if it makes sense to come up with a more machine readable blob  
> format that can be pre-compiled where we don't have to search the widget  
> list each time a route is added. Instead of having it reference the 
> widgets by name use a index that points into an array of widgets. That 
> makes the lookup time O(1).
>

I don't think its necessary just yet we have one more slightly
larger CODEC (700 widgets, 46000 routes), which we haven't
managed to get around to upstreaming yet. But it looks like the
size is levelling off about there for now and this solution is
probably good enough for that size.

>>
>> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>> ---
>>   sound/soc/soc-dapm.c |   40 ++++++++++++++++++++++++++++++++++++++--
>>   1 files changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
>> index ea3348e..95d3ea5 100644
>> --- a/sound/soc/soc-dapm.c
>> +++ b/sound/soc/soc-dapm.c
>> @@ -2585,8 +2585,26 @@ err:
>>   	return ret;
>>   }
>>
>> +static struct snd_soc_dapm_widget *
>> +dapm_check_path_cache(const char *name, struct snd_soc_dapm_widget *w, int n)
>> +{
>> +	int i;
>> +
>> +	if (w) {
>> +		for (i = 0; i < n; i++) {
>> +			if (!strcmp(name, w->name))
>> +				return w;
>> +
>> +			w = list_next_entry(w, list);
>
> This will return garbage if w is the last widget in the list.
>
> Otherwise the patch looks sensible.
>

Oops, thanks I will fix that up.

Thanks,
Charles
