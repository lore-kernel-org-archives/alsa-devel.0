From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: gusclassic alsa configuration
Date: Sun, 25 Jan 2009 09:19:23 +0100
Message-ID: <20090125091923.432dfbd5.krzysztof.h1@poczta.fm>
References: <20090121223507.778f954d.krzysztof.h1@poczta.fm>
	<20090121215037.GC4996@sci.fi> <s5h8wp37glk.wl%tiwai@suse.de>
	<20090122173332.a5b8f459.krzysztof.h1@poczta.fm>
	<s5h8wp35mg9.wl%tiwai@suse.de>
	<20090122231105.3ff437c2.krzysztof.h1@poczta.fm>
	<s5h1vuujze5.wl%tiwai@suse.de>
	<20090123130922.83218e8e.krzysztof.h1@poczta.fm>
	<s5h7i4m87fu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 78D031037EA
	for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2009 09:16:20 +0100 (CET)
In-Reply-To: <s5h7i4m87fu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 23 Jan 2009 14:42:45 +0100
Takashi Iwai <tiwai@suse.de> wrote:
> 
> OK, then let's define the default config for GUS at first, then
> fix the system-wide default making somehow better.
> 
> Could you post the latest patch?
> 

The latest version of the GUS.conf is below.
I have found that the issue is probably the same as 
the ALSA bug #1770 so it should be closed/fixed
if the change is applied to ALSA.

Regards,
Krzysztof

--- /usr/src/alsa/alsa-lib-1.0.18/src/conf/cards/GUS.conf	2008-10-29 13:42:10.000000000 +0100
+++ alsa/cards/GUS.conf	2009-01-25 09:03:56.738474703 +0100
@@ -19,10 +19,12 @@ GUS.pcm.front.0 {
 }	
 
 #
-# It's a temporary solution.
+# First route with plug to drop mmap requirement.
+# Then, use the mmap_emul plugin to allow using
+# noninterleaved channels.
 #
 
-!pcm.hw {
+!pcm.default {
 	@args [ CARD DEV SUBDEV ]
 	@args.CARD {
 		type string
@@ -58,9 +60,14 @@ GUS.pcm.front.0 {
 			name defaults.pcm.subdevice
 		}
 	}		
-	type hw
-	card $CARD
-	device $DEV
-	subdevice $SUBDEV
-	mmap_emulation on
+	type plug
+	slave.pcm {
+		type mmap_emul
+		slave.pcm {
+			type hw
+			card $CARD
+			device $DEV
+			subdevice $SUBDEV
+		}
+	}
 }


----------------------------------------------------------------------
Promocja w Speak Up. 3 miesiace angielskiego gratis.
Sprawdz teraz i wypelnij formularz! >> http://link.interia.pl/f2019
