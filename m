From: "Andrey Mazo" <mazo@telum.ru>
Subject: Re: [PATCH] pcm_file: document new argument to
 snd_pcm_file_open().
Date: Mon, 18 Nov 2013 14:38:21 +0400
Message-ID: <op.w6qqh7k5vp3tvr@hippo.telum.ru>
References: <1384636316-26706-1-git-send-email-mazo@telum.ru>
 <1384703119-6856-1-git-send-email-mazo@telum.ru>
 <s5hsiuuyve1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.telum.ru (mail.telum.ru [62.141.76.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 054C92610D3
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2013 11:38:20 +0100 (CET)
In-Reply-To: <s5hsiuuyve1.wl%tiwai@suse.de>
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

Thank you very much!
Sorry, I've missed that in the first place.

On Mon, 18 Nov 2013 12:19:34 +0400, Takashi Iwai <tiwai@suse.de> wrote:

> At Sun, 17 Nov 2013 19:45:19 +0400,
> Andrey Mazo wrote:
>>
>> Document function argument, added in commit
>> 4081be0b87ab9fa53a8906e66bc240f18a7a9a54.
>>
>> Signed-off-by: Andrey Mazo <mazo@telum.ru>
>
> Thanks, applied.
>
>
> Takashi
>
>> ---
>>  src/pcm/pcm_file.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
>> index 25055d0..7123025 100644
>> --- a/src/pcm/pcm_file.c
>> +++ b/src/pcm/pcm_file.c
>> @@ -714,6 +714,7 @@ static const snd_pcm_fast_ops_t snd_pcm_file_fast_ops = {
>>   * \param perm File permission
>>   * \param slave Slave PCM handle
>>   * \param close_slave When set, the slave PCM handle is closed with copy PCM
>> + * \param stream the direction of PCM stream
>>   * \retval zero on success otherwise a negative error code
>>   * \warning Using of this function might be dangerous in the sense
>>   *          of compatibility reasons. The prototype might be freely
>> --
>> 1.8.4
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Andrey Mazo.
