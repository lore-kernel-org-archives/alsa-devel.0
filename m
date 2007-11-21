From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Channel mapping
Date: Wed, 21 Nov 2007 16:52:20 +0100
Message-ID: <1195660340.16225.1222569047@webmail.messagingengine.com>
References: <20071120005151.GA25276@tango.0pointer.de>
	<s5hr6ijhljj.wl%tiwai@suse.de>
	<1195658261.9272.1222564051@webmail.messagingengine.com>
	<Pine.LNX.4.61.0711211621310.8325@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D2C3324352
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 16:52:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0711211621310.8325@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 21 Nov 2007, Clemens Ladisch wrote:
> > Takashi Iwai wrote:
> > > Yes, querying channel mapping is another missing piece with popular
> > > demand.
> > > 
> > > The implementation would be easy, I guess.  But we have to define the
> > > way to inform this from kernel to user space: whether create a new
> > > ioctl or extend the existing ones (if possible)...
> > 
> > It's just metadata that describes a PCM device, so I think we should use
> > TLV for this.
> > 
> > The existing struct snd_ctl_tlv uses a single integer to identify
> > control elements.  We could restrict control numid's to 31 bits and
> > use the upper bit to signal that this value includes device type and
> > device number in the lower bits, if we want to reuse the same TLV
> > ioctls.

Using a ioctl on the ctl device is difficult if the information is
dependent on the hw_params, so this isn't a good idea.

> We can also encode PCM device / subdevice numbers to data structure. But
> I think that best way is to extend channel_info PCM ioctl (create new 
> version and emulate old one - it should be quite easy to implement).

The channel_info ioctl returns only information about one channel.

I think we should have a more flexible ioctl that also allows us to
describe the PCM device itself (such as volume controls that affect
all channels, or latency information).


Regards,
Clemens
