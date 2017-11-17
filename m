From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] ALSA: synth: emux: remove redundant test
	for r <= 13
Date: Fri, 17 Nov 2017 11:07:47 +0000
Message-ID: <8de4b3a4-9ab4-3d23-6664-afffb28d864e@canonical.com>
References: <20171114172653.6690-1-colin.king@canonical.com>
 <s5hwp2pyxj7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 33021266F03
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 12:08:17 +0100 (CET)
In-Reply-To: <s5hwp2pyxj7.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 17/11/17 11:06, Takashi Iwai wrote:
> On Tue, 14 Nov 2017 18:26:53 +0100,
> Colin King wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The calculation r = (3 - ((rate >> 6) & 3)) * 3 results in r being
>> 0, 3, 6 or 9 and so the check (13 > r) is always true and hence we
>> can remove the redundant check and the else path.
>>
>> Detected by CoverityScan, CID#744415 ("Logically dead code")
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> The calculation of t itself can be generic in case we may add a
> support greater than the current r, so I don't think it's so much
> beneficial with this code reduction.  Better to keep the code as
> reference.

OK, that's a good decision.

Colin
> 
> 
> thanks,
> 
> Takashi
> 
>> ---
>>  sound/synth/emux/soundfont.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
>> index 31a4ea94830e..0beb5a737c8b 100644
>> --- a/sound/synth/emux/soundfont.c
>> +++ b/sound/synth/emux/soundfont.c
>> @@ -858,10 +858,7 @@ calc_gus_envelope_time(int rate, int start, int end)
>>  	p = rate & 0x3f;
>>  	t = end - start;
>>  	if (t < 0) t = -t;
>> -	if (13 > r)
>> -		t = t << (13 - r);
>> -	else
>> -		t = t >> (r - 13);
>> +	t = t << (13 - r);
>>  	return (t * 10) / (p * 441);
>>  }
>>  
>> -- 
>> 2.14.1
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
