From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 3 Sep 2009 16:47:20 +0200
Message-ID: <7c5010d60909030747n55b6f48r2322aabf47f17171@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<4A9E9CB7.8040809@ladisch.de>
	<7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>
	<4A9FAD82.3050207@ladisch.de> <s5heiqoqfh4.wl%tiwai@suse.de>
	<7c5010d60909030723l44055b5au84a487d78ef6252f@mail.gmail.com>
	<s5hbplsqeye.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CB3D2458A
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 16:47:25 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1604910bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 07:47:23 -0700 (PDT)
In-Reply-To: <s5hbplsqeye.wl%tiwai@suse.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 3, 2009 at 4:29 PM, Takashi Iwai<tiwai@suse.de> wrote:
> Or, just copy alsa-kernel/drivers/dummy.c to your tree.
> There is no other changes except for documentation.
>
Takashi,

I copied it in the 1.0.20 tree, and I had to copy also the files:
/usr/src/alsa-driver-unstable/include/linux/math64.h
/usr/src/alsa-driver-unstable/include/math64_compat.h

Compiled into the 1.0.20 tree, maintaining the results of the previous
./configure, it does not make difference.

I will now try to compile from it's own snapshot tree, doing the ./configure.

-giovanni
