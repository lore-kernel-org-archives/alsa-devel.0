From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CMI8788/AV200/Oxygen Volume Controls in alsamixer
 (oxygen_mixer.c:dac_volume_get())
Date: Fri, 23 Jan 2009 15:13:31 +0100
Message-ID: <4979D08B.3090103@ladisch.de>
References: <49790314.10607@dmx.com>	<4979CB63.9030205@ladisch.de>
	<s5h3afa86sw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 683B02441F
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 15:13:42 +0100 (CET)
In-Reply-To: <s5h3afa86sw.wl%tiwai@suse.de>
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
Cc: ALSA Developers <alsa-devel@alsa-project.org>, "John L. Utz III" <jutz@dmx.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > Alsamixer chooses to display an eight-channel control this way.  This
> > can be considered a bug in alsamixer.
> 
> The current ALSA mixer abstraction splits the multi-channels into
> separate paired channels.  But alsamixer can't show the channel name
> due to its UI design.

The its UI design should be changed.

> A solution would be make individual control like "Front", and create a
> virtual master control.

I am *not* going to change the driver just to accommodate to alsamixer.
I am going to change alsamixer to display the channel names (which it
already knows).


Best regards,
Clemens
