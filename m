From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Echo Fireworks control protocol (was Re: Sample program for hwdep
	interface)
Date: Mon, 10 Feb 2014 01:53:02 +0900
Message-ID: <52F7B26E.1000703@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
	<52B45837.2080804@sakamocchi.jp>
	<20131221101123.GA17855@marvin.atrad.com.au>
	<52C93F8B.1010701@sakamocchi.jp> <20140112142230.4aacdc9e@stein>
	<52D2B41B.7090505@sakamocchi.jp> <20140202145850.1f8684b3@stein>
	<52F62FA0.6040809@sakamocchi.jp>
	<20140209114228.GB15049@marvin.atrad.com.au>
	<20140209155145.2175d147@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20140209155145.2175d147@stein>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Stefan Richter <stefanr@s5r6.in-berlin.de>, Jonathan Woithe <jwoithe@just42.net>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

> Sure, definitely; my point was that the kernel ABI which userspace mixer
> applications are going to use could be
>    a) the ALSA hwdep interface, or
>    b) the ALSA hwdep interface together with firewire-core's firewire-cdev
>       interface,
> but I understood that b) is the first choice.  Specifically, provide in
> ALSA hwdep only the absolutely necessary interfaces and do as much as
> possible via firewire-cdev.

Exactly.

> and because some devices (which ones?) may have write-only registers,
> of which both streaming driver and mixer application want to know
> what is being written there.

For this purpose, ALSA Control interface can also be used. One example 
is M-Audio 'Firewire 1814', see:
[PATCH 52/52] bebob: Add support for M-Audio special Firewire series
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071873.html

And See:
[alsa-devel] include/uapi/firewire.h for other firewire drivers
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/068069.html

(This device has another bit issue but here I don't mention about it.)

> Furthermore, it can't be a kernel interface like sysfs or configfs
> because of the complexity and variety of control protocols of FireWire
> audio devices.

Indeed.


Takashi Sakamoto
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
