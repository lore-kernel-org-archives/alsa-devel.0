From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: "alsactl store" fails to save Echo Gina3G mixer
Date: Tue, 29 Aug 2017 12:33:17 +0900
Message-ID: <1fa01cef-7159-b1b2-8ec6-5eab7f2a7e29@sakamocchi.jp>
References: <d8d6d07c-ade6-1ccc-7111-ed367fccf0f9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 145AD266A7C
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 05:33:20 +0200 (CEST)
In-Reply-To: <d8d6d07c-ade6-1ccc-7111-ed367fccf0f9@gmail.com>
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
To: "S. Christian Collins" <s.chriscollins@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Aug 29 2017 00:34, S. Christian Collins wrote:
> However, when I try to save the Gina3G mixer:
> 
>    alsactl -f ~/asound1.state store 1
> 
> ...I get the following error:
> 
> alsactl: control.c:2513: snd_ctl_elem_value_get_integer: Assertion `idx 
> < sizeof(obj->value.integer.value) / 
> sizeof(obj->value.integer.value[0])' failed.
> Aborted
> 
> I have tried to find any info on this error online, but to no avail. 
> Does anybody know what is going on here?

The value of 'sizeof(obj->value.integer.value) / 
sizeof(obj->value.integer.value[0])' has fixed value (=128), therefore 
the value of 'idx' is greater than 128, against expectation.

Would you get output from below command line for your Gina 3G?

$ amixer scontrols

And typically state data is stored into '/var/lib/alsa/asound.state' as 
a default. For my information, could you disclose it if possible?


Regards

Takashi Sakamoto
