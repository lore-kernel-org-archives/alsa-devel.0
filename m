From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/3] ASoC: Blackfin: Add bf5xx-adau1701
 machine driver
Date: Fri, 10 Jun 2011 20:13:03 +0200
Message-ID: <4DF25EAF.7050203@metafoo.de>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
	<1307726331-28618-2-git-send-email-lars@metafoo.de>
	<20110610173004.GJ26441@sirena.org.uk>
	<4DF25959.9060603@metafoo.de>
	<20110610180256.GQ26436@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 78CD5103D3F
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 20:14:02 +0200 (CEST)
In-Reply-To: <20110610180256.GQ26436@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 06/10/2011 08:02 PM, Mark Brown wrote:
> On Fri, Jun 10, 2011 at 07:50:17PM +0200, Lars-Peter Clausen wrote:
>> On 06/10/2011 07:30 PM, Mark Brown wrote:
> 
>>> So, I keep on complaining about the way these drivers are just generic
>>> to any random Blackfin plus CODEC combination rather than being board
>>> specific.  It'd be good if we could improve this, even adding something
>>> into the driver name to make it clear these are for the EVB would help.
> 
>> I think this is due, that the codecs them-self sit on an add-on board to the
>> bf5xx eval boards.
>> So you have two boards, the bf5xx eval board with has the codec eval board
>> connected to it. That's why it it is kept so generic. You could connect the
>> codec eval board to any of the bf5xx boards.
> 
> I'd be more happy with that if there were some indication in the code
> that this was for the standard Blackfin EVBs rather than all systems
> based on Blackfin.

I could rename the machine driver to bf5xx-adau1701-evb for v2.

- Lars
