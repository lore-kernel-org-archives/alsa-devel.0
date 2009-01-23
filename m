From: "John Utz" <John.Utz@dmx.com>
Subject: Re: CMI8788/AV200/Oxygen Volume Controls in alsamixer
 (oxygen_mixer.c:dac_volume_get())
Date: Fri, 23 Jan 2009 11:21:57 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5A02143CE2@sea-exch-01.na.corp.dmxmusic.com>
References: <49790314.10607@dmx.com> <4979CB63.9030205@ladisch.de>
	<s5h3afa86sw.wl%tiwai@suse.de> <4979D08B.3090103@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 225121038D7
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 20:22:09 +0100 (CET)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org




-----Original Message-----
From: Clemens Ladisch [mailto:clemens@ladisch.de]
Sent: Fri 1/23/2009 6:13 AM
To: Takashi Iwai
Cc: ALSA Developers; John Utz
Subject: Re: [alsa-devel] CMI8788/AV200/Oxygen Volume Controls in alsamixer (oxygen_mixer.c:dac_volume_get())
 
Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > Alsamixer chooses to display an eight-channel control this way.  This
> > can be considered a bug in alsamixer.
> 
> The current ALSA mixer abstraction splits the multi-channels into
> separate paired channels.  But alsamixer can't show the channel name
> due to its UI design.

The its UI design should be changed.

JU It's *not* the UI, amixer shows the same thing

> A solution would be make individual control like "Front", and create a
> virtual master control.

I am *not* going to change the driver just to accommodate to alsamixer.

JU nobody is asking you to, if my employer decides that we will use the card (not entirely clear, it's expensive and IMHO the sound quality isnt worth the money) then i will be tasked with making this work.
JU i will figure out a functional solution that allows the CMI8788 to appear to our app as a 'ALSA traditional' mixer api, be it compiled code or  alsa card config fu.

I am going to change alsamixer to display the channel names (which it
already knows).

JU I am thinking that this perspective is not likely to lead to a successful outcome.
JU Do keep in mind that your current implementation *works* for *humans*, they can figure out which is the right slider to move.
JU *Programs* are hosed tho, because they depend on unique control identification.
JU I will save my rant about how misguided it was to put english strings in a driver for another day. :-(
JU We are stuck with it. The only way that will change will be if a new sound project where to be invented, just like ALSA replaced OSS.

Best regards,
Clemens
