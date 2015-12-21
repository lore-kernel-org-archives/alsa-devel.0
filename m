From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: [PATCH v8 0/2] ASoc: sun4i-codec: Add FM, Line and Mic inputs
Date: Mon, 21 Dec 2015 12:31:48 +0100
Message-ID: <20151221123148.1ab6480b@dayas>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBKGG36ZQKGQEIAMQ2YA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is the eighth version of the patch set that adds inputs to sun4i-codec.

Changes compared to v7 are:
 - fix the routes for line and mic capturing.

The patches are on top of the branch "sunxi-next" in 
<git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git>.

Regards,
   Danny
---
Danny Milosavljevic (2):
  sun4i-codec: Add FM, Line and Mic inputs
  sun4i-codec: make it possible to use different codec_widgets for A10 and A20.

 b/sound/soc/sunxi/sun4i-codec.c |  230 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 215 insertions(+), 15 deletions(-)
