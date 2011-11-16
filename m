From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] media: fix truncated entity specification
Date: Wed, 16 Nov 2011 08:42:27 +0100
Message-ID: <4EC36963.9000300@ladisch.de>
References: <4EB5ADA9.6010104@ladisch.de> <201111150148.07957.laurent.pinchart@ideasonboard.com> <4EC262DD.1070502@ladisch.de> <201111160133.04816.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201111160133.04816.laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Laurent Pinchart wrote:
> > > On Saturday 05 November 2011 22:42:01 Clemens Ladisch wrote:
> > > > When enumerating an entity, assign the entire entity specification
> > > > instead of only the first two words.  (This requires giving the
> > > > specification union a name.)
> 
> Your patch looks good then, except that I would memcpy to u_ent.raw instead of
> u_ent.v4l. Would you also be ok with shortening specification to spec (or
> info) ?

Yes, go ahead.


Regards,
Clemens
