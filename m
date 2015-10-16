From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: DP1.2 MST audio support discussion
Date: Fri, 16 Oct 2015 08:32:50 +0800
Message-ID: <CAN8cciYqLBH=kXvPjrGTgGPg9p7euU5w9z=UYdvKk4Vnxf-YFw@mail.gmail.com>
References: <96A12704CE18D347B625EE2D4A099D1974C250@SHSMSX103.ccr.corp.intel.com>
 <561CA911.7070405@canonical.com>
 <96A12704CE18D347B625EE2D4A099D1974C304@SHSMSX103.ccr.corp.intel.com>
 <s5hlhb7ktum.wl-tiwai@suse.de>
 <CAN8cciZJ_YJhHEoU9HovR=P7FsxiKMDQ7johrmFGEWHQK_ZYNg@mail.gmail.com>
 <s5htwpuj6f5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id EF06A260522
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 02:32:53 +0200 (CEST)
Received: by oihr205 with SMTP id r205so55833095oih.3
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2015 17:32:50 -0700 (PDT)
In-Reply-To: <s5htwpuj6f5.wl-tiwai@suse.de>
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
> > Do it mean that only one DP MST port and no HDMI port on the same
graphic
> > card ?
>
> No.

If there is only one HDMI and one Display Port, this mean that there are
two pin complexes

How about the name of jack detection kctl of three Display Port monitors
which are created on the same pin complex but different dev_index ?

Will three three display port monitor playback devices always play
different stream even when the displays are in clone mode ?

>
> > If DP MST are dasiy chained, the unplug of the first monitor from
Display
> > Port will cause all DP monitor in the dasiy chain disconnect
>
> Yes.
>

Do the power off of the Display Port in the middle of the dasiy chain also
affect the last display port mointor in the dasiy chain ?
