From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH TINYCOMPRESS 7/14] compress: Remove
 hardcoded limit on length of poll() wait
Date: Sun, 10 Feb 2013 22:45:27 -0800
Message-ID: <20130211064527.GB3789@intel.com>
References: <20130210001308.GG31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D37C7260314
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 08:10:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130210001308.GG31139@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 10, 2013 at 12:13:08AM +0000, Richard Fitzgerald wrote:
> For best power-saving we want to sleep on poll() for as long as
> possible, we don't want to wake unnecessarily for arbitrary time
> limits. Adds function compress_set_max_poll_wait() so that
> client can configure the poll() timeout.
Looks okay, but shouldnt this be part of compress_config and if not initialized
we switch to default value.

--
~Vinod
