From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Sun, 1 Sep 2013 14:02:15 +0100
Message-ID: <20130901130215.GS6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831172853.GL18608@sirena.org.uk>
 <20130831191956.GH6617@n2100.arm.linux.org.uk> <5222562B.8010001@metafoo.de>
 <20130831210518.GK6617@n2100.arm.linux.org.uk>
 <20130901121928.GC3084@sirena.org.uk>
 <20130901123433.GR6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 507F0264F41
 for <alsa-devel@alsa-project.org>; Sun,  1 Sep 2013 15:02:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130901123433.GR6617@n2100.arm.linux.org.uk>
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
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 01, 2013 at 01:34:33PM +0100, Russell King - ARM Linux wrote:
> The non-DT support I run has full support for everything on Dove, which
> means I can do much more in-depth testing than just running madplay or
> something similar to check that there's audio out - which is about the
> limit of what can be done with DT-only setups at the moment, such as
> the DPCM bug triggered by vlc.

Sorry, that was a bit unclear: I meant that I can do testing with vlc
on my setup, which I don't believe to be possible yet on DT setups.
