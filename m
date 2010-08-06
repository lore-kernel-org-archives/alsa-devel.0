From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Hiding unused CODEC mixer widgets in
	the	machine driver
Date: Fri, 6 Aug 2010 12:19:36 +0100
Message-ID: <20100806111935.GA31326@sirena.org.uk>
References: <20100806001844.GM15884@atomos.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F44B1039A2
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 13:19:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100806001844.GM15884@atomos.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: tiwai@suse.de, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 06, 2010 at 10:18:45AM +1000, Stuart Longland wrote:

> Work has continued on the TLV320AIC3204 CODEC driver, and there have
> been a number of fixes since the last patch was published.  However,
> this CODEC is a rather complicated beast to drive, some may find the
> controls a little unweildy, and as such, I was wondering if the machine
> driver could be used to abstract this for a given target?

The machine driver shouldn't be doing this - it's too fragile in the
face of any changes in the drivers and means hard coding use cases into
the kernel which is really bad practice since it's much slower than
doing things from user space and much harder to change as new needs
arise.

Much of this should be being handled by use case management anyway, even
the controls that actually exist usefully on a given system are normally
way more detail than end applications should ever be seeing.  See

	http://www.slimlogic.co.uk/?p=40

for the API which should deal with that.  

We should still do the limiting in kernel for controls that are on paths
that can not connected be at all (since it makes life easier developing
use cases) but the major thing is the use case management.  Takashi has
a patch for hiding controls which could be built on to do this but
unfortunately it's been sitting in his sound-unstable tree rather than
included in mainline.
