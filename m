From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Moving sound/* to drivers/ ?
Date: Wed, 21 May 2008 19:37:54 -0400
Message-ID: <4834B252.1080700@garzik.org>
References: <s5hzlqjz74d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934940AbYEUXiS@vger.kernel.org>
In-Reply-To: <s5hzlqjz74d.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> While we are at the issue ALSA HG <-> GIT transition...
> 
> One thing that annoys me sometimes is that the sound driver codes are
> on a different subdirectory than other normal drivers, namely under
> /sound.   I don't remember exactly why it came there, but this often
> makes people forget to change the necessary code for the sound
> subsystem, or slip from the statistics (I'm not sure whether Linus
> counted sound/* with recent his posts).
> 
> If I understand correctly, with git, we can move the files in
> relatively little costs.  So, what about moving sound/* back to
> drivers/sound/* or drivers/media/sound/*?
> 
> Of course, the primary question is whether it's really worth.
> The obvious drawback is that patches won't be applicable after the
> move.  So, if we do it, doing at the last seems practical.  But, this
> can be a bit problem with keeping such a change on linux-next until
> the next merge...
> 
> And, another question is to where.  drivers/sound or
> drivers/media/sound, or whatever.

Speaking as a former OSS driver maintainer, I always preferred 
drivers/sound.

Though Rene's suggestion (use both sound/ and drivers/sound/) might make 
sense if the subsystem code is huge -- I supported the drivers/block/ -> 
block/ code movement for example.

	Jeff
