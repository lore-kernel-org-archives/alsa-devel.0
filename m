From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Tue, 22 Jun 2010 10:15:13 +0100
Message-ID: <hvput5$a6o$1@dough.gmane.org>
References: <htls4d$phr$1@dough.gmane.org>
	<4BFE7840.4070004@ladisch.de>	<htm0et$eb4$1@dough.gmane.org>
	<htm9mn$n1c$1@dough.gmane.org>	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>	<huicj9$t30$1@dough.gmane.org>	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>	<hulnlp$m00$1@dough.gmane.org>	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>	<hur2pt$uaa$1@dough.gmane.org>	<20100613135349.GB5818@tango.0pointer.de>	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>	<hv4pfi$gqr$3@dough.gmane.org>	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>	<hv4vs6$a6q$1@dough.gmane.org>	<AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>	<AANLkTimxTM73el7iCE6nwUJMPFpYa0dY2R9SYxa3_j6N@mail.gmail.com>	<hv5dkf$tv8$1@dough.gmane.org>
	<AANLkTim5rmjxS6YV7j3QEXSW-EyUv2rsT3k2ZzOz-o9o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 674741038A9
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 11:14:28 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OQzYp-0005ZF-GP
	for alsa-devel@alsa-project.org; Tue, 22 Jun 2010 11:14:27 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2010 11:14:27 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2010 11:14:27 +0200
In-Reply-To: <AANLkTim5rmjxS6YV7j3QEXSW-EyUv2rsT3k2ZzOz-o9o@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 22/06/10 03:31 did gyre and gimble:
> 2010/6/14 Colin Guthrie <gmane@colin.guthr.ie>
>> I've made this change on my system and while previously my UI had no
>> "Base Volume" displayed (because all my "h/w" (I include softvol in
>> that) controls had their dB value >0.
>>
> 
> as your card has no h/w gain,  > 0dB , but the gain in softvol plugin is a
> software gain (i.e. in the red region in PA "s volume scale
> 
> how can base_volume display in gnome volume control (unamplified) ?
> 
> BTW ,  -46.5dB to 0dB of softvol plugin is software atten ( not h/w atten )

As I said above, anything that comes from alsa is considered h/w
amplification for the purposes of PA's volume scale. It's not practical
to differentiate them.

Does any card actually configure softvol, by default, to provide any
gain, > 0dB for outputs? If so, then this is IMO a bad idea.

Again, it's ultimately related to your range-checking bugbear. Users
would want to know when both hardware and software amplification kicks
in. In PA this is represented clearly by the 'Base Volume' marker for
the case of "h/w amplification" and volumes >0dB/100% in the "software
amplification".

Not all PA UIs allow this >0dB/100% slider: gnome-volume-control being
one that does and something that as you know, I made an effort to
standardise recently. I've not (yet) actually made much in the way of
progress on this due to various time constraints, but the principle of
what values to use is laid down.

FWIW, even within itself g-v-c is inconsistent. The full GUI allows up
to this 150%/~+11dB mark (it works in percentages which is ugly - I'll
be changing that), but the applet only goes up to 0dB which is rather
annoying. I'll try and fix that if noone beats me to it.

Col



-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
