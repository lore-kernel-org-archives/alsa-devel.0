From: Andy Green <andy@warmcat.com>
Subject: Re: Acer Aspire 8920g / snd-hda-intel / ALC889
Date: Mon, 05 May 2008 23:06:50 +0100
Message-ID: <481F84FA.4060307@warmcat.com>
References: <480C8260.70501@warmcat.com>	<s5hr6czb3po.wl%tiwai@suse.de>	<480CDC26.3010506@warmcat.com>	<s5h63uab2k1.wl%tiwai@suse.de>	<480DC787.9070208@warmcat.com>	<s5h3apeb0gq.wl%tiwai@suse.de>	<480DCBC6.3050203@warmcat.com>	<480FA5D5.9090208@warmcat.com>
	<s5h3apakthj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.mog.warmcat.com (purr.warmcat.com [87.106.142.209])
	by alsa0.perex.cz (Postfix) with ESMTP id C6EAE24538
	for <alsa-devel@alsa-project.org>;
	Tue,  6 May 2008 00:07:00 +0200 (CEST)
In-Reply-To: <s5h3apakthj.wl%tiwai@suse.de>
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

> Build CONFIG_SND_HDA_HWDEP=y and you'll have /dev/snd/hwC0D0 device.
> With the hda-verb program in the URL below, you can exec the verb on
> the fly:
> 	ftp://ftp.suse.com/pub/people/tiwai/misc/hda-verb-0.2.tar.bz2

Thanks for the hints and the applet... after some meddling around I 
found the magic incantations to fire up the amp / speakers on this 
laptop are to force model=acer-aspire in /etc/modprobe.conf, then using 
the applet from the URL quoted above:

./hda-verb /dev/snd/hwC0D0 0x15 SET_EAPD_BTLENABLE 2

I confirmed stereo operation...  it doesn't react to headphone 
insertion, plays audio through speakers and headphone jack in that case. 
    Didn't try 5.1 (this laptop has a 5.1 speaker set) yet but I 
wouldn't be surprised if that was trouble too.  Still this is waaaay 
better than silence!  Thanks again for the help.

-Andy
