From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: soc-core: Question about cpu_dai and codec_dai
	conversions
Date: Tue, 30 Sep 2008 09:10:57 -0700
Message-ID: <48E24F91.1020201@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id CA83124535
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 18:11:14 +0200 (CEST)
Received: from [192.168.0.251] (unknown [67.42.45.38])
	(Authenticated sender: troy.kisky@boundarydevices.com)
	by smtpauth00.csee.onr.siteprotect.com (Postfix) with ESMTP id
	752C7758084
	for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2008 11:11:13 -0500 (CDT)
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


Currently, we have the line

runtime->hw.formats =
	codec_dai->playback.formats & cpu_dai->playback.formats;

in soc-core.c

This seems to force the two to support a common subset.
For example some codec support only big-endian or little-endian

My codec expects the most significant bit to be shifted 1st. I would
call that big-endian. But the codec marks itself as only doing little
endian, because the cpu_dai converts from little-endian to big-endian.
Do all codecs expect the msb 1st? If so, then endianness would seem irrelevant
to codecs and both should be set.


The same goes with number of channels. The davinci dma engine can convert
a playback stream from mono to stereo, or a capture stream from stereo
to mono. The davinci McBsp can also be more efficient if allowed to swap
left and right channels. Is there a method to let the codec know to swap
them back?

Thanks
Troy
