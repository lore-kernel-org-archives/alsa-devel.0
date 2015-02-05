From: Kevin Strasser <kevin.strasser@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: fix sst firmware path
Date: Thu, 5 Feb 2015 10:48:22 -0800
Message-ID: <20150205184822.GE13647@H87M>
References: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
 <20150205181458.GG21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3115E260524
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 19:48:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150205181458.GG21293@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Yang Fang <yang.a.fang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 05, 2015 at 06:14:58PM +0000, Mark Brown wrote:
> On Wed, Feb 04, 2015 at 11:35:07AM -0800, Kevin Strasser wrote:
> > All sst firmware is provided under the intel directory of the linux-firmware
> > tree. By default this directory structure is kept when installing on a
> > target system. Change the path to expect a default linux-firmware
> > installation.
> 
> Applied, thanks.  It doesn't apply as a fix but that seems to be OK as the
> only request_firmware() I spotted there appears to use intel/ prefixed
> directories already.

I'm a little confused. Do you want me to submit a version that can be applied as
a fix? It seems to me that we want this patch in 3.19.
