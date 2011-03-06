From: Sakari Ailus <sakari.ailus@retiisi.org.uk>
Subject: Re: [GIT PULL FOR 2.6.39] Media controller and OMAP3 ISP driver
Date: Sun, 06 Mar 2011 10:34:50 +0200
Message-ID: <4D73472A.60702@retiisi.org.uk>
References: <201102171606.58540.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201102171606.58540.laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Laurent,

Many thanks for the pull req!

On Thu, Feb 17, 2011 at 04:06:58PM +0100, Laurent Pinchart wrote:
...
>  drivers/media/video/omap3-isp/ispresizer.c         | 1693 ++++++++++++++
>  drivers/media/video/omap3-isp/ispresizer.h         |  147 ++
>  drivers/media/video/omap3-isp/ispstat.c            | 1092 +++++++++
>  drivers/media/video/omap3-isp/ispstat.h            |  169 ++
>  drivers/media/video/omap3-isp/ispvideo.c           | 1264 ++++++++++
>  drivers/media/video/omap3-isp/ispvideo.h           |  202 ++
>  drivers/media/video/omap3-isp/luma_enhance_table.h |   42 +
>  drivers/media/video/omap3-isp/noise_filter_table.h |   30 +
...
>  include/linux/Kbuild                               |    4 +
>  include/linux/media.h                              |  132 ++
>  include/linux/omap3isp.h                           |  646 +++++

What about renaming the directory omap3isp for the sake of consistency? 
The header file is called omap3isp.h and omap3isp is the prefix used in 
the driver for exported symbols.

My apologies for not bringing this up earlier.

Regards,

-- 
Sakari Ailus
sakari dot ailus at retiisi dot org dot uk
