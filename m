From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/14] soundwire: more code cleanups
Date: Thu, 2 May 2019 17:19:33 +0200
Message-ID: <20190502151933.GA32285@kroah.com>
References: <20190502105930.9889-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B35DF8075A
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 17:19:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190502105930.9889-1-vkoul@kernel.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 02, 2019 at 04:29:16PM +0530, Vinod Koul wrote:
> After applying cleanup from Pierre, I realized few more things can be
> cleaned up as well, so fixing these instance in the subsystem.
> 
> Looks like bool is no longer encouraged, but I have skipped those and few
> alignment as they caused code to look worse.
> 
> Greg,
> if you are okay I would like to add this as well (i know it is late, but
> they are cosmetic changes and no logic ones, let me know and I can
> send a updated PR)

This made no sense, as it was on top of Pierre's patches.

I've applied both his, and your, patch series to the tree now, hopefully
this type of mess doesn't happen again in the future.

Please be a lot more specific as to what you expect me to do with a
patch series, and what exactly it is for/against/after, as this was not
obvious at all.

ugh, someone owes me a drink...

greg k-h
