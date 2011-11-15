From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] media: fix truncated entity specification
Date: Tue, 15 Nov 2011 14:02:21 +0100
Message-ID: <4EC262DD.1070502@ladisch.de>
References: <4EB5ADA9.6010104@ladisch.de>
	<201111150148.07957.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de
	[80.67.31.38]) by alsa0.perex.cz (Postfix) with ESMTP id 7436D1038B8
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 14:02:23 +0100 (CET)
In-Reply-To: <201111150148.07957.laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: alsa-devel@alsa-project.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: alsa-devel@alsa-project.org

Laurent Pinchart wrote:
> On Saturday 05 November 2011 22:42:01 Clemens Ladisch wrote:
> > When enumerating an entity, assign the entire entity specification
> > instead of only the first two words.  (This requires giving the
> > specification union a name.)
> 
> What about this (untested) simpler patch ?
> 
> -	u_ent.v4l.major = ent->v4l.major;
> -	u_ent.v4l.minor = ent->v4l.minor;
> +	memcpy(&u_ent.raw, &ent->raw, sizeof(u_ent.raw));

I would have written it this way if ent->raw actually existed.
(And please don't tell me you want to increase the size of
struct media_entity by 172 bytes.  :)


Regards,
Clemens
