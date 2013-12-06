From: Jason Mancine <jason@mancine.net>
Subject: Re: Zoom R16
Date: Fri, 6 Dec 2013 12:28:51 -0500
Message-ID: <CAPrbH=uHUhWMYiGcHKLwFYiWwGhahNqAWjio1RKECM_dUnNN6A@mail.gmail.com>
References: <CAPrbH=vnQ-xXsRDoj30nra7hB_hDEaF6u3ov0XuDG_ZpFzb3bA@mail.gmail.com>
 <20131124130335.GA23126@tamtam.fritz.box>
 <CAPrbH=tGph7__rgx-5BsBSi9-E95FpsTL9Yy0zbum0TccTPbyQ@mail.gmail.com>
 <20131124141803.GC23126@tamtam.fritz.box>
 <CAPrbH=sA5ppp8z3bqdaDnk4U+DZ093ukXpDgiT6DEixGi1tdZA@mail.gmail.com>
 <CAPrbH=tu0jTctOAegkT7tnq1VSGOui4cESA2rYJFfgCa3=tQDg@mail.gmail.com>
 <CAPrbH=v+fVMibUGC8FqBbW-Gd6NW7uZFCgq7fxw9hiaPGR_04g@mail.gmail.com>
 <loom.20131206T170648-556@post.gmane.org>
 <s5h4n6m6j5q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id DB5CF2655C8
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 18:28:51 +0100 (CET)
Received: by mail-we0-f173.google.com with SMTP id u57so978278wes.4
 for <alsa-devel@alsa-project.org>; Fri, 06 Dec 2013 09:28:51 -0800 (PST)
In-Reply-To: <s5h4n6m6j5q.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

With it set to 3LE format it fails on both capture and playback, and is
still trying to initialize at 32 bits for both.

Any other formats I could try?
 On Dec 6, 2013 11:25 AM, "Takashi Iwai" <tiwai@suse.de> wrote:

> At Fri, 6 Dec 2013 16:10:01 +0000 (UTC),
> Jason Mancine wrote:
> >
> > It seems that ALSA is trying to initialize the device at 32-bit integer
> > little endian despite having the .formats set to SNDRV_PCM_FMTBIT_S24_LE
> in
> > the quirk. The device is 24-bit integer only.  Other devices I have
> > initialize properly at 24 bits.
>
> Do you mean the 24bit physical size, i.e. each frame is packed in 3
> bytes?  If so, you used a wrong format.  SNDRV_PCM_FMTBIT_S24_LE is
> for 24bit format packed in 32bit frame.  If you need a 3-bytes frame,
> use SNDRV_PCM_FMTBIT_S24_3LE instead.
>
>
> Takashi
>
