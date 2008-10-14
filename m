From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: Salsa-lib : _snd_pcm_hw_param_test is not defined
Date: Tue, 14 Oct 2008 09:46:16 +0200
Message-ID: <48F44E48.706@parrot.com>
References: <48F3198F.50409@parrot.com>	<s5hskr07quh.wl%tiwai@suse.de>	<48F354A3.6090501@parrot.com>
	<s5hk5cc60a1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from toronto.xi-lite.net (co203.xi-lite.net [149.6.83.203])
	by alsa0.perex.cz (Postfix) with ESMTP id CFAE624410
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 09:46:41 +0200 (CEST)
In-Reply-To: <s5hk5cc60a1.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai a =E9crit :
> At Mon, 13 Oct 2008 16:01:07 +0200,
> Matthieu CASTET wrote:
>> Hi,
>>
>> Takashi Iwai a =E9crit :
>>> At Mon, 13 Oct 2008 11:49:03 +0200,
>>> Matthieu CASTET wrote:
>>>> Hi,
>>>>
>>>> it seems there is a missing implementation of _snd_pcm_hw_param_test
>>>> function in src/pcm_params.c .
>>>>
>>>> It is used in pcm_macros.h by snd_pcm_hw_params_test_xxx functions.
>>> Thanks for reporting.  =

>> Thanks for your quick reply.
>>
>>> Does the patch below works?
>> Hum,
>>
>> dir is a pointer, but _snd_pcm_hw_param_set want a integer.
> =

> Oops, the fixed patch is below.
> =

Ok sound better.
But why _snd_pcm_hw_param_test take a pointer and not a integer. All
snd_pcm_hw_params_test_xxx seems to take a dir as integer.

>> BTW, some application expect snd_config (from cards.c) to be not null
>> after a call to snd_config_update.
> =

> Hm, which apps?
> =

portaudio.


Matthieu
