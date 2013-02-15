From: "Omair M. Abdullah" <omair.m.abdullah@intel.com>
Subject: Re: [PATCH] ASoC: Jack: add configurable option for
 irq_flag
Date: Fri, 15 Feb 2013 12:40:00 +0530
Message-ID: <20130215071000.GA23031@oma-dev>
References: <1360647422-12404-1-git-send-email-omair.m.abdullah@linux.intel.com>
 <20130212114752.GA1678@opensource.wolfsonmicro.com>
 <63969.10.223.96.90.1360733997.squirrel@linux.intel.com>
 <20130213131917.GF5062@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 94DE4260799
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 08:08:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130213131917.GF5062@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ramesh Babu <ramesh.babu@linux.intel.com>, alsa-devel@alsa-project.org, vinod.koul@linux.intel.com, vaibhav.agarwal@intel.com, lgirdwood@gmail.com, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 13, 2013 at 01:19:17PM +0000, Mark Brown wrote:
> On Wed, Feb 13, 2013 at 11:09:57AM +0530, Ramesh Babu wrote:
> 
> > > If the device only interrupts on one edge how does it detect jack removal?
> 
This patch is mainly to handle GPIOs where there is some toggling of the GPIO
lines due to the switch bouncing, and the debounce time cannot be increased
further due to other constraints. In such cases, providing the specific
edge on which to trigger the interrupt helps increase the robustness.

     ___   _                _   _________
e.g.    |_| |______________| |_|
insert followed by removal, where we want to trigger on the falling edge in both
cases.
