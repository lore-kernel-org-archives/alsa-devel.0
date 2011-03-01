From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH v22 3/3] ASoC: WL1273 FM radio: Access I2C
 IO functions through pointers.
Date: Tue, 01 Mar 2011 15:44:45 +0200
Message-ID: <1298987085.29371.123.camel@masi.mnp.nokia.com>
References: <1298985037-2714-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1298985037-2714-2-git-send-email-matti.j.aaltonen@nokia.com>
	<1298985037-2714-3-git-send-email-matti.j.aaltonen@nokia.com>
	<1298985037-2714-4-git-send-email-matti.j.aaltonen@nokia.com>
	<20110301132315.GD9662@opensource.wolfsonmicro.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E48CC103927
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 14:44:51 +0100 (CET)
In-Reply-To: <20110301132315.GD9662@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, mchehab@redhat.com, hverkuil@xs4all.nl, lrg@slimlogic.co.uk, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-03-01 at 13:23 +0000, ext Mark Brown wrote:
> On Tue, Mar 01, 2011 at 03:10:37PM +0200, Matti J. Aaltonen wrote:
> > These changes are needed to keep up with the changes in the
> > MFD core and V4L2 parts of the wl1273 FM radio driver.
> > 
> > Use function pointers instead of exported functions for I2C IO.
> > Also move all preprocessor constants from the wl1273.h to
> > include/linux/mfd/wl1273-core.h.
> > 
> > Also update the year in the copyright statement.
> > 
> > Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> *Please* keep acks unless you're making substantial changes to
> repostings.

OK, I see, I should have added the ACKs to the relevant driver files
instead of copying them to the cover letter...

Cheers,
Matti

> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
