From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC/PATCH v7 01/12] media: Media device node
	support
Date: Tue, 11 Jan 2011 08:15:37 +0800
Message-ID: <AANLkTikPSWL9HGvDnES6EuLh1QAriHqAk=tas9ogBOMi@mail.gmail.com>
References: <1292844995-7900-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<201012241259.39148.laurent.pinchart@ideasonboard.com>
	<20110106221912.GA31328@suse.de>
	<201101101509.13793.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id D8D7D24337
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 01:15:37 +0100 (CET)
Received: by ewy19 with SMTP id 19so8388061ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 16:15:37 -0800 (PST)
In-Reply-To: <201101101509.13793.laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/10 Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Hi Greg,
>
> On Thursday 06 January 2011 23:19:12 Greg KH wrote:
> > On Fri, Dec 24, 2010 at 12:59:38PM +0100, Laurent Pinchart wrote:
> > > On Thursday 23 December 2010 04:32:53 Greg KH wrote:
> > > > On Mon, Dec 20, 2010 at 12:36:24PM +0100, Laurent Pinchart wrote:
> > > > > +config MEDIA_CONTROLLER
> > > > > +       bool "Media Controller API (EXPERIMENTAL)"
> > > > > +       depends on EXPERIMENTAL
> > > > > +       ---help---
> > > > > +         Enable the media controller API used to query media
> devices
> > > > > internal +        topology and configure it dynamically.
> > > > > +
> > > > > +         This API is mostly used by camera interfaces in embedded
> > > > > platforms.
>

codecgraph and the graph function HDA-analyzer already expose the internal
topology

Do this new API allow media application to reconfigure the HDA's  audio path
of a desktop to support multi streaming playback

http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm#multistream
