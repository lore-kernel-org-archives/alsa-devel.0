From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v8 00/12] Media controller (core and V4L2)
Date: Fri, 28 Jan 2011 10:38:09 +0800
Message-ID: <AANLkTik_Tujgt6mrtHqL_z+MPdq0-PFUAOJP6Abh6Lcd@mail.gmail.com>
References: <1296131437-29954-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DF581037F9
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 03:38:11 +0100 (CET)
Received: by ewy19 with SMTP id 19so1263376ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 18:38:11 -0800 (PST)
In-Reply-To: <1296131437-29954-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/27 Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Hi everybody,
>
> Here is the eighth version of the media controller core and V4L2 patches.
>
> Quick reminder for those who missed the previous version. let me quote the
> documentation (Documentation/DocBook/v4l/media-controller.xml).
>
> "Discovering a [media] device internal topology, and configuring it at
> runtime,
> is one of the goals of the media controller API. To achieve this, hardware
> devices are modelled as an oriented graph of building blocks called
> entities
> connected through pads."
>
>
> I want to emphasize once again that the media controller API does not
> replace
> the V4L, DVB or ALSA APIs. It complements them.
>
>
How does media controller API allow the media application to know there are
multi streaming playback devices ?

http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm#multistream

via codec can reconfigure the independent headphone at runtime but some
codec require a reboot to select this multi steaming playback model



how does media controller api allow the application/pulseaudio server to
know whether surround5.1 and rear mic/line in for those 3 jacks motherboard
cannot be used at the same time ?

http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm#6ch

via codec using "smart51" switch and other codec use "channel mode" to
switch between 2 channels and 6 channels

5 jacks model may have "channel mode" to switch between 6 channels and 8
channels

some high-end notebook may switch from 2 channels to 8 channels when they
have four jacks (pink, blue , green and grey )
