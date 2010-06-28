From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: wrong decibel data?
Date: Mon, 28 Jun 2010 09:18:29 +0100
Message-ID: <i09lsl$le$1@dough.gmane.org>
References: <htls4d$phr$1@dough.gmane.org>
	<huicj9$t30$1@dough.gmane.org>	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>	<hulnlp$m00$1@dough.gmane.org>	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>	<hur2pt$uaa$1@dough.gmane.org>	<20100613135349.GB5818@tango.0pointer.de>	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>	<hv4pfi$gqr$3@dough.gmane.org>	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>	<hv4vs6$a6q$1@dough.gmane.org>	<AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>	<AANLkTimxTM73el7iCE6nwUJMPFpYa0dY2R9SYxa3_j6N@mail.gmail.com>	<hv5dkf$tv8$1@dough.gmane.org>	<AANLkTim5rmjxS6YV7j3QEXSW-EyUv2rsT3k2ZzOz-o9o@mail.gmail.com>	<hvput5$a6o$1@dough.gmane.org>	<AANLkTilwbCSM7rPLUlAKtTUv1UepbHzvyZTh4CsElOJm@mail.gmail.com>	<hvqqf9$p3j$1@dough.gmane.org>	<AANL
 kTim8KsRcWcg3lkqb8RZqhPT_Bp53dwwlQ3ccay1L@mail.gmail.com>	<hvsj32$6cm$1@dough.gmane.org>
	<AANLkTikj8_3oYu4ERIGHVhlbFKCVQW4P6PCENqblLWgh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 17E6E24694
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 10:18:44 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OT9Y9-0000uP-Be
	for alsa-devel@alsa-project.org; Mon, 28 Jun 2010 10:18:41 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2010 10:18:41 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2010 10:18:41 +0200
In-Reply-To: <AANLkTikj8_3oYu4ERIGHVhlbFKCVQW4P6PCENqblLWgh@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 28/06/10 02:47 did gyre and gimble:
> 2010/6/23 Colin Guthrie <gmane@colin.guthr.ie>
>> I can't speak for him with regards to the full setup of the mixer path
>> probing stuff, so perhaps "front" should be edited out of this for
>> paths. It would likely be a fairly trivial change to configuration files
>> rather than any code changes.
>>
>>
> Well , He had already hardcoded to use "hw:card_number" in dbverify.c , it
> is only PA server still try to open mixer device "front"

Yeah dbverify is a very simple tool that doesn't really warrant an
advanced interface. There may be other reasons to use hw: directly too.


> The tooltip of gnome volume control in Fedora 13 clearly indiacte that 100%
> is 0dB for intel8x0 which use ac97 codec  when you put the cursor on top of
> the speaker icon at the system bar
> 
> https://bugzilla.gnome.org/show_bug.cgi?id=618551
> 
> according to gnome-media-developer  Bastien Nocera
> 
> In any case, we only display what PulseAudio tells us, so you should poke the
> PulseAudio devs about this.
> 
> This is the code in question:
> gdouble
> gvc_mixer_stream_get_decibel (GvcMixerStream *stream)
> {
>         g_return_val_if_fail (GVC_IS_MIXER_STREAM (stream), 0);
> 
>         return pa_sw_volume_to_dB(
>                         (pa_volume_t)
> gvc_channel_map_get_volume(stream->priv->channel_map)[VOLUME]);
> }
> 
> 
> 
> if you don't have any ac97 sound card , you can user virtualbox which has an
> emulated intel8x0 sound card

Dude, we've talked about this already. The PA server applies no software
amplification and has set the controls provided by ALSA to their
maximum, which we call 0dB.

This approach allows us to fit in with a slider system that has 0dB at
it's top end and we can also show the ALSA 0dB point as the "Base
Volume" in our UIs.

Now you could argue (which you obviously are) that the dB of the
underlying card should still be exposed in the purest sense, but that
does make for more complicated calculations and confusing repercussions
elsewhere, including the mapping from percentage to dB not being
consistent (e.g. sometimes 100% is 0dB, sometimes it's 12dB etc.).

You could also argue that any controls that go >0dB should just be
ignored by PA - i.e. we never control the mixers in a way that would go
over 0dB unless we're going above our 100%. That may be a more valid
approach, but it needs a standard way to represent volumes >100% which
would then fall into the zone of influence of your other current
bugbear: the range checking thing in alsa-lib/alsamixer. Ultimately this
boils down to the fact that the 0dB point in some alsa mixers is located
at a random percentage < 100%. This is fundamentally the problem we are
trying to combat and make it clear to the user where that point is.


So as I've said before, the current approach is IMO the best way to fit
in with the semantics currently available. If you change those semantics
and provide mechanisms to represent a tri-range (min, 100%/0dB, max)
then we could probably adjust to fit in with those semantics. But none
currently exist. So we'll stick with how it's done now for the time being.


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
