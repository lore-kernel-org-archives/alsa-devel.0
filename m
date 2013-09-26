From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoc: kirkwood: Extend the min and max
	number of bytes	per period
Date: Thu, 26 Sep 2013 11:28:40 +0100
Message-ID: <20130926102840.GP12758@n2100.arm.linux.org.uk>
References: <20130919112043.5ad16147@armhf>
 <20130926102408.GE19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id D27CC261A6C
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 12:29:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130926102408.GE19304@sirena.org.uk>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 26, 2013 at 11:24:08AM +0100, Mark Brown wrote:
> On Thu, Sep 19, 2013 at 11:20:43AM +0200, Jean-Francois Moine wrote:
> > This patch extends the min and max number of bytes per period.
> > It mainly permits to reduce the sound delay in MIDI real-time playing.
> 
> Applied, thanks.  For the minimum limit is there any hardware imposed
> limit that could be used rather than tweaking the numbers?

I looked at that, and apart from interrupt rate, I don't see any.

The values I have for these in my tree are:

#define KIRKWOOD_SND_MIN_PERIODS                2
#define KIRKWOOD_SND_MAX_PERIODS                16
#define KIRKWOOD_SND_MIN_PERIOD_BYTES           256
#define KIRKWOOD_SND_MAX_PERIOD_BYTES           0x100000
#define KIRKWOOD_SND_MAX_BUFFER_BYTES           0x100000

which are partly based on patches applied to Rabeeh's kernel, and then
further adjusted.  Yes, the max period bytes won't be reachable since
the minimum period will cause it to be half the max buffer bytes.
