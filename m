From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [regression] ALSA: hda - Handle open while
	transitioning to D3.
Date: Sat, 14 Jul 2012 02:21:28 -0700
Message-ID: <CAEUnVG6s9wxMjN-BQ3_iW0EDZ1A6c+UgsV-3EaBTbLVDFUVkig@mail.gmail.com>
References: <50010B52.7060803@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by alsa0.perex.cz (Postfix) with ESMTP id C9DDB24370
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jul 2012 11:21:28 +0200 (CEST)
Received: by wgbdr13 with SMTP id dr13so3163143wgb.25
	for <alsa-devel@alsa-project.org>; Sat, 14 Jul 2012 02:21:28 -0700 (PDT)
In-Reply-To: <50010B52.7060803@fisher-privat.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Jul 13, 2012 11:01 PM, "Oleksij Rempel (fishor)" <
bug-track@fisher-privat.net> wrote:
>
> Hallo Dylan, Takashi,
>
> I have regression after patch b4a91cf05c3 "ALSA: hda - Handle open while
transitioning to D3."
>
> This regression i can reproduce only if my laptop works on batteries.
After this patch it needs almost 1 minute more to start. The login screen
usually plays start sound, but after this patch it wait until sound card is
ready.
>
> My hardware: asus zenbook ux31e.
>
> Codec: Realtek ALC269VB
>
> 00:1b.0 0403: 8086:1c20 (rev 05)
>         Subsystem: 1043:1427
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 50
>         Region 0: Memory at dfe00000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: <access denied>
>         Kernel driver in use: snd_hda_intel
>         Kernel modules: snd-hda-intel
>

Could you enable config_snd_debug and send the output during startup?  I'm
actually using the same codec on one of our systems.

Thanks for testing.

Dylan
