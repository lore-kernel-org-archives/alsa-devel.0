From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: WL1273 FM radio: Access I2C IO
 functions through pointers.
Date: Thu, 13 Jan 2011 13:35:01 +0000
Message-ID: <1294925701.3453.5.camel@odin>
References: <1294924965-6358-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C5B93103880
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:35:05 +0100 (CET)
Received: by wyi11 with SMTP id 11so1691942wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 05:35:05 -0800 (PST)
In-Reply-To: <1294924965-6358-1-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-13 at 15:22 +0200, Matti J. Aaltonen wrote:
> These changes are needed to keep up with the changes in the
> MFD core and V4L2 parts of the wl1273 FM radio driver.
> 
> Use function pointers instead of exported functions for I2C IO.
> Also move all preprocessor constants from the wl1273.h to
> include/linux/mfd/wl1273-core.h.
> 
> Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Although it looks like we have a build dependency on the MFD change
here ? If so, it may be easier submitting this together with your MFD
changes.
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
