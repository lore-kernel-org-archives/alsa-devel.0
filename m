From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/3] ALSA: pcm:
Date: Fri, 9 Jun 2017 10:45:01 +0900
Message-ID: <f3e2624f-81f0-26c3-8d3e-04ea98927463@sakamocchi.jp>
References: <20170609003440.4178-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id AE938267339
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 03:45:05 +0200 (CEST)
In-Reply-To: <20170609003440.4178-1-o-takashi@sakamocchi.jp>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Oops, I sent this patchset with cover-letter without good subject line, 
sorry...

On Jun 9 2017 09:34, Takashi Sakamoto wrote:
> This is a part of layout of the structure.
> 
> struct snd_pcm_hw_params {
>      ...
>      unsigned int info;
>      unsigned int msbits;
>      unsigned int rate_num;
>      unsigned int rate_den;
>      snd_pcm_uframes_t fifo_size;
>      ...
> };
> 
> For example, although the 'msbits', 'rate_num' and 'rate_den' fields are
> filled in a result of HW_REFINE command conditionally, they're never
> filled in a result of HW_PARAMS command. This seems a bug.

I note that there's a case for HW_PARAMS that the result includes proper 
values to these parameters. When drivers register constrain rules 
relevant to them, the members are filled.


Regards

Takashi Sakamoto
