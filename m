From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: IEEE 1394
Date: Thu, 13 Feb 2003 09:13:00 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18jK76-0008Kj-00@sc8-sf-list1.sourceforge.net>
References: <000201c2d35f$8e128f10$0a0a0a0a@PCOMP>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 13 Feb 2003 14:34:01 +0200."
             <000201c2d35f$8e128f10$0a0a0a0a@PCOMP>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pavel <Pavelni@volny.cz>
Cc: alsa-devel@lists.sourceforge.net, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

>I would like to ask about situation in Linux about one problem.
>Does Linux kernel or Alsa drivers supports IEEE 1394 standart?
>
>If yes, could you recomend me some references and advices to be able to =
>use it
>and program it to create applications with IEEE 1394?
>
>If no, could you recomend me some advices or some documentation to be =
>able
>to create IEEE 1394 driver?

for audio+MIDI, there is no fully-defined standard yet. linux already
has a compliant 1394 driver, but you normally need extra protocols on
top of this for moving specific kinds of data around. IEEE has defined
one (IEC61883-6) for audio+MIDI, based on mLAN, and I believe you can
get the specs from them or the AES.

However, it doesn't support any connection management, so all
endpoints have to be explicitly identified by the user, and everything
has to be explicitly delivered. Yamaha submitted their scheme for CM
to the 1394 trade association as the "AV/C Music Subunit". its been
released but not implemented (even by Yamaha) because Yamaha are
changing mLAN again. Basically, to quote from someone who really knows
this stuff:

  "So a streaming driver using a format compatible with mLAN devices is
   not a problem at this stage - it is possible to direct audio/MIDI to
   mLAN devices and pick up audio and MIDI, but not in a flexible
   manner. The connection management architecture first needs to settle."

--p

ps. just a quick note to point out that whether you know it or not, the
email program you are using is sending out copies of your mail in both
plain text and HTML formats. increasingly on the net, there are
filters being put in place that silently dump HTML-formatted
email. some mailing lists will not ever accept such posts. as long as
you do this, you are (1) wasting network bandwidth by sending messages
that are typically more than twice as long as they could be (2) making
it harder for people using traditional email readers to read them (3)
risking the chance that people will never see your mail because its
filtered before reaching their email inbox.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
