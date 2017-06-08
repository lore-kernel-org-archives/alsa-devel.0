From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/8] ALSA: pcm: add a helper function to
 constrain mask-type parameters
Date: Thu, 8 Jun 2017 16:28:37 +0900
Message-ID: <41daafb7-8185-9e3e-147b-22710c3ef885@sakamocchi.jp>
References: <20170607231026.23383-1-o-takashi@sakamocchi.jp>
 <20170607231026.23383-2-o-takashi@sakamocchi.jp>
 <s5hmv9j2bv4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id CBA542671CA
 for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2017 09:28:39 +0200 (CEST)
In-Reply-To: <s5hmv9j2bv4.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 8 2017 16:10, Takashi Iwai wrote:
> On Thu, 08 Jun 2017 01:10:19 +0200,
> Takashi Sakamoto wrote:
>>
>> Application of constraints to mask-type parameters for PCM substream is
>> done in a call of snd_pcm_hw_refine(), while the function includes much
>> codes and is not enough friendly to readers.
>>
>> This commit splits the codes to a separated function so that readers can
>> get it easily. I leave desicion into compilers to merge the function into
>> its callee.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> ---
>>   sound/core/pcm_native.c | 57 ++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 38 insertions(+), 19 deletions(-)
>>
>> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
>> index 2bde07a4a87f..b3e8aab3915e 100644
>> --- a/sound/core/pcm_native.c
>> +++ b/sound/core/pcm_native.c
>> ...
>> +	struct snd_mask __maybe_unused old_mask;
> 
> Do we really need __maybe_unused?  Drop it as much as possible.
> IMO, it can be uglier than ifdef, since you don't know why it's
> unused.  With ifdef, at least, you have an idea about the condition.

In kernel documentation[1], we can see below suggestion.

"20) Conditional Compilation
...
If you have a function or variable which may potentially go unused in a
particular configuration, and the compiler would warn about its 
definition going unused, mark the definition as __maybe_unused rather 
than wrapping it in a preprocessor conditional.  (However, if a function 
or variable *always* goes unused, delete it.)"

I'll follow this.


Regards

Takashi Sakamoto
