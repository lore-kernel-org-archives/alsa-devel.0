From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Wed, 14 Oct 2015 07:52:08 +0800
Message-ID: <CAN8cciZJ_YJhHEoU9HovR=P7FsxiKMDQ7johrmFGEWHQK_ZYNg@mail.gmail.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
 <561CA911.7070405@canonical.com>
 <96A12704CE18D347B625EE2D4A099D1974C304@SHSMSX103.ccr.corp.intel.com>
 <s5hlhb7ktum.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 2705B265CA8
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2015 01:52:10 +0200 (CEST)
Received: by obbzf10 with SMTP id zf10so27038655obb.2
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 16:52:08 -0700 (PDT)
In-Reply-To: <s5hlhb7ktum.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Yang, Libin" <libin.yang@intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "airlied@linux.ie" <airlied@linux.ie>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "tanuk@iki.fi" <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> >
> > > One could then allocate two extra PCMs from the start (9 and 10) to
> > > try
> > > in case the other PCM is busy (my preference), or one could steal one
> > > of
> > > the existing non-busy ones (Takashi's preference).
> >
> > We will create the PCMs based on converter. This means we will
> > create 3 PCMs. And it will not support dynamically allocating PCM.
> > As there are only 3 converters, no more PCMs will be supported.
> > Each PCM will use one converter. If 3 PCMs are all used, connecting
> > monitor will not create new PCM.
> >
> > Yes, if we are not using the PCM, we can re-assign the PCM to another
> > monitor. Currently, user can't decide which PCM is used for which
> > monitor. Image the scenario PCM 3 is assigned to monitor 1, PCM 7 is
> > assigned to monitor 2, PCM 8 is assigned to monitor 3. Monitor 4 is
> > connected, no PCM is available, and driver don't know whether it
> > should steal one PCM for the monitor 4 and user can't change the
> > mapping currently.
>
> Actually, there are a few things to implement properly:
>
> 1. The plug/unplug events are triggered at the actual graphics output
>    switching via xrandr or such, not at the time the monitor is
>    physically plugged/unplugged.
>
> 2. At switching, the unplug event must be handled at first, and then
>    the plug event.
>
> 3. At unplug, detach per_pin object properly from PCM.
>    We currently just notify it via jack ctl, and doesn't care the
>    rest.  Ideally, we should force to stop the PCM and detach
>    internally from the assigned pin.
>
> 4. At plug, assign the monitor to the free per_pin object.
>
> So what we've discussed is about the last step; how to map the new
> monitor to per_pin object.  This requires the other steps beforehand
> which assures a free per_pin is present at plug time.
>

Do it mean that only one DP MST port and no HDMI port on the same graphic
card ?

If DP MST are dasiy chained, the unplug of the first monitor from Display
Port will cause all DP monitor in the dasiy chain disconnect
