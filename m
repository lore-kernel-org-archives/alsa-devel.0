From: "John L. Utz III" <jutz@dmx.com>
Subject: Re: CMI8788/AV200/Oxygen Volume Controls in alsamixer
 (oxygen_mixer.c:dac_volume_get())
Date: Mon, 26 Jan 2009 15:36:59 -0800
Message-ID: <497E491B.8020104@dmx.com>
References: <49790314.10607@dmx.com> <4979CB63.9030205@ladisch.de>
	<s5h3afa86sw.wl%tiwai@suse.de> <4979D08B.3090103@ladisch.de>
	<F8FB97052F1BEF409F7842E960E49B5A02143CE2@sea-exch-01.na.corp.dmxmusic.com>
	<497D7993.8070009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 310D01037EA
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 00:38:25 +0100 (CET)
In-Reply-To: <497D7993.8070009@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: John Utz <John.Utz@dmx.com>, Takashi Iwai <tiwai@suse.de>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> John Utz wrote:
>> if my employer decides that we will use the card
> 
> If you're thinking about the Xonar D2/D2X: please note that I removed
> the "Master" control in the latest kernel in the hope of fixing some
> unexplained bug where the card's EEPROM would be deleted.  (I think that
> I may be able to prove that the Master control isn't related to this
> bug, and revert that change.)

Good to know, but not relevant in our case, we are exploring the D1.

>> (not entirely clear, it's expensive and IMHO the sound quality isnt
>> worth the money)
> 
> The Xonar D1/DX has almost the same capabilities as the D2/D2X (in Linux)
> and is more reasonably priced.

It's definitely reasonable when compared to the D2, but it's still 
relatively expensive.

> What are your requirements?

Low price, good power output on *all* channels, good fidelity. robust 
linux multichannel support.

not a big list, eh?. :-)

onboard stuff tends to only provide amplification on the front channels 
and expects that the user will provide a separate amplifier for rear and 
surround.

Sound *cards* tend to have onboard amps for all the channels because 
they have the pcb real-estate to spare for that sort of thing.

> 
> Best regards,
> Clemens
> 
