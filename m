From: Manuel Schneider <manuel.schneider@kanal-ratte.de>
Subject: Re: Swissonic TS22PCI / Teratec Phase 22
 /	driver	problems with ice1724
Date: Wed, 20 Aug 2008 08:51:39 +0200
Message-ID: <48ABBEFB.7050406@kanal-ratte.de>
References: <48A4332E.4070704@kanal-ratte.de>
	<s5habff1zft.wl%tiwai@suse.de>	<48A43A2A.7050701@kanal-ratte.de>
	<s5h63q31yoh.wl%tiwai@suse.de>	<48A43C11.10904@kanal-ratte.de>
	<s5hzlnfznty.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mastersmail.com (mx1.mastersmail.com [195.114.98.122])
	by alsa0.perex.cz (Postfix) with ESMTP id C53BA2448D
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Aug 2008 08:51:43 +0200 (CEST)
In-Reply-To: <s5hzlnfznty.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ok, now to come back to my problems with the Swissonic / Terrasoniq TS22 
card.

Yesterday I checked the other cards I got in another Linux system, using 
the same base system, but on x86. In these systems the cards work 
perfectly, using "model=phase22". The server we've been talking about 
before is an amd64 system.

Suspecting a hardware problem with this individual card I replaced it, 
but the problem persists with other cards which worked fine in the x86 
systems. I also copied over /etc/modules.d/alsa, /etc/asound.conf and 
/var/lib/alsa/asound.state from the other system - just to be sure.

But it doesn't help - I still just get a terrible noise.
You might want to check it on http://radio.kanal-ratte.de:8000/rkr.ogg.

So there has to be a kind of a bug on amd64 systems...

Any ideas? The original Phase22 worked fine before the incident...

Greets,


Manuel

-- 
Kanal Ratte 104,5 MHz
...das Freie Radio im Wiesental

Hauptstrasse 82
79650 Schopfheim

Tel: +49 7622 6692-53
Fax: +49 7622 6692-54
