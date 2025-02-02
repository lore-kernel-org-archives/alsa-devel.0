Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2119EC0218F
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Feb 2025 12:56:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC6916019F;
	Sun,  2 Feb 2025 13:56:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC6916019F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1738500999;
	bh=VLyhRxL0cFNVHyicUEpAZ+A2pDwUl8cJT/gJhdjS0aE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bHPViuOHDux0qwq3ONoCMt250ArW7PPPXf1RjVU4WLdszmIIsO4/8zhkeOPkJdWT6
	 qx7rBR3eh+oYwr8dKY+cJN1rmWnBw0kBmL1u7rR1hJ4W2qUrAOI1YY1JvO3NJakxws
	 LePwz7qXNOD4W7nMoaCM+C1c3p5jaYrCCMoDTMBk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C05C8F805C2; Sun,  2 Feb 2025 13:56:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A2B69F805C3;
	Sun,  2 Feb 2025 13:56:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C1142F8049C; Sun,  2 Feb 2025 13:55:57 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EB066F8014B
	for <alsa-devel@alsa-project.org>; Sun,  2 Feb 2025 13:55:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB066F8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1738500952613963366-webhooks-bot@alsa-project.org>
References: <1738500952613963366-webhooks-bot@alsa-project.org>
Subject: Compilation failure with Clang-21 due to macro conflicts
Message-Id: <20250202125557.C1142F8049C@alsa1.perex.cz>
Date: Sun,  2 Feb 2025 13:55:57 +0100 (CET)
Message-ID-Hash: E47MTKZLF2WL3QH57QIBRSZCTEQDPPIG
X-Message-ID-Hash: E47MTKZLF2WL3QH57QIBRSZCTEQDPPIG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E47MTKZLF2WL3QH57QIBRSZCTEQDPPIG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #436 was opened from ms178:

**Description:**

Attempting to compile alsa-lib (both the `git` version and version 1.2.13) with Clang-21 (commit `bfa7edcc6652bdb37d53e0cec64926aab3f280eb`) results in multiple compilation errors. These errors stem from conflicts between macros defined in `midifile.h` and member names within structures defined in `include/alsa/ump_msg.h`.

**Environment:**

*   **alsa-lib version:** `git` (and 1.2.13)
*   **Compiler:** Clang-21 (`bfa7edcc6652bdb37d53e0cec64926aab3f280eb`)
*   **Operating System:** CachyOS
*   **Build System:** Autotools

**Steps to Reproduce:**

1.  Obtain the PKGBUILD and the other files from https://github.com/ms178/archpkgbuilds/blob/main/packages/alsa-lib-main/PKGBUILD
2.  Uncomment the patch that I apply to workaround the issue.
3.  Configure the build to use Clang-21 (`bfa7edcc6652bdb37d53e0cec64926aab3f280eb`).
4.  Attempt to compile the library.

**Expected Behavior:**

The compilation should complete successfully without errors.

**Actual Behavior:**

The compilation fails with multiple errors similar to the following:

