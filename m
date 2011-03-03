From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [GIT PULL FOR 2.6.39] Media controller and OMAP3
	ISP driver
Date: Thu, 3 Mar 2011 10:29:41 +0100
Message-ID: <201103031029.44957.laurent.pinchart@ideasonboard.com>
References: <201102171606.58540.laurent.pinchart@ideasonboard.com>
	<4D6EA4EB.9070607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
	[95.142.166.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 503B1103819
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2011 10:30:27 +0100 (CET)
In-Reply-To: <4D6EA4EB.9070607@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: alsa-devel@alsa-project.org, Sakari Ailus <sakari.ailus@retiisi.org.uk>, Pawel Osciak <pawel@osciak.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mauro,

On Wednesday 02 March 2011 21:13:31 Mauro Carvalho Chehab wrote:
> Em 17-02-2011 13:06, Laurent Pinchart escreveu:
> >       v4l: Share code between video_usercopy and video_ioctl2
> 
> Two hunks failed on this patch:
> 
> $ quilt push
> Applying patch
> patches/0951-v4l-Share-code-between-video_usercopy-and-video_ioct.patch
> patching file drivers/media/video/v4l2-ioctl.c
> Hunk #1 FAILED at 325.
> Hunk #2 succeeded at 332 (offset -33 lines).
> Hunk #3 succeeded at 368 (offset -33 lines).
> Hunk #4 succeeded at 397 (offset -33 lines).
> Hunk #5 FAILED at 1982.
> 2 out of 5 hunks FAILED -- rejects in file drivers/media/video/v4l2-ioctl.c
> Patch
> patches/0951-v4l-Share-code-between-video_usercopy-and-video_ioct.patch
> does not apply (enforce with -f)
> 
> Basically, the code for video_ioctl2 suffered some recent changes. I
> suspect that the blamed patch is this one:
> 
> cff7fbc6 (Pawel Osciak           2010-12-23 04:15:27 -0300 2342)       
> bool    has_array_args; cff7fbc6 (Pawel Osciak           2010-12-23
> 04:15:27 -0300 2343)        size_t  array_size = 0;
> 
> Could you please fix the merge conflicts?

Sure. I'm working on that right now, I'll send a new pull request.

-- 
Regards,

Laurent Pinchart
