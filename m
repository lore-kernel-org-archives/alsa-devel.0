From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Fri, 01 Oct 2010 18:29:15 +0200
Message-ID: <4CA60C5B.6010809@ladisch.de>
References: <4C9DC7A1.8050001@showlabor.de> <4CA5BF35.2030108@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A972424478
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 18:28:27 +0200 (CEST)
In-Reply-To: <4CA5BF35.2030108@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> I guess the right place to fix the issues mentioned in my original post
> is in snd_usb_init_substream() in urb.c:
> 
>          case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
>              subs->ops.prepare_sync = prepare_playback_sync_urb;
>              subs->ops.retire_sync = retire_playback_sync_urb;
> 
> I've tried combinations using the _hs and _emu versions of the
> retire.../prepare... functions. It either didn't change anything or made
> it worse. I guess we need  _ftu versions.
> 
> Could somebody at least tell me how to find out what's exactly going
> wrong with the sync.

Add an else to the inner if in retire_playback_sync_urb, and log the
value of f.

The value received in this function should be the desired sample
frequency, relative to the USB frame rate.  There are different formats
(therefore we have three functions); maybe the FTU uses a fourth one.


Regards,
Clemens
