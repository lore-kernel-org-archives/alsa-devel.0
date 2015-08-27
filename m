From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Out-of-tree HDMI audio driver for BayTrail-T
Date: Thu, 27 Aug 2015 19:01:05 +0530
Message-ID: <20150827133105.GV13546@localhost>
References: <55DEA7D8.5060106@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 864FB2605D3
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 15:28:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55DEA7D8.5060106@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ramesh <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 27, 2015 at 08:02:00AM +0200, David Henningsson wrote:
> I don't usually deal with out-of-tree drivers, but when Canonical
> enabled the Intel Compute Stick [1] (which is using a BayTrail-T
> processor), we were using an out-of-tree driver to enable HDMI
> audio.
> 
> The driver has earlier been made public by Intel [2], and I've put
> my modifications to it here [3].
> 
> Unfortunately, it looks like the effort and hardware knowledge
> required to make this driver upstreamable is beyond what I can
> currently manage.
> 
> Also, I cannot answer for whether or not other parties (such as
> Intel) plan to upstream the driver.
Hi David,

Thanks for bringing this up. My team (Ramesh) wrote the driver so we can
answer the questions around it

The only reason we didn't upstream the driver was the display interface it
relied on. To configure HDMI the driver needs to access display registers
which are exposed by display using a private interface. If that or something
else is available for us to configure HDMI upstream, We can push this
upstream.

-- 
~Vinod
