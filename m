From: David Dillow <dave@thedillows.org>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Wed, 23 Jun 2010 16:42:12 -0400
Message-ID: <1277325732.2521.55.camel@lap75545.ornl.gov>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
	<AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
	<1277129180.22889.64.camel@obelisk.thedillows.org>
	<AANLkTikW71h7ABVXY21pLL9AeOlmRTfVaSTjJ_6Ma0_R@mail.gmail.com>
	<AANLkTikCGzUKe9Fy1d0xhberqGFe71lvrQbg5gkQzgf1@mail.gmail.com>
	<AANLkTikPW9j4H15gq7nl0Tb213R15uIQAnSDi_cTOJre@mail.gmail.com>
	<1277262047.10818.9.camel@obelisk.thedillows.org>
	<1277271419.10818.22.camel@obelisk.thedillows.org>
	<AANLkTiln40Xo3fHbMSkEvdBUtFq8ZWrF57wgRWdU2Juc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emroute3.ornl.gov (emroute3.ornl.gov [160.91.4.110])
	by alsa0.perex.cz (Postfix) with ESMTP id DCC4B243B1
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 22:42:18 +0200 (CEST)
Received: from emroute3.ornl.gov ([127.0.0.1])
	by emroute3.ornl.gov (PMDF V6.5 #31823)
	with ESMTP id <0L4H00CHWIUFF0@emroute3.ornl.gov> for
	alsa-devel@alsa-project.org; Wed, 23 Jun 2010 16:42:16 -0400 (EDT)
In-reply-to: <AANLkTiln40Xo3fHbMSkEvdBUtFq8ZWrF57wgRWdU2Juc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux@schou.dk
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-06-23 at 20:22 +0200, Hans Schou wrote:
> 2010/6/23 David Dillow <dave@thedillows.org>:
> 
> > I can reproduce the alternating pattern of periods using a different
> > device, so this may be something in the core code of ALSA.
> 
> Strange? The program I am actually using is one I have written myself.
> I was sure I was using the old method as I open(2). In my program I
> use
>    int fd = open("/dev/dsp",  O_RDWR);
> 
> This should not go through ALSA (I think). I gues one should use
> something with "snd_pcm_open()" to use ALSA.

To use ALSA directly, yes. However, there is no OSS SIS7019 driver in
the kernel, only the ALSA one I wrote. There is an OSS emulation layer,
so you can use the OSS API to talk to the ALSA core. Unless you are
using a vendor (SIS/MicroJr/etc.) supplied driver, you are using ALSA in
some capacity.

> > Since this problem is not related to the SiS7019 driver, I'll leave it
> > to later -- or for others to investigate. Using three periods per buffer
> > sees a similar pattern, but one has an extra period time to work
> > within.
> 
> I really don't understand why I do not see this problem on other
> hardware using the same compiled code.

You mean the 10 second pauses during recording after 42 minutes? That is
a driver bug, so it is specific to this card.

If you mean the alternating long/sort period times, then it is present
on other hardware, but you likely don't see it either due to the
defaults giving you more periods to work in so you don't see overruns,
faster hardware than the SIS550 CPU, or a combination of the two. The
bug that gives rise to the 10 second pauses can also shorten the periods
I think, making overruns more likely to occur.

Dave
