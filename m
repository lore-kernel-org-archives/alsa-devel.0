From: Monty Montgomery <xiphmont@gmail.com>
Subject: Re: emi62 (may be slightly off-topic)
Date: Fri, 15 Feb 2013 10:37:07 -0500
Message-ID: <CACrD=+9P6Gj51HMRb-rdZeoQ7yjzpu2J=pkq9eNj-ZH8HGAe+A@mail.gmail.com>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
 <4D821A18.30407@ladisch.de>
 <AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
 <4D894196.4040002@gmail.com>
 <1360657074.2790.71.camel@chello084112006029.chello.at>
 <s5hboblr611.wl%tiwai@suse.de>
 <CACrD=+8-kHTX0AVW5KLHG73mDp4+eccz4LqanpOzNGeCRZ+hRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BB252616B9
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 16:37:08 +0100 (CET)
Received: by mail-la0-f51.google.com with SMTP id fo13so3553315lab.10
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 07:37:08 -0800 (PST)
In-Reply-To: <CACrD=+8-kHTX0AVW5KLHG73mDp4+eccz4LqanpOzNGeCRZ+hRA@mail.gmail.com>
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

On Fri, Feb 15, 2013 at 10:28 AM, Monty Montgomery <xiphmont@gmail.com> wrote:
> The in-kernel firmware loaders are also completely broken right now
> due to the movement of the loader to userspace causing a deadlock in
> the load process.

Sorry, let me be more clear there; it is now the responsibility of
systemd to find and return firmware when the in-kernel loader makes a
firmware request.  Unfortunately, systemd can't resist firing off
several 'learn everything we can about this device!' threads when the
firmware request comes in, and if one of them hits the USB bus blocked
in probe() waiting for firmware before the firmware request is
fufilled (this happens much of the time) the load request deadlocks.
It will time out in ~20s, and then the process repeats through several
retries before finally failing.

The solution is a loader that makes an asynchronous firmware request
in probe and handles the response in a callback, which is what my new
loader did/does.

Also: I'm happy to resubmit the code, but I'm not interested in trying
to chase down all the licensing information for the firmware as Tapio
has disappeared and eMagic is no more.  As far as I know, we never had
anything but Tapio's word that we had permission to ship any version
of firmware.  I'd rather just see the driver pulled from the kernel
(after all, it hasn't worked in years), and distribute modules by hand
as an individual to the last remaining eMagic people, than deal with
the red tape.

Monty
