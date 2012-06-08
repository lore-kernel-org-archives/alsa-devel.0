From: =?ISO-8859-1?Q?J=F6rg-Volker_Peetz?= <jvpeetz@web.de>
Subject: Re: [PATCH 0/2] HD-audio HDMI regression fixes with VGA-switcheroo
Date: Fri, 08 Jun 2012 13:26:57 +0200
Message-ID: <4FD1E181.4030805@web.de>
References: <1339064116-18579-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1339064116-18579-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote, on 06/07/12 12:15:
> Hi,
> =

> this is a series of patches to fix the regressions of HD-audio HDMI
> on D-GPUs in 3.5-rc1 due to the support of VGA-switcheroo audio clients.
> =

> The first patch adds a new helper function to vga-switcheroo and the
> second just uses that instead of an open code.
> =

> Dave, if the first patch is OK, I'm going to apply it though sound tree.
> Let me know if any problem is found.
> =

> Joerg, could you check whether this doesn't break your setup, too?
> =

> =

> thanks,
> =

> Takashi

Hello Takashi,

I applied both your patches on 3.5-rc1. With this kernel I made three tests.
1) After booting I switched off the discrete GPU via vga_switcheroo.
   Then ca. 210 times the message

     hda-intel: spurious response 0x0:0x0, last cmd=3D0x170503

   appears on the console and in the logs.
   Starting X and using the built-in USB web-cam work, as well as sound with
   mplayer2 works.

2) After booting I switched to the discrete GPU via

     echo -n DDIS > /sys/kernel/debugfs/vgaswitcheroo/switch

   Then I started X via startx. The desktop screen appears but the system
   freezes. No reaction on keyboard or touchpad input. The computer is not
   reachable via ethernet wire.

3) After booting the machine freezes (hard-lock) when trying to switch to
   dynamic power mangement on the integrated GPU via

     echo -n dynpm > /sys/class/drm/card0/device/power_method

  at least two trace calls are done. On the console only the last two lines=
 of
  one call trace and the last one are visible (machine is frozen). It says
  (typed by hand, therefore, not complete):

...
---[ end trace a926a4156be75305 ]---
BUG: unable to handle kernel paging request at fffffffffffffff8
IP: [<ffffffff81045097>] kthread_data+0x7/0x10
PGD 1585067 PUD 1586067 PMD 0
Oops: 0000 [#2] SMP
CPU 1

...

Call Trace:
[< ... >] ? wq_worker_sleeping+0x8/0x80
   ...    ? __schedule+0x363/0x520
   ...    ? do_exit+0x552/0x850
   ...    ? oops_end+0x67/0x90
   ...    ? no_context+0x24e/0x279
   ...    ? do_page_fault+0x2bb/0x460

...
---[ end trace a926a4156be75305 ]---
Fixing recursive fault but reboot is needed!

-- =

Best regards,
J=F6rg-Volker.
