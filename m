From: VDR User <user.vdr@gmail.com>
Subject: Re: Problem with snd_hda_intel from 05-27-2010 snapshot
Date: Wed, 26 May 2010 17:17:05 -0700
Message-ID: <AANLkTinLbTMrYBhg6KO826slsugfEcU0_wYqukSQpQw2@mail.gmail.com>
References: <AANLkTilIX_UnMYcg8LAqkndS80nFppblW6erTm2e7o5X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id AD11524152
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 02:17:07 +0200 (CEST)
Received: by vws8 with SMTP id 8so282169vws.38
	for <alsa-devel@alsa-project.org>; Wed, 26 May 2010 17:17:06 -0700 (PDT)
In-Reply-To: <AANLkTilIX_UnMYcg8LAqkndS80nFppblW6erTm2e7o5X@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Hi. =A0I had been mostly successfully using the snd_hda_intel driver
> from the stable kernel 2.6.34 for HDMI audio with my Nvidia GT220
> video card. =A0In an attempt to see if any recent changes to
> snd_hda_intel would fix a problem I've been having with "pcm_hw.c:
> snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed" I decided to download
> the latest snapshot. =A0Unfortunately with these drivers I have no
> audio. =A0All my settings, and everything have remained the same. =A0The
> only noticable difference I've found is
> /sys/module/snd_hda_intel/parameters/probe_only is 0,0,0,0,0,0,0,0 in
> the snapshot drivers, and N,N,N,N,N,N,N,N in the 2.6.34 kernel drivers
> (which are compiled into the kernel).

As a followup, I tried each snapshot going backwards from 05-27-2010
to discover where the breakage occured.  The last working snapshot is
05-11-2010, it breaks at 05-12-2010.  After making a diff of the
sound/pci/hda/ dir, I've discovered that the offending patch is:

author	Jaroslav Kysela <perex@perex.cz>
	 Tue, 11 May 2010 08:21:46 +0000 (10:21 +0200)
committer	Jaroslav Kysela <perex@perex.cz>
	 Tue, 11 May 2010 08:25:50 +0000 (10:25 +0200)
commit	432f57d106e6d5c69fce74c888de32c6df347494
tree	536120322429edb82d672547595d8dba7ac10b5e	tree | snapshot
parent	533538fe6243d87b68db6942b1c7a1acb9fe504d	commit | diff

[ALSA] snd-hda-intel: use WALLCLK register to check for early irqs

Use 24Mhz WALLCLK register to ignore too early interrupts and
wrong interrupt status. The bad timing confuses the higher ALSA
layer and causes audio skipping. More information about behaviour
and debugging can be found in kernel bz#15912.

https://bugzilla.kernel.org/show_bug.cgi?id=3D15912

Signed-off-by: Jaroslav Kysela <perex@perex.cz>

sound/pci/hda/hda_intel.c
