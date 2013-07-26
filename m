From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/4] ASoc: kirkwood: add DT support
Date: Fri, 26 Jul 2013 10:21:56 +0100
Message-ID: <20130726092156.GK24642@n2100.arm.linux.org.uk>
References: <20130725111459.145a4aa4@armhf>
 <20130725191905.GR9858@sirena.org.uk>
 <20130725230533.GH24642@n2100.arm.linux.org.uk>
 <20130726110913.0a193918@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id D8D722656BA
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 11:22:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130726110913.0a193918@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 26, 2013 at 11:09:13AM +0200, Jean-Francois Moine wrote:
> The A510 documentation uses the names "DCO PLL" for the internal clock
> and "AU_EXTCLK" for the external clock. So, what about "dcopll" and
> "extclk"?

Stop naming them according to their source.  Their _consumer_ names
not _source_ names.
