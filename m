From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Sound Going Wrong
Date: Sat, 20 Sep 2003 18:57:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309202257.h8KMvDqJ020301@oud>
References: <01d101c37f7f$982a77c0$0100a8c0@Pblaptop>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 20 Sep 2003 15:00:02 BST."
             <01d101c37f7f$982a77c0$0100a8c0@Pblaptop>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pete Barnard <petebarnard@tiscali.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I have written a sound server using ALSA drivers which samples stereo =
>sound at 16khz and writes each channel to a unix pipe.  I am using a =

  [  ... ]

>Just wondered if anybody had any insight as to what could be happening =
>because I haven't.  And it's difficult to de-bug as the problem occurs =
>so rarely.

1) do you have a low latency kernel? how many channels are you
   capturing? is your process running with regular priority?

2) see jackit.sf.net. the capture client will do what you want, and works
correctly, unlike most other examples of how to record data from an
audio interface.

explaining how to do this right with native ALSA will probably take more
time than to get up and running with JACK :)

--p (an optimist)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
