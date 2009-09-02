From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: snd_dummy on Centos - Redhat
Date: Wed, 2 Sep 2009 18:12:59 +0200
Message-ID: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id ABC7F2466B
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 18:13:01 +0200 (CEST)
Received: by bwz25 with SMTP id 25so870830bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 02 Sep 2009 09:13:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm the maintainer of skypiax, a channel driver for FreeSWITCH and
Asterisk that allows to connect to the Skype network (eg:
http://wiki.freeswitch.org/wiki/Skypiax ).

I'm trying to use snd-dummy 1.0.20 as a fake soundcard on a regular
Centos installation (verified with both 5.2 and 5.3, fully updated).

I tested with both the packages "stable" from ATrpms.net and compiling
from the source of alsa-project.org.

It gives me bad timing to the program that depends on it (eg: Skype),
resulting in unacceptable behavior.

On the same machine, same Centos kernel and distro, if I use 1.0.20
snd-hda-intel or snd-usb, no problem.

On the same machine, snd_dummy with other distro, no problem.

On the same machine, same Centos, if I compile and install a kernel,
snd_dummy has no problem.

So, it's a specific problem of incompatibility between snd-dummy and
the kernel of Centos 5.2 and 5.3 (same kernels as in RHEL5).

I'm trying hard to find where the problem is, but I'm not having success.

Please please please, can someone have a look at it?

If more informations are needed, I'm willing to cooperate.

Thanks in advance,

-giovanni
