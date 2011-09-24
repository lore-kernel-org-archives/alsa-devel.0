From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [patch][saa7134] do not change mute state for
	capturing audio
Date: Sat, 24 Sep 2011 09:46:29 -0300
Message-ID: <4E7DD125.4070506@infradead.org>
References: <4E19D2F7.6060803@list.ru> <4E257FF5.4040401@infradead.org>
	<4E258B60.6010007@list.ru> <4E25906D.3020200@infradead.org>
	<4E259B0C.90107@list.ru> <4E25A26A.2000204@infradead.org>
	<4E25A7C2.3050609@list.ru> <4E25C7AE.5020503@infradead.org>
	<4E25CF35.7000802@list.ru> <4E25DB37.8020609@infradead.org>
	<4E25FDE4.7040805@list.ru> <4E262772.9060509@infradead.org>
	<4E266799.8030706@list.ru> <4E26AEC0.5000405@infradead.org>
	<4E26B1E7.2080107@list.ru> <4E26B29B.4010109@infradead.org>
	<4E292BED.60108@list.ru> <4E296D00.9040608@infradead.org>
	<4E296F6C.9080107@list.ru> <4E2971D4.1060109@infradead.org>
	<4E29738F.7040605@list.ru> <4E297505.7090307@infradead.org>
	<4E29E02A.1020402@list.ru> <4E2A23C7.3040209@infradead.org>
	<4E2A7BF0.8080606@list.ru> <4E2AC742.8020407@infradead.org>
	<4E2ACAAD.4050602@list.ru> <4E2AE40F.7030108@infradead.org>
	<4E2C5A35.9030404@list.ru> <4E2C6638.2040707@infrade ad.org>
	<4E760BCA.6080900@list.ru> <4E7DC7A6.7030000@infradead.org>
	<4E7DCE13.5030009@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	by alsa0.perex.cz (Postfix) with ESMTP id C7D68244AC
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Sep 2011 14:46:38 +0200 (CEST)
In-Reply-To: <4E7DCE13.5030009@list.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@list.ru>
Cc: "Nickolay V. Shmyrev" <nshmyrev@yandex.ru>, Lennart Poettering <lpoetter@redhat.com>, ALSA devel <alsa-devel@alsa-project.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em 24-09-2011 09:33, Stas Sergeev escreveu:
> 24.09.2011 16:05, Mauro Carvalho Chehab wrote:
>>
>> Better to post it as a separate patch, and to simplify the code with:
>>
>> diff --git a/drivers/media/video/saa7134/saa7134-tvaudio.c b/drivers/media/video/saa7134/saa7134-tvaudio.c
>> index 57e646b..a61ed1e 100644
>> --- a/drivers/media/video/saa7134/saa7134-tvaudio.c
>> +++ b/drivers/media/video/saa7134/saa7134-tvaudio.c
>> @@ -332,6 +332,12 @@ static int tvaudio_checkcarrier(struct saa7134_dev *dev, struct mainscan *scan)
>>   {
>>       __s32 left,right,value;
>>
>> +    if (!dev->tvnorm->id&  scan->std)) {
> Missing open bracket?

Yes. patch were of course not tested ;)

I meant to say:

	if (!(dev->tvnorm->id &  scan->std)) {


> 
>>> @@ -546,6 +546,7 @@ static int tvaudio_thread(void *data)
>>>                   dev->tvnorm->name, carrier/1000, carrier%1000,
>>>                   max1, max2);
>>>               dev->last_carrier = carrier;
>>> +            dev->automute = !(dev->thread.scan1>  1);
>> Why?
> Unfortunately, that's the trick. :(
> 
>>
>> If the carrier is good, this should be enough:
>>
>>             dev->automute = 0;
> Unfortunately, sometimes it misdetects.

There's nothing the driver can do if the hardware missdetects a carrier.
Dirty tricks to try solving it are not good, as they'll do the wrong
thing on some situations.

> Testing dev->thread.scan1 means that at least
> the first scan, done on the driver init, won't
> unmute.
> So either that, or this whole patch is unhelpful.
> I realize that this is a dirty hack, yes.

This is a dirty hack, and it assumes that the first scan
should be discarded. This is true only on certain environments.
If someone is using the board on an environment without udev and 
pulseaudio, this trick will break the first tuning.

>> The rest looked sane on my eyes, but I didn't double-checked it by running on my cards. Had you test calling it with just a single standard, and with a multiple standards mask? 
> With just a single standard. That's the problem too.
> There are the fallbacks, like last_carrier etc, and do we
> need to unmute there or not? :(
> 
>> The right fix that pulseaudio should not touch at the audio mixers for the video boards.
> That's where we disagree.
> I wonder what other people think.
> I don't see the compelling reason for making the
> alsa interface to the v4l devs a special case. If there
> is just a mute control exported, there is no more a special
> case, and no more hacks and problems.
> 
>> Not all boards have an audio carrier detection like saa7134.
> Having the mute control exported would make this
> not a problem.

Well, if you think that this would solve, then just write a patch
exporting the mute control via ALSA. I have no problems with that.

Regards,
Mauro.
