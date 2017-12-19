From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 00/14] soundwire: Add a new SoundWire
	subsystem
Date: Tue, 19 Dec 2017 11:33:34 +0100
Message-ID: <20171219103334.GA13590@kroah.com>
References: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
 <20171214073508.GA29585@kroah.com>
 <20171214105320.GX18649@localhost>
 <20171214124949.GA12935@kroah.com>
 <20171214150914.GD9788@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id BB7B8266D71
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 11:33:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171214150914.GD9788@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Pierre <pierre-louis.bossart@linux.intel.com>, ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, Takashi <tiwai@suse.de>, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 14, 2017 at 03:09:14PM +0000, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 01:49:49PM +0100, Greg Kroah-Hartman wrote:
> 
> > Ok, but that feels a bit rushed, as I'm guessing those sysfs files are
> > essencial for the use of the hardware.  To not include them feels odd to
> > me :)
> 
> As a reviewer if we can get the rest of the series moving so that
> there's less to review each time it's posted that'd be very helpful.


Ok, I've applied everything but the regmap patch in this series to my
tree now.

thanks,

greg k-h
