From: Bhaskara rao Budiredla <bhaskarbudiredla@gmail.com>
Subject: Re: Memory and Cycles overhead in <snd_soc_init>
Date: Wed, 11 Feb 2015 15:10:09 +0530
Message-ID: <CAJWVF-zH=L3wtQRtQDh1hkWH=YqmAJtJ9HoEpNXO=1VZZpJxgg@mail.gmail.com>
References: <CAJWVF-wkq5xdH0WqOj+rWk4UEO4aZCcuv5JthvtDkEh8spDiaA@mail.gmail.com>
 <54DA36EB.7010007@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id E715D2605D0
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 10:40:09 +0100 (CET)
Received: by iecrl12 with SMTP id rl12so270895iec.4
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 01:40:09 -0800 (PST)
In-Reply-To: <54DA36EB.7010007@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Lars for the help. Could you please tell me the use case for those
devices and drivers creation? Even pointing to the code snippet is helpful.

Thanks,
Bhaskara

On Tue, Feb 10, 2015 at 10:20 PM, Lars-Peter Clausen <lars@metafoo.de>
wrote:

> On 02/10/2015 12:58 PM, Bhaskara rao Budiredla wrote:
>
>> Hi - May I know the purpose of the call to snd_soc_init( ) from
>> kernel_init
>> thread? snd_soc_init( ) is trying to register a dummy platform device
>> "snd-soc-dummy" containing (dummy_codec/dummy_platform) and a sound card
>> device. Neither of those devices are added to platform bus before they are
>> making a call to platform_driver_register( ). Due to that platform_match(
>> ) will fail and they will not be added to platform bus . Thus,
>> snd_soc_init( ) is not doing any useful task during kernel boot time.
>>
>> Could someone help me if my understanding is correct? If I am correct,
>> shall we remove the call to snd_soc_init( ) in kernel_init thread to save
>> boot time and memory? Otherwise please suggest me where those dummy
>> devices
>> and sound card gets added to platform bus and the purpose of creating
>> them?
>>
>
> All of the devices and driver registered in snd_soc_init() are used.
>
> - Lars
>
>
.
