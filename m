From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v8 03/12] media: Entities, pads and links
Date: Tue, 8 Feb 2011 14:35:14 +0100
Message-ID: <201102081435.15911.laurent.pinchart@ideasonboard.com>
References: <1296131437-29954-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1296131437-29954-4-git-send-email-laurent.pinchart@ideasonboard.com>
	<201102041120.37541.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
	[95.142.166.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 0ABB8103813
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 14:35:19 +0100 (CET)
In-Reply-To: <201102041120.37541.hverkuil@xs4all.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: alsa-devel@alsa-project.org, sakari.ailus@maxwell.research.nokia.com, broonie@opensource.wolfsonmicro.com, clemens@ladisch.de, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Hans,

On Friday 04 February 2011 11:20:37 Hans Verkuil wrote:
> On Thursday, January 27, 2011 13:30:28 Laurent Pinchart wrote:

<snip>

> > +#define MEDIA_ENT_TYPE_SHIFT		16
> > +#define MEDIA_ENT_TYPE_MASK		0x00ff0000
> > +#define MEDIA_ENT_SUBTYPE_MASK		0x0000ffff
> > +
> > +#define MEDIA_ENT_T_DEVNODE		(1 << MEDIA_ENTITY_TYPE_SHIFT)
> > +#define MEDIA_ENT_T_DEVNODE_V4L		(MEDIA_ENTITY_T_DEVNODE + 1)
> > +#define MEDIA_ENT_T_DEVNODE_FB		(MEDIA_ENTITY_T_DEVNODE + 2)
> > +#define MEDIA_ENT_T_DEVNODE_ALSA	(MEDIA_ENTITY_T_DEVNODE + 3)
> > +#define MEDIA_ENT_T_DEVNODE_DVB		(MEDIA_ENTITY_T_DEVNODE + 4)
> > +
> > +#define MEDIA_ENT_T_V4L2_SUBDEV		(2 << MEDIA_ENTITY_TYPE_SHIFT)
> > +#define MEDIA_ENT_T_V4L2_SUBDEV_SENSOR	(MEDIA_ENTITY_T_V4L2_SUBDEV + 1)
> > +#define MEDIA_ENT_T_V4L2_SUBDEV_FLASH	(MEDIA_ENTITY_T_V4L2_SUBDEV + 2)
> > +#define MEDIA_ENT_T_V4L2_SUBDEV_LENS	(MEDIA_ENTITY_T_V4L2_SUBDEV + 3)
> 
> MEDIA_ENTITY_? That should be MEDIA_ENT_. It looks like this was never
> compiled...

Oops. I probably forgot to compile this intermediate patch (the end result is 
correct though). I'll fix it.

-- 
Regards,

Laurent Pinchart
