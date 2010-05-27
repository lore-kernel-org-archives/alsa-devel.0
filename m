From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problem with snd_hda_intel from 05-27-2010 snapshot
Date: Thu, 27 May 2010 09:37:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005270931570.6856@eeebox2.perex-int.cz>
References: <AANLkTilIX_UnMYcg8LAqkndS80nFppblW6erTm2e7o5X@mail.gmail.com>
	<AANLkTinLbTMrYBhg6KO826slsugfEcU0_wYqukSQpQw2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1907091131-1274945845=:6856"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DA53E1039E1
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 09:37:25 +0200 (CEST)
In-Reply-To: <AANLkTinLbTMrYBhg6KO826slsugfEcU0_wYqukSQpQw2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1907091131-1274945845=:6856
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 26 May 2010, VDR User wrote:

>> Hi. =C2=A0I had been mostly successfully using the snd_hda_intel driver
>> from the stable kernel 2.6.34 for HDMI audio with my Nvidia GT220
>> video card. =C2=A0In an attempt to see if any recent changes to
>> snd_hda_intel would fix a problem I've been having with "pcm_hw.c:
>> snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed" I decided to download
>> the latest snapshot. =C2=A0Unfortunately with these drivers I have no
>> audio. =C2=A0All my settings, and everything have remained the same. =C2=
=A0The
>> only noticable difference I've found is
>> /sys/module/snd_hda_intel/parameters/probe_only is 0,0,0,0,0,0,0,0 in
>> the snapshot drivers, and N,N,N,N,N,N,N,N in the 2.6.34 kernel drivers
>> (which are compiled into the kernel).
>
> As a followup, I tried each snapshot going backwards from 05-27-2010
> to discover where the breakage occured.  The last working snapshot is
> 05-11-2010, it breaks at 05-12-2010.  After making a diff of the
> sound/pci/hda/ dir, I've discovered that the offending patch is:
>
> author=09Jaroslav Kysela <perex@perex.cz>
> =09 Tue, 11 May 2010 08:21:46 +0000 (10:21 +0200)
> committer=09Jaroslav Kysela <perex@perex.cz>
> =09 Tue, 11 May 2010 08:25:50 +0000 (10:25 +0200)
> commit=09432f57d106e6d5c69fce74c888de32c6df347494
> tree=09536120322429edb82d672547595d8dba7ac10b5e=09tree | snapshot
> parent=09533538fe6243d87b68db6942b1c7a1acb9fe504d=09commit | diff
>
> [ALSA] snd-hda-intel: use WALLCLK register to check for early irqs
>
> Use 24Mhz WALLCLK register to ignore too early interrupts and
> wrong interrupt status. The bad timing confuses the higher ALSA
> layer and causes audio skipping. More information about behaviour
> and debugging can be found in kernel bz#15912.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D15912

Check any suspicious lines in /var/log/messages and follow proc xrun_debug=
=20
settings noted in bug above. I need at least 20 first lines after the=20
playback is started.

Also, use 'aplay -Dplughw:0' from the alsa-utils package to trigger=20
the playback.

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1907091131-1274945845=:6856
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1907091131-1274945845=:6856--
