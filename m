From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] slimbus: Fix out-of-bounds access in slim_slicesize()
Date: Sun,  8 Apr 2018 11:02:34 +0200
Message-ID: <1523178154-1130-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: alsa-devel@alsa-project.org

With gcc-4.1.2:

    slimbus/messaging.c: In function ‘slim_slicesize’:
    slimbus/messaging.c:186: warning: statement with no effect

Indeed, clamp() is a macro not operating in-place, but returning the
clamped value.  Hence the value is not clamped at all, which may lead to
an out-of-bounds access.

Fix this by assigning the clamped value.

Fixes: afbdcc7c384b0d44 ("slimbus: Add messaging APIs to slimbus framework")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 884419c37e8419c8..457ea1f8db309cb9 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -183,7 +183,7 @@ static u16 slim_slicesize(int code)
 		0, 1, 2, 3, 3, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7
 	};
 
-	clamp(code, 1, (int)ARRAY_SIZE(sizetocode));
+	code = clamp(code, 1, (int)ARRAY_SIZE(sizetocode));
 
 	return sizetocode[code - 1];
 }
-- 
2.7.4
