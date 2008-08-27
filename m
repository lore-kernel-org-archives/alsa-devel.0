From: Manuel Schneider <manuel.schneider@kanal-ratte.de>
Subject: Re:
	=?iso-8859-1?q?Swissonic_TS22PCI_/_Teratec_Phase_22_?=
	=?iso-8859-1?q?/=09driver=09problems_with_ice1724?=
Date: Wed, 27 Aug 2008 19:15:45 +0200
Message-ID: <200808271915.45819.manuel.schneider@kanal-ratte.de>
References: <48A4332E.4070704@kanal-ratte.de> <48ABBEFB.7050406@kanal-ratte.de>
	<s5h7iaabuhl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mastersmail.com (mx1.mastersmail.com [195.114.98.122])
	by alsa0.perex.cz (Postfix) with ESMTP id 52A0524799
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Aug 2008 19:15:59 +0200 (CEST)
In-Reply-To: <s5h7iaabuhl.wl%tiwai@suse.de>
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

Good news:
It works now.

But I still suspect a bug / an incompatibilty in the driver.

Today, I checked playback - that worked perfectly. Then I tried arecord / =

aplay - perfectly.

Then I switched the encoder (darkice) from OSS to alsa - now that works to.=
 I =

rechecked OSS - it's definitely the OSS compatibility layer which does not =

work - but worked fine before the card was replaced.

I also found another problem but this might be a darkice bug but I still wa=
nt =

to discuss it, because I had this problem with other cards, too:

When using alsa in darkice, setting the samplerate to 44100 in darkice as w=
ell =

as the mixer the samplerates still do not match. The 44100 Hz stream is "to=
o =

fast", resulting in mickey mouse voices and lag every few seconds.
This issue can be solved by setting defaults.pcm.dmix.rate to 44100 in =

/usr/share/alsa/alsa.conf.
Do you have an idea why this problem is here? Is it truely a darkice bug, a=
s =

it doesn't set the samplerate of the sounddevice properly or where is the =

cause?

Greets and thanks f=FCr the help,


Manuel
-- =

Kanal Ratte 104,5 MHz
Freies Radio Schopfheim

Hauptstrasse 82
79650 Schopfheim

Tel: +49 7622 6692-53
Fax: +49 7622 6692-54
