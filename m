From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/1] ASoC: TWL4030: Add VDL path support
Date: Wed, 22 Apr 2009 16:24:53 +0100
Message-ID: <20090422152453.GB4274@rakim.wolfsonmicro.main>
References: <49EE996E.40504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21B92243E2
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Apr 2009 17:24:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49EE996E.40504@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com, kyungmin.park@samsung.com, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2009 at 01:13:34PM +0900, Joonyoung Shim wrote:
> Add DAPMs for VDL(Voice Down Link) path. To support VDL path, we have
> to change DAPMs of outputs(Earpiece, PreDrive Left/Right, Headset
> Left/Right, Carkit Left/Right) from mux to mixer.

> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>

No problem from an ASoC point of view but I'd like to see some input
from Peter on how this fits with the hardware - if I remember correctly
the previous issues were all around the device specifics.
