From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/6] ALSA: firewire: constify snd_pcm_ops structures
Date: Fri, 2 Sep 2016 09:06:41 +0900
Message-ID: <628a90e4-3799-f86e-5184-900990cef07c@sakamocchi.jp>
References: <1472767994-26269-1-git-send-email-Julia.Lawall@lip6.fr>
 <1472767994-26269-4-git-send-email-Julia.Lawall@lip6.fr>
 <2e4b67ec-6e8d-b499-06d3-910f6413e3fd@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2e4b67ec-6e8d-b499-06d3-910f6413e3fd@sakamocchi.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 2016年09月02日 08:28, Takashi Sakamoto wrote:
> Hi Julia,
>
> On 2016年09月02日 07:13, Julia Lawall wrote:
>> Check for snd_pcm_ops structures that are only stored in the ops field of a
>> snd_soc_platform_driver structure or passed as the third argument to
>> snd_pcm_set_ops.  The corresponding field or parameter is declared const,
>> so snd_pcm_ops structures that have this property can be declared as const
>> also.
>>
>> The semantic patch that makes this change is as follows:
>> (http://coccinelle.lip6.fr/)
>
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>
> I've realized this issue and will fix in this development cycle for
> Linux 4.9. Thanks for your continuous effort to reinforce software for
> better directions.

s/will/had a plan to/g


Regards

Takashi Sakamoto
