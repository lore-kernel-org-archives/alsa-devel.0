From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] media: fix truncated entity specification
Date: Wed, 16 Nov 2011 01:33:04 +0100
Message-ID: <201111160133.04816.laurent.pinchart@ideasonboard.com>
References: <4EB5ADA9.6010104@ladisch.de> <201111150148.07957.laurent.pinchart@ideasonboard.com> <4EC262DD.1070502@ladisch.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4EC262DD.1070502@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Tuesday 15 November 2011 14:02:21 Clemens Ladisch wrote:
> Laurent Pinchart wrote:
> > On Saturday 05 November 2011 22:42:01 Clemens Ladisch wrote:
> > > When enumerating an entity, assign the entire entity specification
> > > instead of only the first two words.  (This requires giving the
> > > specification union a name.)
> > 
> > What about this (untested) simpler patch ?
> > 
> > -	u_ent.v4l.major = ent->v4l.major;
> > -	u_ent.v4l.minor = ent->v4l.minor;
> > +	memcpy(&u_ent.raw, &ent->raw, sizeof(u_ent.raw));
> 
> I would have written it this way if ent->raw actually existed.
> (And please don't tell me you want to increase the size of
> struct media_entity by 172 bytes.  :)

Oops, my bad :-)

Your patch looks good then, except that I would memcpy to u_ent.raw instead of 
u_ent.v4l. Would you also be ok with shortening specification to spec (or 
info) ?

-- 
Regards,

Laurent Pinchart
