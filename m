From: Markus Korber <korbse@gmx.at>
Subject: Re: ALSA lib troubles with xine
Date: Mon, 03 Sep 2007 17:38:40 +0200
Message-ID: <46DC2A80.6030908@gmx.at>
References: <6zk5r8fdev.fsf@odpc25.int.ondemand.co.at>	<6zd4x0f9q3.fsf@odpc25.int.ondemand.co.at>	<Pine.LNX.4.61.0709031024070.14792@tm8103.perex-int.cz>	<6zir6sayq5.fsf@odpc25.int.ondemand.co.at>	<s5hbqcjew7b.wl%tiwai@suse.de>	<6zejhf94z0.fsf@odpc25.int.ondemand.co.at>
	<s5hzm03dces.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 354FB10383F
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 17:38:42 +0200 (CEST)
In-Reply-To: <s5hzm03dces.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> At Mon, 03 Sep 2007 16:52:03 +0200,
> Markus Korber wrote:
>> Thus spake Takashi Iwai:
>>
>>> At Mon, 03 Sep 2007 11:24:02 +0200,
>>> Markus Korber wrote:
>>>
>>>> However, the sound is stuttering a lot (I guess this is a xine-lib
>>>> issue).
>>> Can you install older versions of ALSA-lib *manually* and check in
>>> which version the bug doesn't appear?  Then we can pin-point the
>>> change.
>> Ok, so I compiled alsa-lib, installed libasound.so, and recompiled the
>> xine alsa output module against the appropriate alsa-lib:
>>
>> 1.0.13    : failed
>> 1.0.14a   : failed
>> 1.0.15rc1 : failed
>>
>> Any ideas?  
>>
>> Perhaps xine-lib doesn't work well if buffer_size = 2*period_size?
> 
> It depends on the setting.
> Did it ever work with any version?

No.  However, other applications work perfectly (mplayer, alsaplayer, 
aplay).

Regards,
Markus Korber
