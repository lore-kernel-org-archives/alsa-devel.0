From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 04/14] soundwire: Add MIPI DisCo
	property helpers
Date: Mon, 27 Nov 2017 07:59:40 +0000
Message-ID: <20171127075940.euvjgjf6t5rimltp@localhost.localdomain>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-5-git-send-email-vinod.koul@intel.com>
 <20171123143812.braw737aciq4qmb7@localhost.localdomain>
 <20171124160448.GB11781@buildpc-HP-Z230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C040266B0F
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 08:59:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171124160448.GB11781@buildpc-HP-Z230>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, patches.audio@intel.com, Sudheer Papothi <spapothi@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, Takashi <tiwai@suse.de>, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 24, 2017 at 09:34:49PM +0530, Sanyog Kale wrote:
> On Thu, Nov 23, 2017 at 02:38:12PM +0000, Charles Keepax wrote:
> > On Fri, Nov 10, 2017 at 05:19:06PM +0530, Vinod Koul wrote:
> 
> > > MIPI Discovery And Configuration (DisCo) Specification for SoundWire
> > > specifies properties to be implemented for SoundWire Masters and
> > > Slaves. The DisCo spec doesn't mandate these properties. However,
> > > SDW bus cannot work without knowing these values.
> > > 
> > > The helper functions read the Master and Slave properties.
> > > Implementers of Master or Slave drivers can use any of the below
> > > three mechanisms:
> > >    a) Use these APIs here as .read_prop() callback for Master
> > >       and Slave
> > >    b) Implement own methods and set those as .read_prop(), but invoke
> > >       APIs in this file for generic read and override the values with
> > >       platform specific data
> > >    c) Implement ones own methods which do not use anything provided
> > >       here
> > > 
> > > Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> > > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > > ---
> > Apologies for the long and slightly vague comment, but I guess my
> > question is do you have a thought on how drivers should know when
> > it is safe to communicate with a SoundWire device?
> 
> IMO it is safe to communicate with SoundWire device when the Slave
> status is ATTACHED. In any case bus will report error if it is not able
> to communicate with SoundWire device.
> 

Yeah I guess my point here is that there is currently no way in
this SoundWire framework for the slave driver to know if the
device is attached or not, unless I am missing something?  There
are calls by which the master can inform the framework, but
nothing to pass that on to the slave driver.

I would indeed imagine the comms would fail if the slave isn't
attached but that doesn't seem like a particularly robust way of
determining that.

Thanks,
Charles
