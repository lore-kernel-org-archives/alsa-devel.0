From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/10] Kirkwood ASoC drivers fixes and
	improvements
Date: Wed, 21 Nov 2012 09:41:42 +0000
Message-ID: <20121121094141.GW3290@n2100.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
 <20121121014043.GG4673@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 676E9265CAD
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 10:41:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121121014043.GG4673@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Rabeeh Khoury <rabeeh@solid-run.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 21, 2012 at 10:40:45AM +0900, Mark Brown wrote:
> On Tue, Nov 20, 2012 at 12:17:26PM +0000, Russell King - ARM Linux wrote:
> > The first five patches of this patch series fixes a number of problems
> > with the Kirkwood audio driver, as seen on Dove platforms.  The biggest
> > issue is that they can cause the kernel to lock up solidly, requiring
> > a reset to recover.
> 
> Applied all, thanks.

I've been discussing this with Sebastian Hesselbarth and he's agreed
to have his sign-off on a bunch of these patches... I guess not now.
