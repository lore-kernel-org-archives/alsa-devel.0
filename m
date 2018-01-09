From: Petr Kulhavy <brain@jikos.cz>
Subject: Re: Set multiple mixer channel values at once
Date: Tue, 9 Jan 2018 17:37:49 +0100
Message-ID: <2b409a64-625c-0ffd-d6c2-4333888f0e05@jikos.cz>
References: <35d6971a-efcf-443d-b25e-dc448780e492@jikos.cz>
 <s5hd12j1llg.wl-tiwai@suse.de>
Reply-To: brain@jikos.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from twin.jikos.cz (twin.jikos.cz [91.219.245.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 4265926719C
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 17:37:56 +0100 (CET)
In-Reply-To: <s5hd12j1llg.wl-tiwai@suse.de>
Content-Language: de-CH
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

thank you for the hint, I will try that.

Indeed the multichannel is a single control element. Do you mean to call 
multiple snd_ctl_elem_value_set_integer() followed by a single 
snd_hctl_elem_write() ?
Similar to what is described here 
https://alsa.opensrc.org/HowTo_access_a_mixer_control ?

Thanks
Petr

On 09/01/18 09:29, Takashi Iwai wrote:
> On Mon, 08 Jan 2018 12:01:34 +0100,
> Petr Kulhavy wrote:
>> Hi,
>>
>> does the ALSA library provide a method to set multiple channel values
>> of a multi-channel mixer element at once?
> It depends.  If the multi-channel is implemented in a single control
> element, you can set the whole update and write it in a single shot.
> But maybe not via alsa-lib mixer functions but with raw snd_ctl_*()
> stuff.
>
>
> Takashi
>
