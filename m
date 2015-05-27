From: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
Subject: Re: [PATCH RESEND v3 2/2] ALSA: replace CONFIG_PROC_FS with CONFIG_SND_PROC_FS
Date: Wed, 27 May 2015 15:56:14 +0200
Message-ID: <5565CCFE.702@melag.de>
References: <1432727145-6504-1-git-send-email-yang.jie@intel.com> <1432727145-6504-3-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432727145-6504-3-git-send-email-yang.jie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jie Yang <yang.jie@intel.com>, tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com, vivian.zhang@intel.com
List-Id: alsa-devel@alsa-project.org

Am 27.05.2015 um 13:45 schrieb Jie Yang:
> We may disable proc fs only for sound part, to reduce ALSA
> memory footprint. So add CONFIG_SND_PROC_FS and replace the
> old CONFIG_PROC_FSs in alsa code.
>
> With sound proc fs disabled, we can save about 9KB memory
> size on X86_64 platform.

=46or consistency, both patches should be squashed into one, IMHO.


cu
--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg =
HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f=FCr ein=
en begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist =
ausschlie=DFlich f=FCr denjenigen bestimmt, an den sie gerichtet worden=
 ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d=FCrfen Sie dies=
e nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweis=
e in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt=FCmlich er=
halten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf =
diese Nachricht antworten. Bitte l=F6schen Sie in diesem Fall diese Nac=
hricht und alle Anh=E4nge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged i=
nformation. It is intended only for the person it was addressed to. If =
you are not the intended recipient of this email you may not copy, forw=
ard, disclose or otherwise use it or any part of it in any form whatsoe=
ver. If you received this email in error please notify the sender by re=
plying and delete this message and any attachments without retaining a =
copy.
