From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v9 01/12] media: Media device node support
Date: Sat, 19 Feb 2011 13:09:13 +0100
Message-ID: <201102191309.13896.laurent.pinchart@ideasonboard.com>
References: <1297686067-9666-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1297686067-9666-2-git-send-email-laurent.pinchart@ideasonboard.com>
	<20110218223337.GC25168@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
	[95.142.166.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 05D2A1037EC
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 13:09:15 +0100 (CET)
In-Reply-To: <20110218223337.GC25168@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sakari.ailus@maxwell.research.nokia.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Friday 18 February 2011 23:33:37 Mark Brown wrote:
> On Mon, Feb 14, 2011 at 01:20:56PM +0100, Laurent Pinchart wrote:
> > +	  Enable the media controller API used to query media devices internal
> > +	  topology and configure it dynamically.
> > +
> > +	  This API is mostly used by camera interfaces in embedded platforms.
> 
> I'd expect this comment is going to bitrot very soon once the framework
> goes in.

Thanks for the comment. I can remove this now, but wouldn't it be better to 
update the description when removing the experimental flag ? We will 
(hopefully) have more users then.

-- 
Regards,

Laurent Pinchart
