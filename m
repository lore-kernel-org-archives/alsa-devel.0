From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH] ASoC: WL1273 FM radio: Access I2C IO
 functions through pointers.
Date: Thu, 13 Jan 2011 16:17:53 +0200
Message-ID: <1294928273.6390.5.camel@masi.mnp.nokia.com>
References: <1294924965-6358-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1294925701.3453.5.camel@odin>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id A0EF6103965
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 15:17:55 +0100 (CET)
In-Reply-To: <1294925701.3453.5.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi.

On Thu, 2011-01-13 at 13:35 +0000, ext Liam Girdwood wrote:
> On Thu, 2011-01-13 at 15:22 +0200, Matti J. Aaltonen wrote:
> > These changes are needed to keep up with the changes in the
> > MFD core and V4L2 parts of the wl1273 FM radio driver.
> > 
> > Use function pointers instead of exported functions for I2C IO.
> > Also move all preprocessor constants from the wl1273.h to
> > include/linux/mfd/wl1273-core.h.
> > 
> > Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>
> 
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
> 
> Although it looks like we have a build dependency on the MFD change
> here ? If so, it may be easier submitting this together with your MFD
> changes.

I've already submitted the MFD & V4L2 changes,  they have been accepted
and should be in the 2.6.38 kernel. One possibility is to wait until v.
38 is out... if necessary.

Thanks,
Matti
