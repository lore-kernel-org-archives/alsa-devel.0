Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B668D116F3
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:35:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D87F60210;
	Mon,  1 Dec 2025 21:35:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D87F60210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1764621325;
	bh=pyNVC7GqR901RHppuQOJXqCsUREa4yoHs1bBGaSXhqs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=qMAx9M6Ce1MCP2bfw6aRiOjzDsn+yug+rnLYMkUl4jO26FLI5iDspBhaujeKGIXdr
	 tUyIptCcSnC7NCP+UEOEArvFSmwtXnLcY7CBEwf/FgOBcO1DBuFWn6yZ9vD9nNjEIH
	 w9AEdKCxdXiMMWcFIaN3mvCdzIyGzFfGHpU6n2J8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57102F805CB; Mon,  1 Dec 2025 21:34:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 07B20F805CB;
	Mon,  1 Dec 2025 21:34:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46B31F805D9; Mon,  1 Dec 2025 21:33:47 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A3B60F805CB
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2025 21:33:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3B60F805CB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187d31a7c38dca00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-tools/pr/42@alsa-project.org>
References: <alsa-project/alsa-tools/pr/42@alsa-project.org>
Subject: hdspmixer: fix null pointer dereference in HDSPMixerWindow:handler_cb
Date: Mon,  1 Dec 2025 21:33:47 +0100 (CET)
Message-ID-Hash: BXL2XHFF66IEN4CN37A5WVGAYDZF5QLC
X-Message-ID-Hash: BXL2XHFF66IEN4CN37A5WVGAYDZF5QLC
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BXL2XHFF66IEN4CN37A5WVGAYDZF5QLC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools pull request #42 was edited from cheldt:

Fixes following error:

```
Program received signal SIGSEGV, Segmentation fault.
handler_cb () at /home/kenoby/dev/alsa-tools/hdspmixer/src/HDSPMixerWindow.cxx:278
278             if (fl_win->label()) {
(gdb) bt
#0  handler_cb () at /home/kenoby/dev/alsa-tools/hdspmixer/src/HDSPMixerWindow.cxx:278
#1  0x00007ffff7c5c791 in send_handlers () at /usr/src/debug/fltk/fltk-release-1.4.4/src/Fl.cxx:935
#2  Fl::handle_ () at /usr/src/debug/fltk/fltk-release-1.4.4/src/Fl.cxx:1620
#3  Fl::handle_ () at /usr/src/debug/fltk/fltk-release-1.4.4/src/Fl.cxx:1384
#4  0x00007ffff6dfb2ee in ffi_call_unix64 () at ../src/x86/unix64.S:104
#5  0x00007ffff6df79f8 in ffi_call_int () at ../src/x86/ffi64.c:676
#6  0x00007ffff6dfa6ce in ffi_call () at ../src/x86/ffi64.c:713
#7  0x00007ffff732d47a in wl_closure_invoke () at ../wayland-1.24.0/src/connection.c:1241
#8  0x00007ffff732e2e9 in dispatch_event () at ../wayland-1.24.0/src/wayland-client.c:1707
#9  0x00007ffff732e6bb in dispatch_queue () at ../wayland-1.24.0/src/wayland-client.c:1853
#10 wl_display_dispatch_queue_pending () at ../wayland-1.24.0/src/wayland-client.c:2190
#11 0x00007ffff7332776 in wl_display_dispatch_queue_timeout () at ../wayland-1.24.0/src/wayland-client.c:2096
#12 0x00007ffff7332860 in wl_display_dispatch_queue () at ../wayland-1.24.0/src/wayland-client.c:2163
#13 0x00007ffff7d017b2 in sync_done () at /usr/src/debug/fltk/fltk-release-1.4.4/src/drivers/Wayland/Fl_Wayland_Screen_Driver.cxx:1389
#14 0x00007ffff6dfb2ee in ffi_call_unix64 () at ../src/x86/unix64.S:104
#15 0x00007ffff6df79f8 in ffi_call_int () at ../src/x86/ffi64.c:676
#16 0x00007ffff6dfa6ce in ffi_call () at ../src/x86/ffi64.c:713
#17 0x00007ffff732d47a in wl_closure_invoke () at ../wayland-1.24.0/src/connection.c:1241
#18 0x00007ffff732e2e9 in dispatch_event () at ../wayland-1.24.0/src/wayland-client.c:1707
#19 0x00007ffff732e6bb in dispatch_queue () at ../wayland-1.24.0/src/wayland-client.c:1853
#20 wl_display_dispatch_queue_pending () at ../wayland-1.24.0/src/wayland-client.c:2190
#21 0x00007ffff7332776 in wl_display_dispatch_queue_timeout () at ../wayland-1.24.0/src/wayland-client.c:2096
#22 0x00007ffff7332860 in wl_display_dispatch_queue () at ../wayland-1.24.0/src/wayland-client.c:2163
#23 0x00007ffff7d03561 in Fl_Wayland_Screen_Driver::open_display_platform () at /usr/src/debug/fltk/fltk-release-1.4.4/src/drivers/Wayland/Fl_Wayland_Screen_Driver.cxx:1426
#24 Fl_Wayland_Screen_Driver::open_display_platform () at /usr/src/debug/fltk/fltk-release-1.4.4/src/drivers/Wayland/Fl_Wayland_Screen_Driver.cxx:1406
#25 0x00007ffff7ca6da7 in Fl_Screen_Driver::open_display () at /usr/src/debug/fltk/fltk-release-1.4.4/src/Fl_Screen_Driver.cxx:605
#26 Fl_Screen_Driver::open_display () at /usr/src/debug/fltk/fltk-release-1.4.4/src/Fl_Screen_Driver.cxx:600
#27 0x00007ffff7d03d14 in Fl_Wayland_Screen_Driver::get_system_colors () at /usr/src/debug/fltk/fltk-release-1.4.4/src/drivers/Wayland/Fl_Wayland_Screen_Driver.cxx:1708
#28 0x00007ffff7cec929 in Fl_Window::show () at /usr/src/debug/fltk/fltk-release-1.4.4/src/Fl_arg.cxx:290
#29 0x000055555557b8aa in Fl_Double_Window::show () at /usr/include/FL/Fl_Double_Window.H:36
#30 main () at /home/kenoby/dev/alsa-tools/hdspmixer/src/hdspmixer.cxx:120
```


Related [Issue](https://github.com/alsa-project/alsa-tools/issues/43)

Request URL   : https://github.com/alsa-project/alsa-tools/pull/42
Patch URL     : https://github.com/alsa-project/alsa-tools/pull/42.patch
Repository URL: https://github.com/alsa-project/alsa-tools
