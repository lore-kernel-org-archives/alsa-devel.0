From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ALSA: control: add .flush operation to
 release blocked operation
Date: Mon, 27 Jul 2015 20:40:17 +0200
Message-ID: <55B67B11.3070808@metafoo.de>
References: <1437825240-11222-1-git-send-email-o-takashi@sakamocchi.jp>
 <1437825240-11222-2-git-send-email-o-takashi@sakamocchi.jp>
 <s5h1tftyjyh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-193.synserver.de
 [212.40.185.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 25C1E260682
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 20:40:19 +0200 (CEST)
In-Reply-To: <s5h1tftyjyh.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On 07/27/2015 12:27 PM, Takashi Iwai wrote:
> On Sat, 25 Jul 2015 13:54:00 +0200,
> Takashi Sakamoto wrote:
>>
>> ALSA control character devices doesn't release blocking state for
>> read(2) operations when a file descriptor corresponding to the character
>> device is closed by close(2). This is due to a blocking loop of
>> snd_ctl_read() has no breaking point for this event.
>>
>> Additionally, the read(2) operation reports EBADFD when executed in a
>> state of unsubscription. On the other hand, this operation continue
>> to be blocked after unsubscribe operation. In this case, the read(2)
>> operation should return with EBADFD.
>>
>> Furthermore, poll(2) operation for the character device can report
>> some events after close(2).
>>
>> This commit solves these issues, by adding flush file operation.
>> The file descriptor becomes unsubscribed state after close(2) operation.
>> Then, read(2) and poll(2) operations return with expected results.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>
> Thanks for spotting out the problem and the patch.  I guess your patch
> would work in most cases correctly.

Is it really a problem? I'd say it's the expected behavior. What close does 
is destroys the mapping between the process local fd and the global struct 
file. It does not abort any pending blocking operations. If you want to 
wakeup a blocking operation you need to send a signal to the thread.

>  One thing I'm not sure is the
> case where the file descriptor is copied.  Is the flush op called only
> if one of the multiple processes is closed, or is it after all fps
> closed?  In the former case, this might be a problem.

Should be on every close. Especially with close-on-exec this quickly becomes 
a problem.
