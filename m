From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Hi ALSA Team - serious technical question from Ron
Date: Mon, 12 Jun 2006 17:53:49 +0100
Message-ID: <1150131229.29587.13.camel@localhost.localdomain>
References: <4c84399f0606042324o10e15f92t3320621c2f9064f9@mail.gmail.com>
	<4489CAAD.4010900@boosthardware.com>
	<1150109573.21190.13.camel@localhost.localdomain>
	<4c84399f0606120923t18e90c09w718643cc49670f9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4c84399f0606120923t18e90c09w718643cc49670f9a@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ronald Stewart <ronaldjstewart@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net, Patrick Shirkey <pshirkey@boosthardware.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-06-12 at 09:23 -0700, Ronald Stewart wrote:
> 
> Oh yeah this is AWESOME!!! 
> this is beautiful but lee mentioned it was available in the sources
> section,
> how do I find alsa-kernel/arm/pxa2xx* and other sources?

You can find the original ALSA pxa2xx audio driver in your (recent) 2.6
kernel sources. Just look in linux/sound/arm/.

The ASoC patches can all be found here:-

http://www.rpsys.net/openzaurus/patches/alsa/

I have some clean up work todo before releasing ASoC 0.10 later this
week. I'll try and add 24 bit support to the ssp driver if I can get
some time, otherwise I'll put it into the 0.11 release.

Liam
