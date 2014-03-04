From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: io: Remove hw_read() operation
Date: Tue, 04 Mar 2014 10:45:47 +0100
Message-ID: <5315A0CB.1020300@metafoo.de>
References: <1393924251-6754-1-git-send-email-broonie@kernel.org>
 <53159AD0.5000800@metafoo.de> <20140304092723.GH13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-147.synserver.de
 [212.40.185.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 50F5B265725
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 10:45:18 +0100 (CET)
In-Reply-To: <20140304092723.GH13126@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/04/2014 10:27 AM, Mark Brown wrote:
> On Tue, Mar 04, 2014 at 10:20:16AM +0100, Lars-Peter Clausen wrote:
>
>>>   	codec->write = hw_write;
>>> -	codec->read = hw_read;
>
>> But this part will break snd_soc_read() and with it basically every
>> driver that has any controls or DAPM widgets.
>
> Bah, so it does.
>
>> I do have a set of patches that moves IO to the component level that
>> will clean this all up quite a bit. I'm just waiting for Xiubo Li
>> snd_soc_codec_set_cache_io() cleanup to be merged first, since it
>> will make things a bit simpler.
>
> That seems to be going really slowly...

Yea, but we are not in a hurry. My plan was to get all the small independent 
driver cleanups necessary for componetization merged for 3.15 and then for 
3.16 do the componetnization in the ASoC core.

>  in any case the real fix here
> is to get all the users converted over to regmap.  We could also just
> do something similar to what we've done with update_bits() (where we did
> it for locking) which is going to be much quicker.
>

So what the patchset does is add a regmap pointer to the component struct. 
For now it also adds snd_soc_component_{read,write,update_bits,
update_bits_async} wrapper functions which have the same signature as the 
matching regmap function. Internally it does check if the regmap field of 
the component is set, if yes, just forwards the call to the matching regmap 
function. If not it falls back to the read, write callbacks setup by CODEC 
or platform drivers. Once every driver has been converted to regmap we can 
remove the fallback and make the function static inline.

- Lars
