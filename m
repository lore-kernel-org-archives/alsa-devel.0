From: Steve Longerbeam <stevel@embeddedalley.com>
Subject: Re: [PATCH] Add support for gain in softvol plugin
Date: Mon, 14 May 2007 12:37:15 -0700
Message-ID: <4648BA6B.3020101@embeddedalley.com>
References: <463A33D8.3090907@embeddedalley.com>	<Pine.LNX.4.61.0705032121110.7861@tm8103.perex-int.cz>	<463A6100.3070708@embeddedalley.com>	<Pine.LNX.4.61.0705040938540.7594@tm8103.perex-int.cz>	<463B5EFC.6080801@embeddedalley.com>	<463B6E5C.70802@embeddedalley.com>	<s5hzm4e5flo.wl%tiwai@suse.de>	<46437916.2050408@embeddedalley.com>
	<s5hejljhi38.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp104.biz.mail.mud.yahoo.com (smtp104.biz.mail.mud.yahoo.com
	[68.142.200.252]) by alsa0.perex.cz (Postfix) with SMTP id 44BE3247B6
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2007 21:37:30 +0200 (CEST)
In-Reply-To: <s5hejljhi38.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 10 May 2007 12:57:10 -0700,
> Steve Longerbeam wrote:
>   
>> Hi Takashi,
>>
>> Thanks, that's much better. I tried doing that myself a while ago, but I 
>> must have been doing something wrong because the capture device wasn't 
>> being recognized. But your version works.
>>
>> Version 4 of the patch is attached. It's much better, only two modified 
>> files: pcm_softvol.c and HDA-Intel.conf.
>>
>> I also reduced the gain range, it's now -30 to +30 dB.
>>     
>
> I'm afraid that this choice would be bad for the current TLV
> representation.  The default resolution is 256, so -30/30 dB range
> doesn't match to this resolution.  We should change either resolution
> (e.g. 120, corresponding to 0.5dB step), or the range.
>   

ok, that's no problem. How about we change the range to (in HDA-Intel.conf):

min_dB: -21.0
max_dB: 30.0

Steve
> Otherwise it looks fine to me.
>
>
> Thanks,
>
> Takashi
>
>   
