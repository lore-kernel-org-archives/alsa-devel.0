From: Andy Green <andy@warmcat.com>
Subject: Re: Acer Aspire 8920g / snd-hda-intel / ALC889
Date: Tue, 22 Apr 2008 12:28:06 +0100
Message-ID: <480DCBC6.3050203@warmcat.com>
References: <480C8260.70501@warmcat.com>	<s5hr6czb3po.wl%tiwai@suse.de>	<480CDC26.3010506@warmcat.com>	<s5h63uab2k1.wl%tiwai@suse.de>	<480DC787.9070208@warmcat.com>
	<s5h3apeb0gq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.mog.warmcat.com (purr.warmcat.com [87.106.142.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 28A7124580
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 13:28:16 +0200 (CEST)
In-Reply-To: <s5h3apeb0gq.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Somebody in the thread at some point said:

Hi -

>> I did try this, it did change the alsamixer stuff a bit and made more 
>> complaints in dmesg,
> 
> They are no complains but just positive information.

OK.

>> but didn't change the silence situation.
> 
> Hm, then the problem is somewhere different.
> You hear neither from speaker nor HP-jack?

Nothing, despite changing settings "headphone" and "IEC958" in alsamixer 
-c0 (alsamixer by itself picks up pulseaudio nowadays apparently).  It's 
as if the amp is powered down, or we route everything to modem :-) 
Never a click or a buzz.  I also have mic routing to pcm turned up and 
this makes no sound.  Entering the jack to the headphone socket also 
makes no "click" in the headphones as you could maybe expect.

Maybe there is a special GPIO floating about that enables amp power?

-Andy
