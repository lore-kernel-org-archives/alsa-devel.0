From: Dave Reisner <d@falconindy.com>
Subject: Re: [PATCH] alsa-restore.rules: refer to correct attr
Date: Sun, 12 Jan 2014 11:39:29 -0500
Message-ID: <20140112163929.GE580@rampage>
References: <1389543352-9105-1-git-send-email-dreisner@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D99F261A0A
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2014 17:39:32 +0100 (CET)
Received: by mail-qa0-f42.google.com with SMTP id k4so3285782qaq.1
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2014 08:39:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389543352-9105-1-git-send-email-dreisner@archlinux.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dave Reisner <dreisner@archlinux.org>
Cc: alsa-devel@alsa-project.org, systemd-devel@lists.freedesktpo.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 12, 2014 at 11:15:52AM -0500, Dave Reisner wrote:
> $attr{number} in the RUN rule is an empty expansion. This makes sense,
> because the path doesn't exist -- i.e., it refers to the path:
> 
> /sys/devices/pci0000:00/foo/bar/sound/card0/controlC0/number
> 
> Instead, refer to $attr{device/number}, which does exist.
> 
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
> This seems to have been broken when it was first introduced a little over
> three years ago (de7c3eff0e).

I dug into this a little more to figure out why this potentially *would*
have worked and found the following advice from udev(7) about $attr{}:

  If the matching device does not have such an attribute, and a previous
  KERNELS, SUBSYSTEMS, DRIVERS, or ATTRS test selected a parent device,
  then the attribute from that parent device is used.

So, knowing how RUN expansions work, the simple presence of the
following rule causes $attr{number} to expand properly

  SUBSYSTEM=="sound", ATTRS{id}=="M2496"

I named this /etc/udev/rules/91-alsa-foo.rules -- intentionally after
the restore rule.

Of course, this specifically matches my system, but one could imagine
a more general rule which would cause parent matches and thus change the
behavior of the subsequent $attr{number} expansion. I'm not sure if this
is intended behavior in udev since the parent match doesn't occur in the
same rule.

So, $attr{number} is potentially correct (but this seems weird), while
$attr{device/number} should always be correct.

Hope this makes sense...

> Please CC me on replies as I am not subscribed to the list.
> 
>  alsactl/90-alsa-restore.rules.in | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/alsactl/90-alsa-restore.rules.in b/alsactl/90-alsa-restore.rules.in
> index 88e12e0..c68119d 100644
> --- a/alsactl/90-alsa-restore.rules.in
> +++ b/alsactl/90-alsa-restore.rules.in
> @@ -2,7 +2,7 @@ ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", GOTO="
>  GOTO="alsa_restore_end"
>  
>  LABEL="alsa_restore_go"
> -TEST!="@daemonswitch@", RUN+="@sbindir@/alsactl restore $attr{number}"
> -TEST=="@daemonswitch@", RUN+="@sbindir@/alsactl nrestore $attr{number}"
> +TEST!="@daemonswitch@", RUN+="@sbindir@/alsactl restore $attr{device/number}"
> +TEST=="@daemonswitch@", RUN+="@sbindir@/alsactl nrestore $attr{device/number}"
>  
>  LABEL="alsa_restore_end"
> -- 
> 1.8.5.2
> 
