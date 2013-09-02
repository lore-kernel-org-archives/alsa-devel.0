From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 08/14] ASoC: kirkwood: prefer external
	clock over	internal clock
Date: Mon, 2 Sep 2013 15:17:32 +0100
Message-ID: <20130902141732.GW6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkVg-0003Ip-G7@rmk-PC.arm.linux.org.uk> <20130901184153.353c644f@armhf>
 <20130902110105.GN3084@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 167F226517F
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 16:18:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130902110105.GN3084@sirena.org.uk>
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
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 02, 2013 at 12:01:05PM +0100, Mark Brown wrote:
> On Sun, Sep 01, 2013 at 06:41:53PM +0200, Jean-Francois Moine wrote:
> > Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > > +	} else if (rate == 44100 || rate == 48000 || rate == 96000) {
> 
> > The rate is always good, and having this test raises a compilation warning
> > (clks_ctrl may be not initialized).
> 
> That should be fixed - it might be worth keeping the test and adding an
> else with an error return for robustness.

I believe you already have a fix merged.  I don't have that fix in my tree.
