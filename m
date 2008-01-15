From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: hda_intel messages showing up in dmesg
Date: Tue, 15 Jan 2008 15:21:36 -0500
Message-ID: <76366b180801151221t4313fd8clb6ee47abe8a504c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 09B32243C7
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 21:21:38 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1880285rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 12:21:36 -0800 (PST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm seeing these messages show up in dmesg every once in a while. If
anyone has ideas as to why I'd be seeing these, I can help track down
any potential problems. I am having problems where ALSA playback
stutters while using the OSS-compatibility layer for ALSA works fine
with no stuttering.

After inserting the module w/ model=6stack-dig:

ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
hda_intel: azx_get_response timeout, switching to polling mode: last
cmd=0x225f0d00
hda_intel: azx_get_response timeout, switching to single_cmd mode:
last cmd=0x225f0d00
ACPI: PCI Interrupt 0000:01:05.2[B] -> GSI 19 (level, low) -> IRQ 18
hda-intel: Invalid position buffer, using LPIB read method instead.

After inserting the module w/ no model defined:

ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
ACPI: PCI Interrupt 0000:01:05.2[B] -> GSI 19 (level, low) -> IRQ 18
hda-intel: Invalid position buffer, using LPIB read method instead.

I've only seen the azx_get_response messages print out once. I see the
LPIB message print out every once in a while.

Thanks,
-Andrew
