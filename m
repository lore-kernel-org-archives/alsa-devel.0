From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Multiple Sound Streams out of a single card
Date: Sun, 14 Sep 2003 22:00:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309150200.h8F20m4U011073@oud>
References: <20030915012209.GA9288@ice_nine.wi.rr.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sun, 14 Sep 2003 20:22:09 CDT."
             <20030915012209.GA9288@ice_nine.wi.rr.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: avan@uwm.edu
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  [ dmix ]

>Unfortunately, this doesn't seem to work with some alsa-native apps
>such as mplayer. Something goes wrong when the driver attempts to
>set the software parameters. Are applications supposed to treat plugins
>like dmix differently? I'm completely unable to use xmms with the alsa
>plugin and dmix (with or without mmap mode). (I'm using latest stable,
>not CVS)

apps need have no idea what "type" of PCM device they are using. the
user can freely switch from "hw:0" to "plughw:0" to "dmix:0" etc. and
the app should just work. if it doesn't, its a bug.

>Have I thanked you for JACK lately?

no, but thats OK :)

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
