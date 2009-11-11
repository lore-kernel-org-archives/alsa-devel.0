From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: What is a name for the PC speaker input/output volume
	control?
Date: Wed, 11 Nov 2009 15:12:58 +0100
Message-ID: <20091111151258.61598339.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 46782244AD
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 15:10:13 +0100 (CET)
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I have run into the issue that OSS emulation layer provides less controls
than the alsa mixer. One specific problem is the OSS Speaker control
is not properly mapped on all drivers (among others the wss/cs4236 family)
due to the fact that the speaker input/output is called "Mono" in this driver.

I have found that there are at least three names are used by drivers:
"PC Speaker"
"Speaker"
"Mono"
for the same input/output pair (At least on the ISA cards there is only single
purpose mono channel - to route the PC speaker). 

Which name should be used? I will convert all ISA drivers to the selected 
name (and fix the OSS mixer to map this name to the "Speaker" control).

Regards,
Krzysztof

----------------------------------------------------------------------
Kawalerka za 79 000 zl!
Sprawdz >>> http://link.interia.pl/f2425
