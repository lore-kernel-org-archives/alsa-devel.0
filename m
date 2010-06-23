From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Wed, 23 Jun 2010 10:12:00 +0100
Message-ID: <hvsj32$6cm$1@dough.gmane.org>
References: <htls4d$phr$1@dough.gmane.org>
	<htm9mn$n1c$1@dough.gmane.org>	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>	<huicj9$t30$1@dough.gmane.org>	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>	<hulnlp$m00$1@dough.gmane.org>	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>	<hur2pt$uaa$1@dough.gmane.org>	<20100613135349.GB5818@tango.0pointer.de>	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>	<hv4pfi$gqr$3@dough.gmane.org>	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>	<hv4vs6$a6q$1@dough.gmane.org>	<AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>	<AANLkTimxTM73el7iCE6nwUJMPFpYa0dY2R9SYxa3_j6N@mail.gmail.com>	<hv5dkf$tv8$1@dough.gmane.org>	<AANLkTim5rmjxS6YV7j3QEXSW-EyUv2rsT3k2ZzOz-o9o@mail.gmail.com>	<hvput5$a6o$1@dough.gmane.org>	<AANL
 kTilwbCSM7rPLUlAKtTUv1UepbHzvyZTh4CsElOJm@mail.gmail.com>	<hvqqf9$p3j$1@dough.gmane.org>
	<AANLkTim8KsRcWcg3lkqb8RZqhPT_Bp53dwwlQ3ccay1L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 86037243C1
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 11:11:08 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1ORLz9-0007mL-S3
	for alsa-devel@alsa-project.org; Wed, 23 Jun 2010 11:11:07 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 11:11:07 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 11:11:07 +0200
In-Reply-To: <AANLkTim8KsRcWcg3lkqb8RZqhPT_Bp53dwwlQ3ccay1L@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 23/06/10 02:15 did gyre and gimble:
> why PA server still insist to open front device for capturing ?

Couldn't tell you. Perhaps Lennart is unaware that it is considered
invalid? I'll ask him.

> http://thread.gmane.org/gmane.linux.alsa.devel/67912/focus=68248
> 
> As Takashi had already mention that
> 
> "I agree that the capture from "front" PCM isn't considered as valid.
> The "front", "rear", "center_lfe" definitions are rather for multi-channel
> playbacks. The capture on these channels aren't useful in most cases."
> 
> you can perform an experiement
> 
> pcm.test {
>     type softvol
>     slave.pcm "hw:0,0"
>     control {
>         name "PA Playback Volume"
>         card 0
>     }
> 
> arecord -D test -f CD -d 10 -v test.wav
> 
> you will find "PA Playback Volume" in playback screen of alsamixer
> 
> I am not sure the softvol control created when PA open front device
> for playback and capture is used for playback or capture
> 
> BTW , PA still using "front" to open CTL device too

You'll have to ask Lennart directly about that bit.

I can't speak for him with regards to the full setup of the mixer path
probing stuff, so perhaps "front" should be edited out of this for
paths. It would likely be a fairly trivial change to configuration files
rather than any code changes.

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
