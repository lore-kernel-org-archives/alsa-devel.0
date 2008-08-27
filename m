From: "John L. Utz III" <john.utz@dmx.com>
Subject: Re: i think ac97 needs an is_surback_on() function
Date: Wed, 27 Aug 2008 15:02:05 -0700
Message-ID: <op.ugkfhrwh647oa9@jutz-gnto64>
References: <op.uga6zvtg647oa9@jutz-gnto64>
 <s5h8wuld2xn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A94124807
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 00:02:23 +0200 (CEST)
In-Reply-To: <s5h8wuld2xn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 24 Aug 2008 23:27:48 -0700, Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 22 Aug 2008 15:20:09 -0700,
> John L. Utz III wrote:
>>
>> ac97_patch.c provides two helper functions that wrap the channel_mode
>> variable, but they only take you out to 5.1 Audio:
>>
>> static inline int is_surround_on(struct snd_ac97 *ac97)
>> {
>> 	return ac97->channel_mode >= 1;
>> }
>>
>> static inline int is_clfe_on(struct snd_ac97 *ac97)
>> {
>> 	return ac97->channel_mode >= 2;
>> }
>>
>>
>> For 7.1 Audio, i think there needs to be a test for 'Surround Back' or
>> 'Back Surround'
>>
>> static inline int is_surback_on(struct snd_ac97 *ac97)
>> {
>> 	return ac97->channel_mode >= 4;
>> }
>>
>>
>> Am i correct? or am i mistaken? agreement or corrections appreciated!
>
> It's correct.  The code for 7.1-audio capability was added recently.

Good. I'm not crazy then. Ok, maybe i am, but not about this. :-)

I'll submit this in follow on work to support creating an improved  
via8237.conf

tnx!

johnu

>
> Takashi
>
