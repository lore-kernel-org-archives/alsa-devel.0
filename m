From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Mon, 16 Jun 2003 12:28:35 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19RwlY-0001y4-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0306161742010.11284-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 16 Jun 2003 18:03:06 +0200."
             <Pine.LNX.4.44.0306161742010.11284-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: David Olofson <david@olofson.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Yes, Paul mentioned it and I see that the standard is not so good. Does it 
>affect also XRPN encoding (some LSB or MSB bytes might be missing)?
>In that case the current implementation is broken.

now that i think about it, i recall what i realized was the MIDI
spec's intent: you are supposed to be stateful when parsing 14 bit
controls. you always know the most recent MSnibble, and so when the
new LSnibble comes in, you just merge them. libmidi++ does this
already. the problem remains that you can't provide "atomic" access to
the controller state: if it changes so that both the high and low
nibbles need to be transmitted, an application can end up seeing it in
the intermediate, undefined state where the LSnibble has been updated,
but not the MSnibble.

hence the timeouts needed to be able to delay updating the LSnibble so
that you can be sure no pending change to the MSnibble is coming.

--p




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
