From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Public ridicule due to sound/soc/soc-core.c abuse
 of the driver model
Date: Fri, 6 Jan 2012 12:31:21 -0800
Message-ID: <20120106203117.GG2893@opensource.wolfsonmicro.com>
References: <20120106194052.GA7781@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0F6DE2445A
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 21:31:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120106194052.GA7781@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg KH <greg@kroah.com>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 06, 2012 at 11:40:52AM -0800, Greg KH wrote:

> static void rtd_release(struct device *dev) {}

Oh, great - didn't notice this one.  Liam, this is from the
multi-component stuff and does need sorting.
