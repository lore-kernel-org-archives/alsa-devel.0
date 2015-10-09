From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 0/4] ASoC: Add HDA HDMI codec driver
Date: Fri, 9 Oct 2015 13:52:07 +0100
Message-ID: <20151009125206.GR32532@n2100.arm.linux.org.uk>
References: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 6A597260699
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 14:52:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 09, 2015 at 01:28:45PM +0100, Vinod Koul wrote:
> Yes, this patch series attempts to add yet another HDMI driver to
> ASoC. This codec appears as HDA codec over HDA link. Although
> the codec reside in display we have a HDA link from audio block
> to this codec. The communication to codec is over HDA link
> 
> Thanks to i915 component infrastructure, we do not need to worry
> about keeping the codec on, this is done by i915 for us.
> 
> Based on discussion with Mark here at ELCE and other attempts by
> various folks on HDMI, I wanted to show on list the stuff we have
> done and discuss and try to see how we converge various attempts
> 
> The driver here only supports stereo and doesn't do multichannel
> just yet, will add later once we converge here. The support for
> using i915 component notification by David will be added later
> on.

I notice that you don't limit the capabilities of the ASoC device to
the capabilities of the HDMI sink - is that an intentional design
decision, or is it handled some other way?

I think that's the "interesting" part of HDMI - how should audio find
out the capabilities on the HDMI sink, and that's the area which people
have been struggling to design and come to some sort of concensus over.

I know HDA passes the ELD through hardware between the HDMI video and
HDMI audio side, which hides some of this with the existing ALSA PCI
HDA driver.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
