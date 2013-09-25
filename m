From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [TINYCOMPRESS][PATCH 1/1] compress: Must check for
 POLLERR before POLLOUT/POLLIN
Date: Wed, 25 Sep 2013 15:45:28 +0530
Message-ID: <20130925101528.GO17188@intel.com>
References: <20130829083202.GA1538@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D9029262607
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 13:06:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130829083202.GA1538@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.jf.intel.com, elaurent@google.com
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 29, 2013 at 09:32:02AM +0100, Richard Fitzgerald wrote:
> In the case of error the ALSA compressed driver sets revents as
> (POLLOUT | POLLWRNORM | POLLERR) or (POLLIN | POLLWRNORM | POLLERR).
> So we can't assume that POLLOUT or POLLIN indicate success, we must
> check for POLLERR first.

Applied, thanks

Sorry looks like I missed this earlier...


~Vinod
