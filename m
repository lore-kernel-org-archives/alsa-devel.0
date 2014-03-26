From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Thu, 27 Mar 2014 07:23:30 +0800
Message-ID: <CAN8cciYy4V4StjqRfPpgZ8JMEYZrvpJYCBjfZtNhcn_2enRx6g@mail.gmail.com>
References: <loom.20140326T163743-253@post.gmane.org>
 <CAN8ccib45znh-JbH57EhfbPNQg_fginmX9Tbr=yKMmd4D=iygQ@mail.gmail.com>
 <CAN8cciZkGx5XBO+u0b7V9YN8VU_rz8ckL8B=6oBFJr+-Yg8cxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f43.google.com (mail-qa0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B553A265171
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 00:23:31 +0100 (CET)
Received: by mail-qa0-f43.google.com with SMTP id j15so3072872qaq.30
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 16:23:30 -0700 (PDT)
In-Reply-To: <CAN8cciZkGx5XBO+u0b7V9YN8VU_rz8ckL8B=6oBFJr+-Yg8cxw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: andoru <andoru.blah@gmail.com>, tiwai@suse.de, clemens@ladisch.de, mnalis-alsadev@voyager.hr
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> I've previously posted under ALSA's user mailing list so to avoid the
> clutter, the details about what's happening is here:
> http://article.gmane.org/gmane.linux.alsa.user/38258
> http://article.gmane.org/gmane.linux.alsa.user/38260
>
> There was no debug info under /proc/asound/card0/ so nothing to give from
> there unless you guys need something specific.
>
> Output of alsa-debug.sh:
> http://www.alsa-project.org/db/?f=26187faadd47f3626029ba667cb004e74695f2b2

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/cmipci.c?id=1c583063a5c769fe2ec604752e383972c69e6d9b

Seem cannot read valid value from register within three trials

state.CMI8738 {
control.1 {
iface PCM
device 2
name 'Playback Channel Map'
value.0 0
value.1 0
value.2 0
value.3 0
value.4 0
value.5 0
comment {
access read
type INTEGER
count 6
range '0 - 36'
}
}

Seem bug in adding channel map to iec958 instead of analog

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/cmipci.c?id=f49921b894ec338696e47d985acc09df3cddbfd1

pcm.!default {
    type plug
    slave.pcm "dmixer"
}

You need asym plugin for playback and capture when overwrite pcm.default
