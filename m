From: "Matthew R. Hurne" <matt.hurne@versatile.com>
Subject: Re: Intel ICH7/Realtek ALC262 on MSI MS-7290 (Crystal
 945)
Date: Thu, 31 Jan 2008 13:59:57 -0500
Message-ID: <47A21AAD.6000203@versatile.com>
References: <479770D5.6000501@versatile.com>	 <47977134.4000700@versatile.com>
	<1201763319.23369.61.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mustang.versatile.com (mustang.versatile.com [206.61.179.31])
	by alsa0.perex.cz (Postfix) with ESMTP id DBEBC1038DC
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 19:59:58 +0100 (CET)
In-Reply-To: <1201763319.23369.61.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobin Davis wrote:
> Sorry for not getting back sooner.   Could you try alsa-1.0.16rc2 with
> the following configuration:
> 
>     ./configure --with-cards=hda-intel --with-debug=detect && make &&
>     sudo make install
> 
> After it is installed, type "dmesg" and look for the alsa output
> (line-outs, speakers, etc).  Copy that into an email and send it to me,
> please.
> 
> Tobin
> 


No worries about not getting back sooner - I appreciate you getting back at all!

I've done as you requested, and here is the output of dmesg:

ALSA /root/alsa-driver-1.0.16rc2/alsa-kernel/pci/hda/hda_intel.c:1788: chipset global capabilities = 0x4401
ALSA /root/alsa-driver-1.0.16rc2/alsa-kernel/pci/hda/hda_intel.c:740: codec_mask = 0x1
hda_codec: Unknown model for ALC262, trying auto-probe from BIOS...
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:2863: autoconfig: line_outs=1 (0x15/0x0/0x0/0x0/0x0)
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:2867:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:2871:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:2872:    mono: mono_out=0x0
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:2880:    inputs: mic=0x18, fmic=0x0, line=0x1a, fline=0x0, cd=0x0, aux=0x0
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Surround Playback Volume, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Center Playback Volume, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave LFE Playback Volume, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Side Playback Volume, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Headphone Playback Volume, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Speaker Playback Volume, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Mono Playback Volume, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Line-Out Playback Volume, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Surround Playback Switch, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Center Playback Switch, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave LFE Playback Switch, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Side Playback Switch, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Headphone Playback Switch, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Speaker Playback Switch, skipped
ALSA /root/alsa-driver-1.0.16rc2/pci/hda/hda_codec.c:1079: Cannot find slave Mono Playback Switch, skipped
