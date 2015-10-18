From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: HDMI codec, way forward?
Date: Sun, 18 Oct 2015 20:32:13 +0530
Message-ID: <20151018150213.GN27370@localhost>
References: <5620E482.6050507@ti.com>
 <5620EE2F.8070504@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C3782605CC
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 16:59:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5620EE2F.8070504@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Russell King - ARM Linux =?utf-8?B?4oCO?= <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, broonie@kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 16, 2015 at 02:31:43PM +0200, Lars-Peter Clausen wrote:
> On 10/16/2015 01:50 PM, Jyri Sarha wrote:
> > After reading the ELCE Audio mini conf minutes [1] I gather that HDMI
> > audio was not discussed after all.
> 
> It was discussed, but rather shortly and only in the context of the HDA.
> (Adding Vinod to Cc, who presented yet another approach to the problem last
> week)

Thanks for adding me :)

Based on the links sent by Jyri, I did look up the series from Jyri and
Arnaud. I have tried to summarize the approach but please do correct me if I
got something wrong

There are similarities but both are trying to add an interface between audio
and display.

Jyri's approach to add generic IEC code makes sense and drives reuse. I kind
of didn't like adding rates and formats for DAIs, if they are placeholders
then it is okay but otherwise we should read and set them from ELD. Also I
have reservations about hdmi_codec_ops and this being set by drm driver, why
not use component interface for these things and let data be shared!

Arnaud's approach to add N,CTS helpers is great. But having calls to drm
from audio side for drm enabling wouldn't have been required if we have
component interface here.

If we have these calls on a component interface and use these as generic ops
for the audio-drm interface rather than i915 which is implemented today we
don't need to export symbols and create a dependency between these two side.

Also I would again like you folks to review the HDA HDMI ASoC driver RFC I
posted recently [1]. We use component interface and have been adding more
callback to interface. David added notification [2] and we plan to add ELD
query as well soonish.

[1]: http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/098730.html
[2]: http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/097042.html

-- 
~Vinod
