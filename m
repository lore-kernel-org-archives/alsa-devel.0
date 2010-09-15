From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] ALSA nvhdmi: Add missing codec IDs
Date: Wed, 15 Sep 2010 13:37:08 -0700
Message-ID: <20100915203708.GB30130@kroah.com>
References: <1284137953-28711-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E50F24151
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Sep 2010 22:46:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284137953-28711-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 10:59:13AM -0600, Stephen Warren wrote:
> Adds codec IDs for various other NVIDIA GPUs to the NVIDIA HDMI audio
> driver.
> 
> This is a backport of 9cf2657d05f9f9e04c3e113d68bf7cef5a942070
> suitable for inclusion into 2.6.34 and 2.6.35.
> 
> ... but subset so that it solely adds new IDs, and doesn't reformat
> nor rename any existing IDs.

Thanks, but I'd prefer to take the original patch, just to stay in sync
with Linus's tree to make things easier for everyone.

So I've taken that patch now.

thanks,

greg k-h
