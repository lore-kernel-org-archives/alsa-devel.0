From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [RFC][PATCH] fall back to reserved minor numbers
Date: Fri, 14 May 2010 16:55:26 +0800
Message-ID: <20100514085526.GA7827@localhost>
References: <20100514032827.GA10883@localhost> <s5hpr0yq4mg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 33086244BD
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 10:55:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpr0yq4mg.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, May 14, 2010 at 04:17:27PM +0800, Takashi Iwai wrote:
> At Fri, 14 May 2010 11:28:28 +0800,
> Wu Fengguang wrote:
> > 
> > When the static minor numbers collide because of too many devices,
> > fall back to the reserved minor numbers 2 and 3.
> > 
> > This for example will allow Intel HDMI audio driver to create three PCM
> > devices (index 3, 7, 8; the minor number of the last index will
> > otherwise collide with the first record device).
> > 
> > The other option is to force enable CONFIG_SND_DYNAMIC_MINORS.
> > 
> > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> 
> Well, frankly, I don't see a big merit of doing this.
> 
> Most (all?) 2.6-based distros are using udev, thus
> CONFIG_SND_DYNAMIC_MINORS should be used there.  The rest is for old
> distros or for some limited systems like embedded devices, and they
> won't need so much PCM devices.
> 
> Even if we do this, it doesn't make sense unless the user-space side
> creates the corresponding device node.

I was afraid of this case: an embedded system with G45 HDMI codec.
This codec only has 1 PCM playback device, however the driver still
requires enabling CONFIG_SND_DYNAMIC_MINORS in order to support more
capable HDMI codecs.

Thanks,
Fengguang
