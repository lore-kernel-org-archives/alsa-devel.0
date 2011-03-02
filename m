From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [GIT PULL FOR 2.6.39] Media controller and OMAP3 ISP driver
Date: Wed, 02 Mar 2011 17:13:31 -0300
Message-ID: <4D6EA4EB.9070607@redhat.com>
References: <201102171606.58540.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201102171606.58540.laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, alsa-devel@alsa-project.org, Sakari Ailus <sakari.ailus@retiisi.org.uk>, Pawel Osciak <pawel@osciak.com>
List-Id: alsa-devel@alsa-project.org

Em 17-02-2011 13:06, Laurent Pinchart escreveu:
>       v4l: Share code between video_usercopy and video_ioctl2

Two hunks failed on this patch:

$ quilt push
Applying patch patches/0951-v4l-Share-code-between-video_usercopy-and-video_ioct.patch
patching file drivers/media/video/v4l2-ioctl.c
Hunk #1 FAILED at 325.
Hunk #2 succeeded at 332 (offset -33 lines).
Hunk #3 succeeded at 368 (offset -33 lines).
Hunk #4 succeeded at 397 (offset -33 lines).
Hunk #5 FAILED at 1982.
2 out of 5 hunks FAILED -- rejects in file drivers/media/video/v4l2-ioctl.c
Patch patches/0951-v4l-Share-code-between-video_usercopy-and-video_ioct.patch does not apply (enforce with -f)

Basically, the code for video_ioctl2 suffered some recent changes. I suspect that the
blamed patch is this one:

cff7fbc6 (Pawel Osciak           2010-12-23 04:15:27 -0300 2342)        bool    has_array_args;
cff7fbc6 (Pawel Osciak           2010-12-23 04:15:27 -0300 2343)        size_t  array_size = 0;

Could you please fix the merge conflicts?

Thanks!
Mauro.
