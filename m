From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v6 0/3] ASoC: sun4i-i2s: Updates to the driver
Date: Mon, 26 Aug 2019 20:07:31 +0200
Message-ID: <20190826180734.15801-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBB2V7SDVQKGQETTFX4NY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi All,

here is a patch series to add some improvements to the sun4i-i2s driver
which is enough to get HDMI audio working on the A83T, A64, H3 and
H5 platforms.

I've dropped a lot of the functionality that was presented earlier in favour
of getting initial HDMI audio delivered. H6 and multi-channel HDMI will
follow shortly.

My test branch for this can be found at
https://github.com/codekipper/linux-sunxi/commits/upstream-i2s , I've been
using a Pine64 to test with; validating the new SoC block with HDMI audio
and ensuring that I've not broken the old block by making sure that the audio
codec still works.

BR,
CK

---
v6 changes compared to v5 are:
- removed patches for multi-channel and H6 HDMI audio.
- removed patch for 20, 24 and 32 bit (will push support for just 20 and 24bit)
- ditched tdm patches as support has already been added.
- added fix for A83T reg map.

v5 changes compared to v4 are:
- removed delivered patches.
- Added more details to commit messages.
- replaced some reg fields with function calls.
- Added DSP_A and DSP_B support for H3 and later SoCs.
- Added support for the Allwinner H6.

v4 changes compared to v3 are:
- Moved patches around so that the more controversial of patches are
  at the top of the stack.
- Added more details to commit messages.
- Fixed 20bit audio PCM format to use 4 bytes.
- Reduced number of flags used to indicate a new SoC.

v3 changes compared to v2 are:
 - added back slave mode changes
 - added back the use of tdm properties
 - changes to regmap and caching
 - removed loopback functionality
 - fixes to the channel offset mask

v2 changes compared to v1 are:
 - removed slave mode changes which didn't set mclk and bclk div.
 - removed use of tdm and now use a dedicated property.
 - fix commit message to better explain reason for sign extending
 - add divider calculations for newer SoCs.
 - add support for multi-lane i2s data output.
 - add support for 20, 24 and 32 bit samples.
 - add loopback property so blocks can be tested without a codec.

---

Marcus Cooper (3):
  ASoC: sun4i-i2s: incorrect regmap for A83T
  ASoC: sun4i-i2s: Add regmap field to sign extend sample
  ASoC: sun4i-i2s: Adjust LRCLK width

 sound/soc/sunxi/sun4i-i2s.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

-- 
2.23.0
