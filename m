From: bsiice <bsiice@msn.com>
Subject: Re: [PATCH - pcm 1/1] pcm: fix 'unable to create IPC
 shm instance' caused by fork from a thread
Date: Thu, 10 Mar 2016 23:09:46 +0800
Message-ID: <BLU436-SMTP201FE60C33C1CA7B0895D52D2B40@phx.gbl>
References: <BLU436-SMTP231971C20166F7E91EA3C9AD2B40@phx.gbl>	<BLU436-SMTP10571CE460C579C26FDF6BCD2B40@phx.gbl>
 <s5hh9ge5r7f.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from BLU004-OMC3S5.hotmail.com (blu004-omc3s5.hotmail.com
 [65.55.116.80]) by alsa0.perex.cz (Postfix) with ESMTP id 78178260564
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 16:09:01 +0100 (CET)
In-Reply-To: <s5hh9ge5r7f.wl-tiwai@suse.de>
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
Cc: Qing Cai <caiqing@neusoft.com>, alsa-devel@alsa-project.org, bsiice@msn.com
List-Id: alsa-devel@alsa-project.org

On 03/10/2016 10:43 PM, Takashi Iwai wrote:
> On Thu, 10 Mar 2016 13:50:24 +0100,
> bsiice wrote:
>>
>> Hi Takashi Iwai:
>>
>> Is this patch OK?
>>
>> I have automatically tested 422 times after this fix, and
>> 'unable to create IPC shm instance' doesn't happen, and so the multimedia
>> application functions properly.
> 
> The patch looks good, and working as far as I've tested, so merged to
> git tree now.  I added a few more changelog texts to explain what
> exactly this patch does.

Thanks a million for the changelog texts!
Very glad and exciting with my patch is adopted!


thanks,

Qing Cai
