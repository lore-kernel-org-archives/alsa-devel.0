From: william estrada <MrUmunhum@popdial.com>
Subject: Re: different user causes 'no such device'
Date: Tue, 09 Oct 2007 09:27:04 -0700
Message-ID: <470BABD8.4020709@popdial.com>
References: <4703F3AF.8000806@popdial.com> <s5h3awkve8l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 0092624710
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Oct 2007 18:26:29 +0200 (CEST)
In-Reply-To: <s5h3awkve8l.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks, I did a 'chmod -R 666 /dev/snd/' and it worked.

Now how do I make the hot plugged USB sound device use these setting??

Thanks for your time.

William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum



Takashi Iwai wrote:
> At Wed, 03 Oct 2007 12:55:27 -0700,
> william estrada wrote:
>> Hi guys,
>>
>>    I have what seams like a interesting problem.  I have written an ALSA app
>> to record wav files and it runs while I am logged in an terminal as the
>> logged in Gnome user or root.  But when I su to another user, it can't
>> find the default sound card.
>>
>>    I am running FC6.  I tried changing own of /dev/dsp to 'nobody', that did
>> not work.
>>
>>    Anyone know of this problem and a fix for it.
>>
>>    Thanks for your time.
>>
>> -- 
>> William Estrada
>> MrUmunhum@popdial.com
>> Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
>> Ymessenger: MrUmunhum
>>
>>> MSGrec - Version 1.1, Mt-Umunhum-Wireless.net
>>> WavMSG: Paused: enter 'q' to stop, <ENTER> to start.
>>> ALSA lib confmisc.c:848:(snd_func_card_driver) cannot find card '0'
>>> ALSA lib conf.c:3500:(_snd_config_evaluate) function snd_func_card_driver returned error: No such device
>>> ALSA lib confmisc.c:397:(snd_func_concat) error evaluating strings
>>> ALSA lib conf.c:3500:(_snd_config_evaluate) function snd_func_concat returned error: No such device
>>> ALSA lib confmisc.c:1248:(snd_func_refer) error evaluating name
>>> ALSA lib conf.c:3500:(_snd_config_evaluate) function snd_func_refer returned error: No such device
>>> ALSA lib conf.c:3972:(snd_config_expand) Evaluate error: No such device
>>> ALSA lib pcm.c:2145:(snd_pcm_open_noupdate) Unknown PCM default
> 
> ALSA-native apps access only ALSA device files, usually /dev/snd/*,
> not /dev/dsp*, those for OSS.  In this case, it should be
> /dev/snd/controlC* files.  Check the premission of these files.
> 
> 
> Takashi
> 
