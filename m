From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HG vs GIT
Date: Thu, 07 Feb 2008 17:09:05 -0800
Message-ID: <1202432945.20223.97.camel@razman.gruemaster.com>
References: <Pine.LNX.4.58.0802070440430.9968@shell4.speakeasy.net>
	<s5hbq6szylg.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070538120.9968@shell4.speakeasy.net>
	<s5h8x1wzxl0.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0802071450530.8113@tm8103.perex-int.cz>
	<s5h63x0zwtv.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070731570.9968@shell4.speakeasy.net>
	<s5hwspgycso.wl%tiwai@suse.de> <20080207194624.GB30831@sirena.org.uk>
	<s5hve5033nk.wl%tiwai@suse.de> <20080208004222.GA14698@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 747FA2468D
	for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2008 02:09:08 +0100 (CET)
In-Reply-To: <20080208004222.GA14698@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org


On Fri, 2008-02-08 at 00:42 +0000, Mark Brown wrote:

> On Thu, Feb 07, 2008 at 09:36:15PM +0100, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > > 	make M=${PWD} -C /lib/modules/$(uname -r)/build
> 
> > The external build itself is relatively easy.  We have already such
> > stuff in alsa-driver tree.  Just needs a slight change to remap the
> > directories properly in linux kernel tree instead of alsa-kernel
> > tree.
> 
> > What I mentioned is to merge changesets properly from one tree to
> > another old tree.  Maybe a kind of cherry picking would do that.
> 
> The thing I was thinking of above was taking a vanilla kernel tree and
> building a subdirectory of that as though it were out of tree.  This
> lets you use a vanilla git tree with the headers and config of a second
> kernel tree (eg, a distro supplied one), meaning that from a revision
> control point of view there's nothing fancy going on.


One problem with this approach is insuring that you get the current alsa
headers.  If these were kept in the alsa-driver tree, it might be more
manageable.   The alsa-driver tree is specifically for doing out-of-tree
builds, and includes workarounds for older kernels that would be missed
otherwise.

One reason for building against older distro kernels is that
corporations may continuously roll out new hardware on older distro's.
They need to be able to back port some drivers for hardware
compatibility without breaking their image.  Where I work, the corporate
IT image is Suse 9.3 based (ancient in Linux terms).  I believe it came
with alsa 1.0.6 or 1.0.7.  Won't work on the newer HD Audio hardware,
guaranteed.

My current work involves multiple spins of Ubuntu, RedFlag, and to a
small degree Fedora.  This is where the out-of-tree environment really
works well.


-- 
Tobin Davis 

My opinions always matter :-)

	- Dan Malek on the linuxppc-embedded list
