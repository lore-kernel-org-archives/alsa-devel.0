From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 1/6] video: hdmi: add helper function for N
	and CTS
Date: Wed, 20 Jan 2016 13:39:15 +0000
Message-ID: <20160120133914.GT19062@n2100.arm.linux.org.uk>
References: <1453210836-16218-1-git-send-email-arnaud.pouliquen@st.com>
 <1453210836-16218-2-git-send-email-arnaud.pouliquen@st.com>
 <20160119165430.GN19062@n2100.arm.linux.org.uk>
 <569F8AF0.9000300@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id B7BE82605F1
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 14:39:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <569F8AF0.9000300@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 20, 2016 at 02:26:08PM +0100, Arnaud Pouliquen wrote:
> 
> 
> On 01/19/2016 05:54 PM, Russell King - ARM Linux wrote:
> > However, some of the values given in the HDMI specs for CTS are actually
> > two values, because a single value does not specify the audio clock even
> > with the N values given.  For these, the values returned will not give
> > an accurate clock - this should also be noted.
>
> In HDMI specs i only see a double value for 32 kHz with TMDS clock at
> 74.324  MHz. I can add a  alt_CTS params in hdmi_audio_n_cts that will
> be not null if alternate a value is needed. Is this something reasonable
> for you?

They aren't "alternatives".  They give two values because, in order to
generate that audio sample rate, you need to switch between the two
values to achieve an average audio sample rate that matches the requested
rate.  I suspect that unless you have special hardware which does that
for you automatically, these values are less than ideal.

For example, for 32kHz:

74.25 / 1.001              11648               210937-210938*

which is:

 74250000 / (1.001 * 210937 * 128) * 11648 = 32000.076
 74250000 / (1.001 * 210938 * 128) * 11648 = 31999.924

So, alternating between each for 50% of the time gives 32kHz.

For my other points:

  Section 7.2.3:
  It is recommended that Sources with non-coherent clocks use the
  values listed for a TMDS clock of "Other".

As you have non-coherent clocks, and your CTS value is measured by
the hardware, using the "Other" N values seems to be recommended by
the standard.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
