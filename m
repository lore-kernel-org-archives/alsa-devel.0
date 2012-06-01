From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: Confusion about Playback/Capture, CODEC/CODEC links,
	and snd_soc_dapm_link_dai_widgets()
Date: Fri, 01 Jun 2012 16:31:46 -0600
Message-ID: <4FC942D2.8060803@wwwdotorg.org>
References: <4FC7F576.30101@wwwdotorg.org>
	<20120531233702.GA30717@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E1E382447E
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Jun 2012 00:31:51 +0200 (CEST)
In-Reply-To: <20120531233702.GA30717@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 05/31/2012 05:37 PM, Mark Brown wrote:
> On Thu, May 31, 2012 at 04:49:26PM -0600, Stephen Warren wrote:
>> [ having problems getting codec/codec DAI links working] 
...
> It's really hard to comment in much more detail, you've not shown enough
> information.  What are the DAI links connecting the devices?  Is the
> rest of the DAPM path through the system connected?  My best guess is
> that (possibly due to the linking of the playback widgets) you don't
> have a full DAPM path.

Here's hopefully everything:

I'm playing back audio on CPU DAI named APBIF0. This is connected to
AHUB XBAR DAI also named APBIF0. This link appears to be working, since
the XBAR's stream node is active:

# cat tegra30-ahub-xbar/dapm/APBIF0\ Receive
APBIF0 Receive: On  in 1 out 1
 stream APBIF0 Receive active
 out "static" "APBIF0 RX"

Tracing the path through the XBAR, the paths seem set up OK, but nothing
else is active:

# cat tegra30-ahub-xbar/dapm/APBIF0\ RX
APBIF0 RX: Off  in 1 out 0
 in  "static" "APBIF0 Receive"
 out "APBIF0 RX" "I2S1 Mux"

# cat tegra30-ahub-xbar/dapm/I2S1\ Mux
I2S1 Mux: Off  in 1 out 0
 in  "APBIF0 RX" "APBIF0 RX"
 out "static" "I2S1 TX"

# cat tegra30-ahub-xbar/dapm/I2S1\ TX
I2S1 TX: Off  in 1 out 0
 in  "static" "I2S1 Mux"
 out "static" "I2S1 Transmit"

# cat tegra30-ahub-xbar/dapm/I2S1\ Transmit
I2S1 Transmit: Off  in 1 out 0
 stream I2S1 Transmit inactive
 in  "static" "I2S1 TX"

There is also a DAI link from XBAR's I2S1 TX/Transmit to the I2S
controller's CIF Receive/RX, which appears to have been linked correctly
since both DAI names show up in the I2S controller's CIF Receive stream
debugfs file (see "in" line):

# cat tegra30-i2s.1/dapm/CIF\ Receive
CIF Receive: Off  in 0 out 0
 stream CIF Receive inactive
 in  "static" "I2S1 Transmit-CIF Receive"
 out "static" "CIF RX"

(I assume that the "in" line of the AHUB's "APBIF0 Receive" debugfs file
way above is only "APBIF0" instead of "APBIF0-APBIF0" since it's a
cpu/codec link not a codec/codec link?)

And again, the path through the I2S controller looks complete:

# cat tegra30-i2s.1/dapm/CIF\ RX
CIF RX: Off  in 0 out 0
 in  "static" "CIF Receive"
 out "static" "DAP TX"

# cat tegra30-i2s.1/dapm/DAP\ TX
DAP TX: Off  in 0 out 0
 in  "static" "CIF RX"
 out "static" "DAP Transmit"

# cat tegra30-i2s.1/dapm/DAP\ Transmit
DAP Transmit: Off  in 0 out 0
 stream DAP Transmit inactive
 in  "static" "DAP TX"

Finally, there's a DAI link from the I2S controller's DAP DAI to the
WM8903's DAI, which again shows up in the debugfs file:

# cat wm8903.4-001a/dapm/Playback
Playback: Off  in 0 out 8
 stream Playback inactive
 in  "static" "DAP Transmit-Playback"
 out "static" "AIFRXL"
 out "static" "AIFRXR"
 out "static" "AIFRXL"
 out "static" "AIFRXR"

For completeness, here's the route through the WM8903, although nothing
in that codec has changed since before I started reworking the Tegra
drivers:

# cd wm8903.4-001a/dapm/

# cat AIFRXL
AIFRXL: Off  in 0 out 2
 stream Left Playback inactive
 in  "static" "Playback"
 in  "static" "Playback"
 out "Left" "Left Playback Mux"

# cat Left\ Playback\ Mux
Left Playback Mux: Off  in 0 out 2
 in  "Left" "AIFRXL"
 out "static" "DACL"

# cat DACL
DACL: Off  in 0 out 2 - R18(0x12) bit 3
 in  "static" "CLK_DSP"
 in  "static" "DACL Sidetone"
 in  "static" "Left Playback Mux"
 out "DACL Switch" "Left Speaker Mixer"
 out "DACL Switch" "Left Output Mixer"

# cat Left\ Speaker\ Mixer
Left Speaker Mixer: Off  in 0 out 2 - R16(0x10) bit 1
 in  "DACL Switch" "DACL"
 out "static" "Left Speaker PGA"

# cat Left\ Speaker\ PGA
Left Speaker PGA: Off  in 0 out 2 - R17(0x11) bit 1
 in  "static" "Left Speaker Mixer"
 out "static" "LON"
 out "static" "LOP"

# cat LON
LON: Off  in 0 out 1
 in  "static" "Left Speaker PGA"
 out "static" "Int Spk"

# amixer cget name='Int Spk Switch'
numid=87,iface=MIXER,name='Int Spk Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on

(I do note that on IRC you said soc-pcm might be a better fit for this
HW now, but since I figure I'm very close, I'd like to get this working
and experiment with it a bit either way)

Thanks so much for the help.
