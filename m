Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Wed, 15 Jun 2016 14:43:41 +0200
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20160615124341.GA2405@localhost.localdomain>
References: <1465686096-22156-1-git-send-email-henrik@austad.us>
 <1465686096-22156-8-git-send-email-henrik@austad.us>
 <20160615114908.GB31281@localhost.localdomain>
 <20160615121303.GB5950@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160615121303.GB5950@sisyphus.home.austad.us>
Subject: Re: [alsa-devel] [very-RFC 7/8] AVB ALSA - Add ALSA shim for TSN
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, henrk@austad.us, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Henrik Austad <haustad@cisco.com>, netdev@vger.kernel.org, alsa-devel@vger.kernel.org, linux-media@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

On Wed, Jun 15, 2016 at 02:13:03PM +0200, Henrik Austad wrote:
> On Wed, Jun 15, 2016 at 01:49:08PM +0200, Richard Cochran wrote:
> And how would v4l2 benefit from this being in alsalib? Should we require 
> both V4L and ALSA to implement the same, or should we place it in a common 
> place for all.

I don't require V4L to implement anything.  You were the one wanting
AVB "devices".  Go ahead and do that, but in user space please.  We
don't want to have kernel code that sends arbitrary Layer2 and UDP
media packets.

The example you present of using aplay over the network is a cute
idea, but after all it is a trivial application.  I have nothing
against creating virtual ALSA devices (if done properly), but that
model won't work for more realistic AVB networks.

> And what about those systems that want to use TSN but is not a 
> media-device, they should be given a raw-socket to send traffic over, 
> should they also implement something in a library?

A raw socket is the way to do it, yes.

Since TSN is about bandwidth reservation and time triggered Ethernet,
decoupled from the contents of the streams, each new TSN application
will have to see what works best.  If common ground is found, then a
library makes sense to do.

At this point, it is way too early to guess how that will look.  But
media packet formats clearly belong in user space.

> So no, here I think configfs is an apt choice.
> 
> > Heck, if done properly, your layer could discover the AVB nodes in the
> > network and present each one as a separate device...
> 
> No, you definately do not want the kernel to automagically add devices 
> whenever something pops up on the network, for this you need userspace to 
> be in control. 1722.1 should not be handled in-kernel.

The layer should be in user space.  Alsa-lib *is* user space.

Thanks,
Richard
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