```
In file included from playmidi1.c:51:
In file included from ./../include/asoundlib.h:63:
In file included from ../include/alsa/seq_event.h:31:
../include/alsa/ump_msg.h:170:27: error: expected member name or ';' after declaration specifiers
  170 |         snd_ump_msg_midi1_note_t        note_on;        /**< MIDI1 note-on message */
      |         ~~~~~~~~~~~~~~~~~~~~~~~~        ^
./midifile.h:55:27: note: expanded from macro 'note_on'
   55 | #define note_on                 0x90
      |                                 ^
In file included from playmidi1.c:51:
In file included from ./../include/asoundlib.h:63:
In file included from ../include/alsa/seq_event.h:31:
../include/alsa/ump_msg.h:170:26: error: expected ';' at end of declaration list
  170 |         snd_ump_msg_midi1_note_t        note_on;        /**< MIDI1 note-on message */
      |                                 ^
      |                                 ;
../include/alsa/ump_msg.h:171:27: error: expected member name or ';' after declaration specifiers
  171 |         snd_ump_msg_midi1_note_t        note_off;       /**< MIDI1 note-off message */
      |         ~~~~~~~~~~~~~~~~~~~~~~~~        ^
./midifile.h:54:27: note: expanded from macro 'note_off'
   54 | #define note_off                0x80
      |                                 ^
In file included from playmidi1.c:51:
In file included from ./../include/asoundlib.h:63:
In file included from ../include/alsa/seq_event.h:31:
../include/alsa/ump_msg.h:171:26: error: expected ';' at end of declaration list
  171 |         snd_ump_msg_midi1_note_t        note_off;       /**< MIDI1 note-off message */
      |                                 ^
      |                                 ;
../include/alsa/ump_msg.h:173:26: error: expected member name or ';' after declaration specifiers
  173 |         snd_ump_msg_midi1_cc  CCLD     rawmidi
_t          control_change; /**< MIDI1 control-change message */
      |         ~~~~~~~~~~~~~~~~~~~~~~          ^
./midifile.h:57:28: note: expanded from macro 'control_change'
   57 | #define control_change          0xb0
      |                                 ^
In file included from playmidi1.c:51:
In file included from ./../include/asoundlib.h:63:
In file included from ../include/alsa/seq_event.h  CCLD     oldapi
:31:
../include/alsa/ump_msg.h:173:24: error: expected ';' at end of declaration list
  173 |         snd_ump_msg_midi1_cc_t          control_change; /**< MIDI1 control-change message */
      |                               ^
      |                               ;
../include/alsa/ump_msg.h:432:27: error: expected member name or ';' after declaration specifiers
  432 |         snd_ump_msg_midi2_note_t        note_on;        /**< MIDI2 note-on message */
      |         ~~~~~~~~~~~~~~~~~~~~~~~~        ^
./midifile.h:55:27: note: expanded from macro 'note_on'
   55 | #define note_on                 0x90
      |                                 ^
  CCLD     pcm_min
In file included from playmidi1.c:51:
In file included from ./../include/asoundlib.h:63:
In file included from ../include/alsa/seq_event.h:31:
../include/alsa/ump_msg.h:432:26: error: expected ';' at end of declaration list
  432 |         snd_ump_msg_midi2_note_t        note_on;        /**< MIDI2 note-on message */
      |                                 ^
      |                                 ;
../include/alsa/ump_msg.h:433:27: error: expected member name or ';' after declaration specifiers
  433 |         snd_ump_msg_midi2_note_t        note_off;       /**< MIDI2 note-off message */
      |         ~~~~~~~~~~~~~~~~~~~~~~~~        ^
./midifile.h:54:27: note: expanded from macro 'note_off'
   54 | #define note_off                0x80
      |                                 ^
In file included from playmidi1.c:51:
In file included from ./../include/asoundlib.h:63:
In file included from ../include/alsa/seq_event.h:31:
../include/alsa/ump_msg.h:433:26: error: expected ';' at end of declaration list
  433 |         snd_ump_msg_midi2_note_t        note_off;       /**< MIDI2 note-off message */
      |                                 ^
      |                                 ;
../include/alsa/ump_msg.h:438:26: error: expected member name or ';' after declaration specifiers
  438 |         snd_ump_msg_midi2_cc_t          control_change; /**< MIDI2 control-change message */
      |         ~~~~~~~~~~~~~~~~~~~~~~          ^
./midifile.h:57:28: note: expanded from macro 'control_change'
   57 | #define control_change          0xb0
      |                                 ^
In file included from playmidi1.c:51:
In file included from ./../include/asoundlib.h:63:
In file included from ../include/alsa/seq_event.h:31:
../include/alsa/ump_msg.h:438:24: error: expected ';' at end of declaration list
  438 |         snd_ump_msg_midi2_cc_t          control_change; /**< MIDI2 control-change message */
      |                               ^
      |                               ;
../include/alsa/ump_msg.h:711:27: error: expected member name or ';' after declaration specifiers
  711 |         snd_ump_msg_set_tempo_t         set_tempo;      /**< Set Tempo */
      |         ~~~~~~~~~~~~~~~~~~~~~~~         ^
./midifile.c:57:20: note: expanded from macro 'set_tempo'
   57 | #define set_tempo               0x51
      |                                 ^
In file included from playmidi1.c:51:
In file included from ./../include/asoundlib.h:63:
In file included from ../include/alsa/seq_event.h:31:
../include/alsa/ump_msg.h:711:25: error: expected ';' at end of declaration list
  711 |         snd_ump_msg_set_tempo_t         set_tempo;      /**< Set Tempo */
      |                                ^
      |                                ;
  CCLD     control
  CCLD     chmap
14 errors generated.
```

**Root Cause analysis by AI:**

The macros `note_on`, `note_off`, `control_change`, and `set_tempo` defined in `midifile.h` are conflicting with member names used in structures within `include/alsa/ump_msg.h`. This leads to incorrect code expansion and subsequent compilation errors.

**Workaround:**

The following patch applied to `include/asoundlib-head.h` allows the compilation to succeed:

```diff
--- a/include/asoundlib-head.h
+++ b/include/asoundlib-head.h
@@ -28,6 +28,11 @@
 #ifndef __ASOUNDLIB_H
 #define __ASOUNDLIB_H
 
+#undef note_on
+#undef note_off
+#undef control_change
+#undef set_tempo
+
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
```

**Suggested Solutions by AI:**

While the provided workaround resolves the immediate compilation issue, a more robust solution might involve:

1.  **Renaming conflicting members:** Consider renaming the members in `ump_msg.h` (e.g., `midi1_note_on`, `midi2_note_off`, etc.) to avoid clashes with commonly used MIDI event names.
2.  **Namespace/prefix:** If renaming is not feasible, consider using a namespace or prefix for the `ump_msg.h` members to prevent conflicts.
3.  **Conditional undef:** Instead of unconditionally undefining the macros in `asoundlib-head.h`, a more targeted approach could be to undefine them only within the scope of `ump_msg.h`'s inclusion.
4.  **Review macro definitions:** Investigate if the macros in `midifile.h` are strictly necessary or if they can be replaced with constants or enums within a namespace.

**Additional Notes:**

*   I am not a programmer and cannot provide a definitive fix. The provided workaround is based on AI feedback.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/436
Repository URL: https://github.com/alsa-project/alsa-lib
