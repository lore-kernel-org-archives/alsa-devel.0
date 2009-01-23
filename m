From: "John Utz" <John.Utz@dmx.com>
Subject: Re: CMI8788/AV200/Oxygen Volume Controls in alsamixer
 (oxygen_mixer.c:dac_volume_get())
Date: Fri, 23 Jan 2009 11:07:56 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5A02143CE0@sea-exch-01.na.corp.dmxmusic.com>
References: <49790314.10607@dmx.com> <4979CB63.9030205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 47FAC1038D7
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 20:08:10 +0100 (CET)
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Sorry in advance about how i write mail today, i am working from home so i have to use exchange webmail.

-----Original Message-----
From: Clemens Ladisch [mailto:clemens@ladisch.de]
Sent: Fri 1/23/2009 5:51 AM
To: John Utz
Cc: ALSA Developers
Subject: Re: [alsa-devel] CMI8788/AV200/Oxygen Volume Controls in alsamixer (oxygen_mixer.c:dac_volume_get())
 
John L. Utz III wrote:
> It appears to me that these functions are attempting to work on all of 
> the channels at once instead of just choosing Master, Front, Rear, 
> Surround, or what have you:

Yes, the "Master" control is one control with eight channels.

JU Argh, yet another implementation strategy from a vendor. Too bad, but remember, this is why we use ALSA now instead of OSS. :-)

> this leads to a rather awkward result in alsamixer where there are 5 
> volume controls called "Master":
> 
> < Master >  Master    Master    Master    Master
> 
> IMHO, it would be more desirable for them to say:
> 
> < Master >  Front     C/LFE     Surround  Rear Surr

Yes.

Alsamixer chooses to display an eight-channel control this way.  This
can be considered a bug in alsamixer.

JU It *could*, but that's probably an impractical perspective. zillions of other drivers present this data in the way that amixer, alsamixer and many other mixers expect. 

Best regards,
Clemens
