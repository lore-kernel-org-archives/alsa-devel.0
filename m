From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: No sound card found for ATI SB600 Azalia
Date: Mon, 23 Jul 2007 22:42:07 -0400
Message-ID: <75b66ecd0707231942k15fa92c3mc67211764375bee8@mail.gmail.com>
References: <Pine.LNX.4.58.0707232239190.25733@shell.terminus.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.238])
	by alsa0.perex.cz (Postfix) with ESMTP id CE27F1038AA
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 04:42:08 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so1284557nzf
	for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2007 19:42:07 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.58.0707232239190.25733@shell.terminus.sk>
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
To: Marek Zelem <marek@terminus.sk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/23/07, Marek Zelem <marek@terminus.sk> wrote:
> ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
> ALSA
> /usr/src/modules/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:558:
> hda_intel: azx_get_response timeout, switching to polling mode...
> ALSA
> /usr/src/modules/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:564:
> hda_intel: azx_get_response timeout, switching to single_cmd mode...
> hda_codec: No auto-config is available, default to model=ref
> ALSA
> /usr/src/modules/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1020:
> hda-intel: no codecs initialized

Takashi-san,

Maybe you should add another printk() to HDA intel driver that
instructs the user to post relevant debug info
(/proc/asound/card0/codecblah...) to alsa-devel in these cases where
we encounter some problem that is likely to result in no sound?  Other
subsystems do it in similar cases (essentially, too many hardware
variants for the maintainers to have any chance of testing them all)
and it seems to produce good results.  It would make a lot of users
happy to not have to google for what to do next...

Lee
