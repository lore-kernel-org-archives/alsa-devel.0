From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC/PATCH v7 02/12] media: Media device
Date: Wed, 22 Dec 2010 19:33:46 -0800
Message-ID: <20101223033346.GB14692@suse.de>
References: <1292844995-7900-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1292844995-7900-3-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1292844995-7900-3-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, clemens@ladisch.de, sakari.ailus@maxwell.research.nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 20, 2010 at 12:36:25PM +0100, Laurent Pinchart wrote:
> The media_device structure abstracts functions common to all kind of
> media devices (v4l2, dvb, alsa, ...). It manages media entities and
> offers a userspace API to discover and configure the media device
> internal topology.

As you create sysfs files, please also create Documentation/ABI/ entries
for those sysfs files at the same time.

thanks,

greg k-h
