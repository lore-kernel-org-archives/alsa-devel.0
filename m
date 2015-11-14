From: Pavel Machek <pavel@ucw.cz>
Subject: Re: multi-codec support for arizona-ldo1 was Re:
 System with multiple arizona (wm5102) codecs
Date: Sat, 14 Nov 2015 08:44:00 +0100
Message-ID: <20151114074400.GA7898@amd>
References: <20150914115439.GA29646@amd> <20150914115255.GE11200@ck-lbox>
 <20151012090045.GA7448@amd> <20151012154715.GF4238@sirena.org.uk>
 <20151012201137.GA7317@amd> <20151013115355.GC14956@sirena.org.uk>
 <20151113215812.GA19020@amd> <20151113225355.GU12392@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 22ADA26048C
 for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2015 08:44:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151113225355.GU12392@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


On Fri 2015-11-13 22:53:55, Mark Brown wrote:
> On Fri, Nov 13, 2015 at 10:58:12PM +0100, Pavel Machek wrote:
> > On Tue 2015-10-13 12:53:55, Mark Brown wrote:
> > > On Mon, Oct 12, 2015 at 10:11:38PM +0200, Pavel Machek wrote:
> 
> > > > > No, you definitely shouldn't be doing this - the regulator names should
> > > > > reflect the names the device has in the datasheet to aid people in going
> > > > > from software to the hardware and back again.  They shouldn't be
> > > > > dynamically generated at runtime.  If you need to namespace by
> > > > device
> 
> > Ok. But I'd still like to get it working.
> 
> So as I've been saying use the existing interfaces, or extend them as
> needed.

Obviously I'll need to use the existing interfaces, or extend them as
needed. I'd expect subsystem maintainer to know if the existing
interfaces are ok or what needs to be fixed, but it seems you either
don't know how your subsystem works, or are not willing to tell me.

Is there someone else I should talk to with respect to regulators-ALSA
interface?

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
