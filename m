From: "John Utz" <John.Utz@dmx.com>
Subject: Re: CMI8788/AV200/Oxygen Volume Controls in alsamixer
 (oxygen_mixer.c:dac_volume_get())
Date: Fri, 23 Jan 2009 11:08:23 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5A02143CE1@sea-exch-01.na.corp.dmxmusic.com>
References: <49790314.10607@dmx.com> <4979CB63.9030205@ladisch.de>
	<s5h3afa86sw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id E92E81038D7
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 20:10:04 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

using exchange webmail today, sorry.

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Fri 1/23/2009 5:56 AM
To: Clemens Ladisch
Cc: John Utz; ALSA Developers
Subject: Re: [alsa-devel] CMI8788/AV200/Oxygen Volume Controls in alsamixer (oxygen_mixer.c:dac_volume_get())
 
At Fri, 23 Jan 2009 14:51:31 +0100,
Clemens Ladisch wrote:
> 
> John L. Utz III wrote:
> > It appears to me that these functions are attempting to work on all of 
> > the channels at once instead of just choosing Master, Front, Rear, 
> > Surround, or what have you:
> 
> Yes, the "Master" control is one control with eight channels.
> 
> > this leads to a rather awkward result in alsamixer where there are 5 
> > volume controls called "Master":
> > 
> > < Master >  Master    Master    Master    Master
> > 
> > IMHO, it would be more desirable for them to say:
> > 
> > < Master >  Front     C/LFE     Surround  Rear Surr
> 
> Yes.
> 
> Alsamixer chooses to display an eight-channel control this way.  This
> can be considered a bug in alsamixer.

The current ALSA mixer abstraction splits the multi-channels into
separate paired channels.  But alsamixer can't show the channel name
due to its UI design.  And I guess other mixer apps don't handle them
properly, too (who would care?).

A solution would be make individual control like "Front", and create a
virtual master control.


JU a virtual control in the conf file or in the driver?

Takashi
