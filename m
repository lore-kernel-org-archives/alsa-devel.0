From: Dmitry Nezhevenko <dion@inhex.net>
Subject: Commit d6cc9fabd58f33e829a3182aa856db0d57c726ef breaks
 built-in mic on ASUS F6A
Date: Mon, 21 Nov 2011 21:27:13 +0200
Message-ID: <20111121192713.GA3677@laptop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dion.org.ua (dion.org.ua [193.104.35.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 457B31038F1
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 18:27:32 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I've found that internal doesn't work on kernel 3.1 while previous verison
(3.0) is ok.

I've bisected it between v3.0 and v3.1 using "arecord -V mono" command. It
wasn't easy because of NULL pointer dereference in patch_realtek.c that
was fixed by 60a6a8425a84fa46a3831ce79197640b8224311b.

So during bisect I was applying applicable part of 60a6a84 for every
attempt.

Finally I've found that commit d6cc9fabd58f33e829a3182aa856db0d57c726ef
breaks it. It's parent works well and just applying it on top breaks
internal mic on my laptop.

Unfortunately it's impossible to revert it on top of 3.1..

Alsa-info:
3.1 [working]: http://www.alsa-project.org/db/?f=0d7049d8892542ef89b7a3c40df2b1fd6b194282
3.0 [broken ]: http://www.alsa-project.org/db/?f=4792cc6c466c1dd5d01e2a80df1189ea5e34b83e_

Any ideas how to fix it?

commit d6cc9fabd58f33e829a3182aa856db0d57c726ef
Author: Takashi Iwai <tiwai @ suse.de>
Date:   Wed Jul 6 16:38:42 2011 +0200

    ALSA: hda - Parse ADCs and CAPSRCs dynamically for Realtek auto-parser

    Now with the new code for looking for ADCs and MUXs, we can replace
    the whole ADC assignment with the parsed results.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>

--
WBR, Dmitry
