From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: include/uapi/firewire.h for other firewire drivers
Date: Fri, 01 Nov 2013 09:36:46 +0100
Message-ID: <5273681E.6010701@ladisch.de>
References: <526A6092.4030709@sakamocchi.jp> <526A6C50.2000901@ladisch.de>
 <526B5017.8010106@sakamocchi.jp> <526E207B.5060301@ladisch.de>
 <5272151C.2010208@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id BC5F2265158
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 09:37:16 +0100 (CET)
In-Reply-To: <5272151C.2010208@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> my drivers have PCM rules for auto-adjustment of rate/channels. Should
> I remove them and fix rate/channels according to current sampling rate?

When the clock source is internal or the PC, the driver can change the
sample rate.  When the clock source is external, the rate is constrained.

> As long as I know, this type of device changes its channel formation
> of AMDTP stream according to current sampling rate and current digital
> input interface. The driver can get current sampling rate by AV/C
> command but cannot get current digital input interface because it's
> 'write-only'.
>
> For this setting, which is better for control panel/mixer application,
> control interface or hwdep interface with firewire.h?

For settings (like this) that the kernel driver knows about, it should
use a mixer control, because the control interface already has mechanisms
to notify others of changes, and to lock controls.

The hwdep interface is appropriate for commands that must go through the
driver for technical reasons (such as EFC's response address), but where
the driver does not care about the actual meaning of the command.

(For other commands, like A/VC, the application can go directly through
/dev/fw*.)


Regards,
Clemens
