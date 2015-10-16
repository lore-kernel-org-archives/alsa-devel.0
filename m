From: Jyri Sarha <jsarha@ti.com>
Subject: HDMI codec, way forward?
Date: Fri, 16 Oct 2015 14:50:26 +0300
Message-ID: <5620E482.6050507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 5099B260671
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 13:50:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, tomi.valkeinen@ti.com, lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com, =?UTF-8?Q?Russell_King_-_ARM_Linux_=e2=80=8e?= <linux@arm.linux.org.uk>, lars@metafoo.de, Jean-Francois Moine <moinejf@free.fr>, Arnaud Pouliquen <arnaud.pouliquen@st.com>
List-Id: alsa-devel@alsa-project.org

After reading the ELCE Audio mini conf minutes [1] I gather that HDMI
audio was not discussed after all.

My conclusion from the Lars-Peter's latest mail [2] related to the
subject is that the wind is currently blowing slightly in favour of my
version of the hdmi codec [3], or at least not in favour of Arnaud's
version [4].

So how should we proceed? Are we still waiting for some feedback from
DRM/video side?

There was not too many clear suggestions to my latest patch series
[3], so I do not see too much point in sending yet another version of
that series.

Arnaud, if I'd try to make a patch series that would implement sti
HDMI audio with my HDMI codec, would you be willing try that out?

Best regards,
Jyri

[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/098847.html
[2] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/098564.html
[3] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-September/097667.html
[4] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/098275.html
