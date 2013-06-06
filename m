From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Question on wait_for_avail function
Date: Wed, 05 Jun 2013 23:25:15 -0700
Message-ID: <51B02B4B.8080900@codeaurora.org>
References: <1794d77072add642c43309c0a06bfadb.squirrel@www.codeaurora.org>
 <51AF0223.5020901@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 3821026031E
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 08:25:19 +0200 (CEST)
In-Reply-To: <51AF0223.5020901@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, perex@perex.cz
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, gsantosh@codeaurora.org
List-Id: alsa-devel@alsa-project.org

+ << Jaroslav >>
On 6/5/2013 2:17 AM, Clemens Ladisch wrote:
> gsantosh@codeaurora.org wrote:
>> 2) HAL issues pause in parallel to the write
>
> This is illegal.
> <http://www.alsa-project.org/main/index.php/SMP_Design> says:
> | The use of returned handles [such as snd_pcm_t*] must be serialized in
> | the application using own locking scheme.
>
> If you want to issue a pause while waiting for data to be written, use
> non-blocking writes.
>

Based on my understanding of SMP_Design and response above, pause and 
write to same
PCM device are expected to be serialized. However, my interpretation of
following patch is that pause and stop are expected to wakes up process
waiting in pcm_lib.c wait_for_avail(). It seems to give me the
indication that multiple threads acting on same PCM device is expected.

ALSA: pcm_core: Fix wake_up() optimization

This change fixes the "ALSA: pcm_lib - optimize wake_up() calls for PCM
I/O" commit. New sleeping queue is introduced to separate user space
and kernel space wake_ups. runtime->nowake is renamed to twake
(transfer wake).

Jaroslav: Can you share your thought as you are author of this patch?

Thanks
Patrick
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
