From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Fix a wrong busy check in alt
 PCM open
Date: Sun, 2 Aug 2015 14:03:25 +0800
Message-ID: <CAN8ccib8FgWEuN62NkBxZ2AU0=mduopWqQ6tvFQGgnbxR4z1xA@mail.gmail.com>
References: <1436340574-28256-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id B527F260713
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 08:03:26 +0200 (CEST)
Received: by obre1 with SMTP id e1so79569248obr.1
 for <alsa-devel@alsa-project.org>; Sat, 01 Aug 2015 23:03:25 -0700 (PDT)
In-Reply-To: <1436340574-28256-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, kailang@realtek.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> Currently, the alt PCM open callback returns -EBUSY when an
> independent HP is turned off, supposing that it conflicts with the
> main PCM.  However, obviously, this check is wrong when the
> independent HP itself isn't enabled but the alt PCM was explicitly
> created via alc_dac_nid by a codec driver.

The alt_pcm is created only when indep_hp == 1

When indep_hp_enable = 0, HP is reconnected to analog device stream , alt
analog device return ebusy

This look like bug in indep_hp_possible() which should return false when HP
and Line Out/Speaker share same DAC

There are exception even when HP and Line Out are assigned different DACs
(e.g. those 6 channels HDA codecs ad1986a and alc66x does not support
multistreaming)
