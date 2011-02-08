From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v8 03/12] media: Entities, pads and links
Date: Tue, 8 Feb 2011 14:46:43 +0100
Message-ID: <201102081446.43643.laurent.pinchart@ideasonboard.com>
References: <1296131437-29954-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1296131437-29954-4-git-send-email-laurent.pinchart@ideasonboard.com>
	<4D42A033.9030906@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
	[95.142.166.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 35FDD244AA
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 14:46:45 +0100 (CET)
In-Reply-To: <4D42A033.9030906@maxwell.research.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, clemens@ladisch.de, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Sakari,

On Friday 28 January 2011 11:53:39 Sakari Ailus wrote:
> Hi Laurent,
> 
> Thanks for the patches!
> 
> I've got one comment that I should have made long time ago... Pads are
> inputs or outputs... or: are they sinks or sources? I recall that it was
> agreed on some occasion that sink and source are much less ambiguous and
> they should be used instead.
> 
> So we'd have MEDIA_PAD_FL_{SINK,SOURCE}, for example. Currently the
> source and documentation is using input/output and source/sink
> interchangeably. I think sink and source should be used all the time.
> 
> What do you think?

I think it makes sense. Hans ?

-- 
Regards,

Laurent Pinchart
