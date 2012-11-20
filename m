From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 3/4] ASoC: firmware core: Add core support
 for dynamic kcontrols and widgets.
Date: Tue, 20 Nov 2012 12:19:28 +0000
Message-ID: <50AB7550.7020804@ti.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-3-git-send-email-lrg@ti.com>
 <20121120023606.GB4483@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EC4F265372
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:19:32 +0100 (CET)
In-Reply-To: <20121120023606.GB4483@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 20/11/12 02:36, Mark Brown wrote:
> On Mon, Nov 19, 2012 at 06:12:44PM +0000, Liam Girdwood wrote:
>
>> @@ -584,6 +584,8 @@ struct snd_soc_dapm_widget {
>>   	int num_kcontrols;
>>   	const struct snd_kcontrol_new *kcontrol_news;
>>   	struct snd_kcontrol **kcontrols;
>> +	int denum;
>> +	int dmixer;
>
> In the patch adding the actual functional code it looks like these are
> just treated as booleans saying if the control is dynamic.  This in
> conjunction with the fact that we've got a single list of dynamic
> controls means that we can only have one block of dynamic controls on
> this device.  Is that correct?  If not then I've got the wrong end of
> the stick otherwise...
>

That's correct atm.

> It occurs to me that if we just assign these to numbers per thing with
> firmware then we can easily use this data structure to support multiple
> firmwares per device.  We just go through the list and delete all mixers
> numbered 1 or something.  If we do that I think we can simplify the code
> a little and just make all the mixers and controls "dynamic", using ID 0
> for the non-changable ones.
>

Good idea. I'll make this change.

Liam
