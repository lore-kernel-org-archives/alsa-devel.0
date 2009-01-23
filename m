From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CMI8788/AV200/Oxygen Volume Controls in alsamixer
 (oxygen_mixer.c:dac_volume_get())
Date: Fri, 23 Jan 2009 14:51:31 +0100
Message-ID: <4979CB63.9030205@ladisch.de>
References: <49790314.10607@dmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id CC3302441A
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 14:51:34 +0100 (CET)
In-Reply-To: <49790314.10607@dmx.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "John L. Utz III" <jutz@dmx.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

John L. Utz III wrote:
> It appears to me that these functions are attempting to work on all of 
> the channels at once instead of just choosing Master, Front, Rear, 
> Surround, or what have you:

Yes, the "Master" control is one control with eight channels.

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


Best regards,
Clemens
