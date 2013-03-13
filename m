From: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Subject: Re: [Alsa-user] Master volume control
Date: Wed, 13 Mar 2013 09:47:59 -0700
Message-ID: <DB754736B2E5480F987C1DE8E330AC7C@PAULD>
References: <B3AC1EE66F1142FF99DDC145B8669DDD@PAULD>
 <512F0AF5.3050502@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net
 (elasmtp-kukur.atl.sa.earthlink.net [209.86.89.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D74A26257E
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 17:48:13 +0100 (CET)
Received: from [76.173.239.98] (helo=PAULD)
 by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4.67)
 (envelope-from <pderocco@ix.netcom.com>) id 1UFoqX-0004bE-J1
 for alsa-devel@alsa-project.org; Wed, 13 Mar 2013 12:48:09 -0400
In-Reply-To: <512F0AF5.3050502@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> From: Clemens Ladisch [mailto:cladisch@googlemail.com] 
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <alsa/asoundlib.h>
> 
> static void check(int err, const char *f)
> {
>         if (err < 0) {
>                 fprintf(stderr, "%s failed: %s\n", f, 
> snd_strerror(err));
>                 exit(EXIT_FAILURE);
>         }
> }
> #define CHECK(f) check(f, #f)
> 
> int main()
> {
>         snd_ctl_t *ctl;
>         snd_ctl_elem_value_t *value;
> 
>         CHECK(snd_ctl_open(&ctl, "default", 0));
> 
>         snd_ctl_elem_value_alloca(&value);
>         snd_ctl_elem_value_set_interface(value, 
> SND_CTL_ELEM_IFACE_MIXER);
>         snd_ctl_elem_value_set_name(value, "Master Playback Volume");
>         snd_ctl_elem_value_set_integer(value, 0, 42);
>         CHECK(snd_ctl_elem_write(ctl, value));
> 
>         snd_ctl_close(ctl);
>         return 0;
> }

Well, I finally got a chance to try this. It "works", but the
snd_ctl_elem_write call takes a couple of milliseconds (that's around a
million instructions on my Atom), and it apparently spends this time in
kernel state, because it causes my sound thread to underrun, so it's not
usable.

If I use alsamixer, I don't have this problem; I can manipulate the master
volume smoothly while I'm playing my synth app. So I went through the
source, and found that it's using snd_mixer_selem_set_playback_volume. This
is apparently part of something called the "Simple Mixer Interface", yet
another section of ALSA which is completely undocumented, other than the
Doxygen stuff (which is only meaningful as a reference for someone who
already knows it inside out, but can't remember e.g. whether playback_pcm
comes before or after capture_pcm in the snd_mixer_selem_regopt structure).

So what's the minimum I need to do in order to get at the Master Playback
Volume, via the Simple Mixer Interface?

-- 

Ciao,               Paul D. DeRocco
Paul                mailto:pderocco@ix.netcom.com 
