From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CMI8788/AV200/Oxygen Volume Controls in alsamixer
 (oxygen_mixer.c:dac_volume_get())
Date: Mon, 26 Jan 2009 09:51:31 +0100
Message-ID: <497D7993.8070009@ladisch.de>
References: <49790314.10607@dmx.com> <4979CB63.9030205@ladisch.de>
	<s5h3afa86sw.wl%tiwai@suse.de> <4979D08B.3090103@ladisch.de>
	<F8FB97052F1BEF409F7842E960E49B5A02143CE2@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 3EA4824332
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2009 09:51:37 +0100 (CET)
In-Reply-To: <F8FB97052F1BEF409F7842E960E49B5A02143CE2@sea-exch-01.na.corp.dmxmusic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Utz <John.Utz@dmx.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

John Utz wrote:
> if my employer decides that we will use the card

If you're thinking about the Xonar D2/D2X: please note that I removed
the "Master" control in the latest kernel in the hope of fixing some
unexplained bug where the card's EEPROM would be deleted.  (I think that
I may be able to prove that the Master control isn't related to this
bug, and revert that change.)

> (not entirely clear, it's expensive and IMHO the sound quality isnt
> worth the money)

The Xonar D1/DX has almost the same capabilities as the D2/D2X (in Linux)
and is more reasonably priced.

What are your requirements?


Best regards,
Clemens
