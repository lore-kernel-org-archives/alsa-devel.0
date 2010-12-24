From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC/PATCH v7 02/12] media: Media device
Date: Fri, 24 Dec 2010 13:01:05 +0100
Message-ID: <201012241301.05834.laurent.pinchart@ideasonboard.com>
References: <1292844995-7900-1-git-send-email-laurent.pinchart@ideasonboard.com> <1292844995-7900-3-git-send-email-laurent.pinchart@ideasonboard.com> <20101223033346.GB14692@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101223033346.GB14692@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, clemens@ladisch.de, sakari.ailus@maxwell.research.nokia.com
List-Id: alsa-devel@alsa-project.org

Hi Greg,

Thanks for the review.

On Thursday 23 December 2010 04:33:46 Greg KH wrote:
> On Mon, Dec 20, 2010 at 12:36:25PM +0100, Laurent Pinchart wrote:
> > The media_device structure abstracts functions common to all kind of
> > media devices (v4l2, dvb, alsa, ...). It manages media entities and
> > offers a userspace API to discover and configure the media device
> > internal topology.
> 
> As you create sysfs files, please also create Documentation/ABI/ entries
> for those sysfs files at the same time.

Sorry for having forgotten that. I will fix it.

-- 
Regards,

Laurent Pinchart
