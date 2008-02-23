From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: asihpi - how much further?
Date: Fri, 22 Feb 2008 19:52:13 -0500
Message-ID: <75b66ecd0802221652s6dd2a56fye01616b5e17c93aa@mail.gmail.com>
References: <200802221226.59326.linux@audioscience.com>
	<s5hskzkykuh.wl%tiwai@suse.de>
	<200802231010.59448.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DD8124568
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 01:52:15 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 60so907237wri.8
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 16:52:14 -0800 (PST)
In-Reply-To: <200802231010.59448.linux@audioscience.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: Takashi Iwai <tiwai@suse.de>, greg@kroah.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 22, 2008 at 4:10 PM, Eliot Blennerhassett
<linux@audioscience.com> wrote:
>  You also mentioned handling the ioctl via alsa hwdep.   I'm interested in
>  hearing more about this.  Can it be made so that applications using HPI_IOCTL
>  and using /dev/asihpi still work?  I just don't know enough about how to
>  start on hwdep implementation.

Please take a look at snd_emu10k1_fx8010_ioctl in
alsa-kernel/pci/emu10k1/emufx.c for examples of hwdep ioctl usage.

Lee
