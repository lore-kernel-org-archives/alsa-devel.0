From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC V2 0/5] another generic audio hdmi
 codec proposal
Date: Wed, 7 Oct 2015 10:36:41 +0300
Message-ID: <5614CB89.70007@ti.com>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
 <56127ADB.6080700@ti.com> <561392F7.90608@st.com> <5613EC62.8000007@ti.com>
 <20151006164602.GV12635@sirena.org.uk>
 <20151006185157.GT21513@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 499DF260A59
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 09:36:49 +0200 (CEST)
In-Reply-To: <20151006185157.GT21513@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>
Cc: "moinejf@free.fr" <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, David Airlie <airlied@linux.ie>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.de>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 10/06/15 21:51, Russell King - ARM Linux wrote:
> We at least need some kind of notification system from the video part
> to the other parts, so that we can sanely transmit connect/disconnect/
> edid updates to different parts of the system*not*  that I'm suggesting
> that in the case of the Dove Cubox, seeing a disconnect on HDMI should
> kill the audio - it most_certainly_  _never_  should there, it would be
> utterly insane, and I'm going to play hard-ball on that case.

I am not proposing any automatic mechanism for killing the audio in the 
my hdmi codec patch set. I am merely providing the means for the video 
driver to gracefully abort the audio stream if the driver decides it can 
not support it any more.

For external HDMI encoders that is hardly ever needed, since the CPU DAI 
is usually the bit- and frame-clock master in those cases. The CPU DAI 
can go on banging the bits even if the encoder isn't listening. So we 
can drop the abort_cb() that if it still annoys you after this explanation.

Best regards,
Jyri
