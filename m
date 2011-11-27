From: John F Leach <jfleach@jfleach.com>
Subject: Re: [PATCH] [ALSA] usb-audio - Support for Roland GAIA
 SH-01 Synthesizer
Date: Sun, 27 Nov 2011 17:15:30 -0500
Message-ID: <1322432130.19532.7.camel@darkside>
References: <1322404484.6913.20.camel@darkside> <4ED25560.40208@gmail.com>
	<1322410227.14597.19.camel@darkside> <4ED26875.9080108@gmail.com>
	<s5h8vn1xy6h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a37.g.dreamhost.com (caiajhbdcbbj.dreamhost.com
	[208.97.132.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 0ACC22455E
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 23:15:38 +0100 (CET)
In-Reply-To: <s5h8vn1xy6h.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, clemens <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

> Yes, I can fix it by myself.
> But, the patch doesn't pass checkpatch.pl test, so I postpone for
> now.
> 
> John, please fix warnings scripts/checkaptch.pl gives as much as
> possible.  Some warnings can be ignored (e.g. over 80 chars), but
> space issues should be fixed at least.

Takashi,

I replaced the spaces with tabs, I didn't realize I was supposed to run checkpatch.pl before submitting.
How do I fix the ERROR: space prohibited after that '&' (ctx:WxW)?  All of the other table entries look like this.

$ scripts/checkpatch.pl 0001-ALSA-usb-audio-Support-for-Roland-GAIA-SH-01-Synthes.patch
ERROR: space prohibited after that '&' (ctx:WxW)
#28: FILE: sound/usb/quirks-table.h:1638:
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 	                               ^

WARNING: line over 80 characters
#45: FILE: sound/usb/quirks-table.h:1655:
+				.data = & (const struct snd_usb_midi_endpoint_info) {

ERROR: space prohibited after that '&' (ctx:WxW)
#45: FILE: sound/usb/quirks-table.h:1655:
+				.data = & (const struct snd_usb_midi_endpoint_info) {
 				        ^

total: 2 errors, 1 warnings, 37 lines checked

0001-ALSA-usb-audio-Support-for-Roland-GAIA-SH-01-Synthes.patch has style problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.


Regards,

John F Leach
