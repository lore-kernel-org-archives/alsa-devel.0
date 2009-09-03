From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Thu, 3 Sep 2009 14:29:51 +0200
Message-ID: <7c5010d60909030529w7f226cc1s18c80f1eb0deab3a@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<4A9E9CB7.8040809@ladisch.de>
	<7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>
	<4A9FAD82.3050207@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 91386244E5
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 14:29:52 +0200 (CEST)
Received: by fxm3 with SMTP id 3so1570068fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 03 Sep 2009 05:29:52 -0700 (PDT)
In-Reply-To: <4A9FAD82.3050207@ladisch.de>
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

On Thu, Sep 3, 2009 at 1:50 PM, Clemens Ladisch<clemens@ladisch.de> wrote:
>> In centos is 1000HZ, in the kernels I compiled is 100HZ
>
> I would have expected these to be the other way around, since higher
> timer frequency should result in more accurate simulated sound card
> interrupts.
>
> Do you have different CONFIG_PREEMPT* settings?
>
> You could try compiling with the original CentOS configuration and
> switching settings until it breaks.

I'd have expected the same.

But it's not a problem between centos kernel and all of ALSA: the
other drivers works well.
Is a specific problem of snd-dummy.

Yes, CONFIG_PREEMPT* are probably different between the various
kernels, and also the compiled kernel is tickless.

But, this is a problem only with snd-dummy.

What I would like, in the interest of users, is snd-dummy to be
modified in a way that makes it working on the regular CentOS-RHEL
kernels, because CentOS-RHEL users will not like at all to change
their beloved kernels (you know... they like stable, boring and
predictable behavior).

If it can be useful, I can give you (or any other developer) ssh
access to a machine running centos.

Or, please let me know what I can do for providing useful informations.

(sorry for top posting)
-giovanni
