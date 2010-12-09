From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v3 0/3] Add Jack support for
Date: Thu, 09 Dec 2010 09:46:28 +0000
Message-ID: <1291887988.3271.15.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCEA4CFC925@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E6CA5103850
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 10:46:32 +0100 (CET)
Received: by wyi11 with SMTP id 11so2057997wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Dec 2010 01:46:32 -0800 (PST)
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4CFC925@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-08 at 10:55 -0600, Olaya, Margarita wrote:
> This patch series adds the support for headset jack detection
> 
> v3:
> Reorder patches to avoid building issues.
> Really add the jack detection in the codec
> 
> Jorge Eduardo Candelaria (3):
>   ASoC: sdp4430: Enable FM stereo pins
>   ASoC: twl6040: Add jack support for headset and handset
>   ASoC: sdp4430: Add Jack support
> 
>  sound/soc/codecs/twl6040.c |   42 ++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/twl6040.h |   12 ++++++++++++
>  sound/soc/omap/sdp4430.c   |   39 +++++++++++++++++++++++++++++++++++----
>  3 files changed, 89 insertions(+), 4 deletions(-)

Applied 1 & 3

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
