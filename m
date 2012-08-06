From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: adding an external dsp under soc-dsp framework
Date: Mon, 6 Aug 2012 15:39:57 +0100
Message-ID: <20120806143956.GA29272@sirena.org.uk>
References: <loom.20120806T144411-583@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 07340265B76
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 16:10:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20120806T144411-583@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ziv haziz <ziv.haziz@dspg.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2012 at 12:53:40PM +0000, ziv haziz wrote:

Always CC maintainers on patches.

> i plan on adding an external dsp which has slimbus interface under soc-dsp 
> framwork.

You shouldn't be doing this.  The soc-pcm code is *purely* about
managing the interdependencies between the data DMAed from memory and
the external interfaces on a SoC, if you're an off-SoC device then you
should be providing a CODEC driver.  This is why you're having trouble
working out how to fit your driver into the frameworks - they're not
designed to do what you're trying to do.

> last small question: as slimbus ports id should be passed how do you suggest a 
> device should share his slimbus port id?

Well, the bigger blocker here is that we don't have any Slimbus support
in the kernel at the minute.  I'm hoping to help push that along at the
KS/LPC/LinuxCon conferences at the end of this month.
