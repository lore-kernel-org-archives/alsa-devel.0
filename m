From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Mon, 16 Jun 2003 08:01:03 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19Rsag-0004Yb-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.44.0306161315300.11284-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 16 Jun 2003 13:19:20 +0200."
             <Pine.LNX.4.44.0306161315300.11284-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Joern Nettingsmeier <nettings@folkwang-hochschule.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Initial code is in CVS. It is not tested, but hopefully, without any major 
>bugs. It seems that we have also missing encoding of CONTROL14 events.

14 bit MIDI is almost impossible to parse in any sane fashion. if you
read the spec carefully, you'll see that it requires a timeout be
attached to each and every CC message received. why? because of the
order they transmit the low and high nibbles. the basic idea embodied
in the protocol is to send the low byte and then the high byte if *and
only if* necessary. thus, when you receive the low byte, you don't
know if the high byte is coming or not.

its clearly designed for hardware rather than software
implementations, and its really, really ugly.


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
