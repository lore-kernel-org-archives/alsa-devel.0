From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Provide card number / PID via
	sequencer	client info
Date: Mon, 15 Feb 2016 11:37:15 +0100
Message-ID: <56C1AA5B.6040201@ladisch.de>
References: <1455370937-501-1-git-send-email-martin@mail.zuhause>
 <1455370937-501-3-git-send-email-martin@mail.zuhause>
 <s5htwlab70o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 060A42612DF
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 11:37:16 +0100 (CET)
In-Reply-To: <s5htwlab70o.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Martin Koegler <martin.koegler@chello.at>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Martin Koegler wrote:
>> rawmidi devices expose the card number via IOCTLs, which allows to
>> find the corresponding device in sysfs.
>>
>> The sequencer provides no identifing data. Chromium works around this
>> issue by scanning rawmidi as well as sequencer devices and matching
>> them by using assumtions, how the kernel register sequencer devices.
>>
>> This changes adds support for exposing the card number for kernel clients
>> as well as the PID for user client.
>>
>> The minor of the API version is changed to distinguish between the zero
>> initialised reserved field and card number 0.
>>
>> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
>
>> +++ b/include/uapi/sound/asequencer.h
>> @@ -357,7 +357,8 @@ struct snd_seq_client_info {
>> - char reserved[64]; /* for future use */
>> + int owner; /* RO: card number[kernel] / PID[user] */
>> + char reserved[64 - sizeof(int)]; /* for future use */
>
> The sizeof(int) is always 4. So let's make it explicit.
>
> But, please make sure that this change won't lead to any
> incompatibility. Some architectures might align with 64bit long,
> although the 32bit int and the rest char[] should be fine on all known
> architectures, AFAIK.

Or just make it two fields, card and pid. The two values are currently
exclusive, but there is no technical reason for this.


Regards,
Clemens
