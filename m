From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v8 05/12] media: Entity use count
Date: Tue, 8 Feb 2011 13:57:33 +0100
Message-ID: <201102081357.34145.laurent.pinchart@ideasonboard.com>
References: <1296131437-29954-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<4D4BF23A.1050800@maxwell.research.nokia.com>
	<201102041419.19916.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
	[95.142.166.194])
	by alsa0.perex.cz (Postfix) with ESMTP id DDA96103813
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 13:57:35 +0100 (CET)
In-Reply-To: <201102041419.19916.hverkuil@xs4all.nl>
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
Cc: alsa-devel@alsa-project.org, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, broonie@opensource.wolfsonmicro.com, clemens@ladisch.de, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Hans,

On Friday 04 February 2011 14:19:19 Hans Verkuil wrote:
> On Friday, February 04, 2011 13:34:02 Sakari Ailus wrote:
> > Hi,
> > 
> > And many thanks for the comments!
> > 
> > Hans Verkuil wrote:
> > ...
> > 
> > >> diff --git a/include/media/media-entity.h
> > >> b/include/media/media-entity.h index b82f824..114541a 100644
> > >> --- a/include/media/media-entity.h
> > >> +++ b/include/media/media-entity.h
> > >> @@ -81,6 +81,8 @@ struct media_entity {
> > >> 
> > >>  	struct media_pad *pads;		/* Pads array (num_pads elements) */
> > >>  	struct media_link *links;	/* Links array (max_links elements)*/
> > >> 
> > >> +	int use_count;			/* Use count for the entity. */
> > > 
> > > Isn't unsigned better?
> > 
> > Could be. The result, though, will be slightly more difficult checking
> > for bad use count --- which always is a driver bug.
> > 
> > me->use_count += change;
> > WARN_ON(me->use_count < 0);
> > 
> > we must do something like this:
> > 
> > if (change < 0)
> > 
> > 	WARN_ON(me->use_count < (unsigned)-change);
> > 
> > me->use_count += change;
> > 
> > I'd perhaps also go with unsigned int; the choice for signed was made
> > mainly since the above check and with signed int the check was more
> > trivial.
> 
> I saw this WARN_ON as well. I think there is a good reason for that
> WARN_ON, but I think a comment in the header explaining why it is an int
> will be useful. If I trip over it, then others will as well :-)

I'll add a comment. Thanks.

-- 
Regards,

Laurent Pinchart
