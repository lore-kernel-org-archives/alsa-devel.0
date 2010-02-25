From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsactl restore: unknown hardware: ymf724f
Date: Thu, 25 Feb 2010 09:25:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002250915480.28127@eeebox2.perex-int.cz>
References: <hm5aba$p65$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D69A103964
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 09:25:29 +0100 (CET)
In-Reply-To: <hm5aba$p65$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Angel Tsankov <fn42551@fmi.uni-sofia.bg>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Feb 2010, Angel Tsankov wrote:

> Hello,
>
> I run 'alsactl restore' on a machine with 2 sound cards -- a built-in
> Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev
> 02) and a non-built-in Yamaha Corporation YMF-724F [DS-1 Audio
> Controller] (rev 03) -- and get the following message:
>
> Unknown hardware: "YMF724F" "SigmaTel STAC9700,83,84" "AC97a:83847600"
> "0x1073" "0x000d"
> Hardware is initialized using a guess method
>
> As a consequence the volume levels of the Yamaha card do not get
> restored to the levels stored in /etc/asound.state.  The volume levels
> of the built-in card however are properly restored.  The asound.state
> file has been created by executing 'alsactl store'.
>
> The kernel has been built with support for ALSA.  I've built and
> installed the kernel modules for both cards (not the ones in the
> alsa-driver package but those that come with kernel version 2.6.30.2).
> Any ideas why alsactl cannot find the hardware it has previously
> identified as "YMF724F", "SigmaTel STAC9700,83,84", and so on?

The logic of alsactl is to restore the state from /etc/asound.state if it 
is valid. It seems like the set_controls() function in alsactl/state.c 
returns an error code for a reason.

Could you try to compile the latest alsa-utils snapshot 
(http://www.alsa-project.org/snapshot/) and run './alsactl -d restore' in 
alsa-utils/alsactl directory? A warning (fail reason) should be printed.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
