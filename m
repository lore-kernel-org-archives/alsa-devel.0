From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Tue, 22 Jun 2010 18:05:41 +0100
Message-ID: <hvqqf9$p3j$1@dough.gmane.org>
References: <htls4d$phr$1@dough.gmane.org>
	<4BFE7840.4070004@ladisch.de>	<htm0et$eb4$1@dough.gmane.org>
	<htm9mn$n1c$1@dough.gmane.org>	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>	<huicj9$t30$1@dough.gmane.org>	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>	<hulnlp$m00$1@dough.gmane.org>	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>	<hur2pt$uaa$1@dough.gmane.org>	<20100613135349.GB5818@tango.0pointer.de>	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>	<hv4pfi$gqr$3@dough.gmane.org>	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>	<hv4vs6$a6q$1@dough.gmane.org>	<AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>	<AANLkTimxTM73el7iCE6nwUJMPFpYa0dY2R9SYxa3_j6N@mail.gmail.com>	<hv5dkf$tv8$1@dough.gmane.org>	<AANLkTim5rmjxS6YV7j3QEXSW-EyUv2rsT3k2ZzOz-o9o@mail.gmail.com>	<hvput5$a6o$1@dough.gmane.org>
	<AANLkTilwbCSM7rPLUlAKtTUv1UepbHzvyZTh4CsElOJm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E697245D6
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 19:04:58 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OR6u6-00005H-E1
	for alsa-devel@alsa-project.org; Tue, 22 Jun 2010 19:04:54 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2010 19:04:54 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2010 19:04:54 +0200
In-Reply-To: <AANLkTilwbCSM7rPLUlAKtTUv1UepbHzvyZTh4CsElOJm@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 22/06/10 16:29 did gyre and gimble:
> 2010/6/22 Colin Guthrie <gmane@colin.guthr.ie>
>> As I said above, anything that comes from alsa is considered h/w
>> amplification for the purposes of PA's volume scale. It's not practical
>> to differentiate them
> 
> 
> Software gain is different from hardware gain.

Really? Wow, thanks for that :p

> Clipping due to software gain +12dB cannot compensated by -12dB by hardware
> atten

Another obvious statement, but not really anything to do with the
discussion.

This only becomes a problem if the softvol plugin is configured to go
>0dB. And if it is, then I've got to ask why....

You can configure all sorts of crazy and weird shit in alsa if you care
to, but it's totally impractical for something higher in the stack to
deal with all the nuances of the ultimate results of that configuration.
As far as anything further up the stack is concerned, if it's
represented in alsa, it's "hardware".

Just like softmodems, I don't care further up the stack whether or not
the functionality is implemented in firmware or software, I just care
that I have an interface to use a modem.

So, yes, of course you could configure softvol plugin to do nuts things
in ALSA if you're that way inclined. I don't think anyone who is not
trying to do weird things will do that, however, and I don't know of any
particular h/w that is setup in a weird way by default either.

>> Does any card actually configure softvol, by default, to provide any
>> gain, > 0dB for outputs? If so, then this is IMO a bad idea.
>>
> 
> -51dB to 0dB is also software atten of softvol plugin

So that's not > 0dB then is it?

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
