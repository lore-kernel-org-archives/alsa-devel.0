From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Channel mapping
Date: Wed, 21 Nov 2007 16:27:47 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711211621310.8325@tm8103.perex-int.cz>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hr6ijhljj.wl%tiwai@suse.de>
	<1195658261.9272.1222564051@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BBEA24C53
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 16:27:48 +0100 (CET)
In-Reply-To: <1195658261.9272.1222564051@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Nov 2007, Clemens Ladisch wrote:

> Takashi Iwai wrote:
> > Yes, querying channel mapping is another missing piece with popular
> > demand.
> > 
> > The implementation would be easy, I guess.  But we have to define the
> > way to inform this from kernel to user space: whether create a new
> > ioctl or extend the existing ones (if possible)...
> 
> It's just metadata that describes a PCM device, so I think we should use
> TLV for this.
> 
> The existing struct snd_ctl_tlv uses a single integer to identify
> control elements.  We could restrict control numid's to 31 bits and
> use the upper bit to signal that this value includes device type and
> device number in the lower bits, if we want to reuse the same TLV
> ioctls.

We can also encode PCM device / subdevice numbers to data structure. But
I think that best way is to extend channel_info PCM ioctl (create new 
version and emulate old one - it should be quite easy to implement).

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
