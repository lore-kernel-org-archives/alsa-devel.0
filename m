From: Daniel Danzberger <daniel@dd-wrt.com>
Subject: Re: out of sync capture samples with MMAP on MIPS
Date: Tue, 29 May 2018 09:55:44 +0200
Message-ID: <9554b45e-2918-19a0-8dec-8b131b3b6ab8@dd-wrt.com>
References: <e89758e0-b3db-c17c-71f5-e7acfbe76845@dd-wrt.com>
 <s5hsh6gnczj.wl-tiwai@suse.de>
 <1a67f8d2-92b9-49df-849d-e7e436b828a1@dd-wrt.com>
 <s5hk1rpl5jq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail.newmedia-net.de (webmail.newmedia-net.de [185.84.6.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 688C4267252
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 09:55:50 +0200 (CEST)
In-Reply-To: <s5hk1rpl5jq.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/27/2018 01:08 PM, Takashi Iwai wrote:
> On Sun, 27 May 2018 11:34:07 +0200,
> Daniel Danzberger wrote:
>>
>> On 05/25/2018 02:20 PM, Takashi Iwai wrote:> It's likely because of the cache
>> coherency issue on ARM.
>>> Currently USB-audio driver uses the buffer via vmalloc() for the
>>> intermediate buffer, and this may go out of sync on non-coherent arch
>>> like ARM.
>>>
>>> Does the patch below help?  Not sure whether it works on ARM at all,
>>> as I've tested only on x86.
>> Your patch works. I cannot reproduce the issue anymore. Thanks.
> 
> Good to hear.  Below is the revised version, so that the behavior can
> be controlled via use_vmalloc option for snd-usb-audio module.
> Could you check whether this still works?

it works.
