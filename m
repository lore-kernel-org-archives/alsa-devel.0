From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] ALSA: hda - Fix wrong detection of
	"Headphone+LO" or "Speaker+LO"
Date: Tue, 03 Mar 2015 16:04:32 +0100
Message-ID: <54f5ce0b.08a2b775.bm000@wupperonline.de>
References: <54F5B60C.1050808@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F19526154F
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 16:06:57 +0100 (CET)
In-Reply-To: <54F5B60C.1050808@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote on Tue, 03 Mar 2015 14:24:28 +0100:

> If I understand correctly, you have three DACs, one internal speaker,
> one headphone jack, and three jacks that are both used for 5.1 surround
> and line out/mic/line in. Is this correct?

This is correct. In addition I have a front mic jack.

> How do the DACs get assigned in this case? One would assume that you'd
> get 02 -> Front LO, HP, Speaker, 03 -> Rear LO, 04 -> CLFE LO.

With my private patch to enforce multi-io I seem to lose the internal speaker
which isn't bad because it isn't connected (and probably never won't be).

You are right concerning the remaining assignments:

multi_outs = 14/0/0/0 : 2/3/4/0 (type LO)
  out path: depth=3 '02:0c:14'
multi_ios(2) = 1a/18 : 3/4
  mio path: depth=3 '03:0d:1a'
  mio path: depth=3 '04:0e:18'
hp_outs = 1b/0/0/0 : 2/0/0/0
  hp  path: depth=3 '02:0c:1b'
spk_outs = 15/0/0/0 : 0/0/0/0

> And then the volume/mute control for DAC node 02 would be called "PCM"
> (since both hp_lo_shared and spk_lo_shared are true), but in fact it would
> be more appropriate to call it "Front".

I've got a Master that would only affect the Front (PCM) and a PCM that
affected Surround/CLFE which was very unpleasant.

With the patch I'm getting a real Master (for all Front/Surround/CLFE) and a
separate Front Volume Control in addition to Surround, Center and LFE which
is exactly how it should be.

> Anyhow, I'd say that the typical case where we want the "Headphone+LO"
> names is where we have only one LO, and then multiout.num_dacs would be
> 1, not 2. (I think, it was a while since I looked into that part of the
> driver...)

I'm fine with everything below 3. :-) Just tell me.

Ingo
