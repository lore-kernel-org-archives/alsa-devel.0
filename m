From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH 1/1] media: Entities with sink pads must have at least
 one enabled link
Date: Wed, 14 Nov 2012 23:15:03 +0200
Message-ID: <20121114211502.GV25623@valkosipuli.retiisi.org.uk>
References: <1351280777-4936-1-git-send-email-sakari.ailus@iki.fi>
 <20121113142409.GR25623@valkosipuli.retiisi.org.uk>
 <50A36307.50502@samsung.com>
 <2181130.3OlxHxCofA@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2181130.3OlxHxCofA@avalon>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, hverkuil@xs4all.nl
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 14, 2012 at 11:58:42AM +0100, Laurent Pinchart wrote:
> I think my preference would go for a helper function that drivers can use, 
> possibly first waiting until a second driver requires this kind of checks 
> before implementing it.

I'd like to see a driver that doesn't. Quite likelye either it has no
configurable links or it's broken. :-)

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
