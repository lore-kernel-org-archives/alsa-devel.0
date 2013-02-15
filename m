From: Monty Montgomery <xiphmont@gmail.com>
Subject: Re: emi62 (may be slightly off-topic)
Date: Fri, 15 Feb 2013 10:28:34 -0500
Message-ID: <CACrD=+8-kHTX0AVW5KLHG73mDp4+eccz4LqanpOzNGeCRZ+hRA@mail.gmail.com>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
 <4D821A18.30407@ladisch.de>
 <AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
 <4D894196.4040002@gmail.com>
 <1360657074.2790.71.camel@chello084112006029.chello.at>
 <s5hboblr611.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 11F792616B2
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 16:28:35 +0100 (CET)
Received: by mail-la0-f47.google.com with SMTP id fj20so3480113lab.20
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 07:28:34 -0800 (PST)
In-Reply-To: <s5hboblr611.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Karl Grill <kgrill@chello.at>
List-Id: alsa-devel@alsa-project.org

The in-kernel firmware loaders are also completely broken right now
due to the movement of the loader to userspace causing a deadlock in
the load process.  systemd tries to probe the USB topology when
handling the firmware request, but the current loader is synchronous,
so each blocks on the other.

I wrote a complete, new unified emi26/26 loader last year... and it
got bogged down in 'what is the license on the firmware anyway?' like
it has for all the submissions I've made regarding the 26/62 in the
past five years :-(

If you want just the loader and/or firmware update patches (we're also
shipping an unreleased alpha of the firmware IIRC, and there are
numerous bugs later releases fixed. Oh and they add 96kHz support),
write me.  I've been using the most recent version for the past year
wihthout problems.

Oh, actually, there is one problem, but it's not the loader:
disconnecting a device in use now hangs the entire USB subsystem until
reboot about 50% of the time, but that bug is there with the old
loader too.

Monty
