From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: KNOT / CONTINUOUS (was: [PATCH] ASoC: kirkwood:
	Fix invalid	SPDIF format)
Date: Tue, 26 Nov 2013 19:32:47 +0000
Message-ID: <20131126193246.GH16735@n2100.arm.linux.org.uk>
References: <20131126104140.16e3eb87@armhf> <s5h8uwba2gv.wl%tiwai@suse.de>
 <20131126200916.47a45929@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id E9836261675
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 20:33:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131126200916.47a45929@armhf>
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
Cc: alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Jassi Brar <jassi.brar@samsung.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 26, 2013 at 08:09:16PM +0100, Jean-Francois Moine wrote:
> Otherwise, removing SNDRV_PCM_RATE_CONTINUOUS in the codec, I can hear
> the 7850Hz stream which is converted to 22.05 kHz by vlc, but when I
> want a stream at 33.075kHz, vlc converts it to 32kHz.

What is your fascination with doing stuff outside the specifications?
The HDMI spec is quite clear:

"An HDMI Source is permitted to transmit L-PCM audio data at sample rates
of 32kHz, 44.1kHz, 48kHz, 88.2kHz, 96kHz, 176.4kHz or 192kHz."

It goes on to say:

"An HDMI Sink may accept L-PCM audio at sample rates of 32kHz, 44.1kHz,
48kHz, 88.2kHz, 96kHz, 176.4kHz or 192kHz, and should indicate these
capabilities in the E-EDID data structure."

That doesn't say that 8kHz, 22.05kHz etc are valid sample rates for
HDMI.  It may work for some devices but it's non-standard.
