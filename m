From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Fix a wrong busy check in alt
 PCM open
Date: Mon, 3 Aug 2015 10:07:05 +0800
Message-ID: <CAN8ccibt=P16V=G5eaRjnq6HuviVD-Sq1Q4NsiYoZU9+hrUfpw@mail.gmail.com>
References: <1436340574-28256-1-git-send-email-tiwai@suse.de>
 <CAN8ccib8FgWEuN62NkBxZ2AU0=mduopWqQ6tvFQGgnbxR4z1xA@mail.gmail.com>
 <s5hy4hub1uv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B2A0261B23
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 04:07:06 +0200 (CEST)
Received: by oig1 with SMTP id 1so29626613oig.0
 for <alsa-devel@alsa-project.org>; Sun, 02 Aug 2015 19:07:05 -0700 (PDT)
In-Reply-To: <s5hy4hub1uv.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, kailang@realtek.com
List-Id: alsa-devel@alsa-project.org

> >
> > >
> > > Currently, the alt PCM open callback returns -EBUSY when an
> > > independent HP is turned off, supposing that it conflicts with the
> > > main PCM.  However, obviously, this check is wrong when the
> > > independent HP itself isn't enabled but the alt PCM was explicitly
> > > created via alc_dac_nid by a codec driver.
> >
> > The alt_pcm is created only when indep_hp == 1
> >
> > When indep_hp_enable = 0, HP is reconnected to analog device stream , alt
> > analog device return ebusy
> >
> > This look like bug in indep_hp_possible() which should return false when
> HP
> > and Line Out/Speaker share same DAC
>
> The problem happens in a very special case where the codec driver
> enables the alt PCM manually in a fixup.  It doesn't exist in the
> current code, so this is no real problem, but just a hypothetical
> issue.
>
>
http://git.kernel.org/cgit/linux/kernel/git/tiwai/hda-emu.git/tree/codecs/alc662-intel-d945gclf2?id=HEAD

This Intel Desktop motherboard is not in the support list of multistreaming

http://www.intel.com/support/motherboards/desktop/sb/CS-034206.htm

However , user can still enable Independent HP by using hint

multi_io = 0
indep_hp = 1

This mean that function indep_hp_possible() should return false for those
hda codecs which does not support multistreaming (e.g. ad1986a and alc66x)


https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=55a63d4da3b8850480a1c5b222f77c739e30e346

+ /* clear indep_hp flag if not available */
+ if (spec->indep_hp && !indep_hp_possible(codec))
+ spec->indep_hp = 0;
