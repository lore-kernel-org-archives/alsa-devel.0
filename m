From: Dan Tihelka <dtihelka@kky.zcu.cz>
Subject: Build-in mixer
Date: Wed, 08 Oct 2003 10:24:24 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F83C9B8.9050407@kky.zcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo every great ALSA developers,



I have one question. Is audio stream mixer planned or build in in ALSA, 
to be able to use different programs with audio output together? Like a 
case when i'm playing a movie (e.g. via mplayer with ALSA support) and i 
really want to listen an ICQ or  mail confirmation sounds (because i'm 
expecting wery important message).

I don't know, if the term "mixer" is used correctly, because i am not 
expert on it. I have in mind to use ALSA by more than one programs at 
the same time (simultaneously), and ALSA itself should mix these audio 
streams to one and play it via soundcard.


I tried dmix plug-in together with aplay -Dplug:dmix simultaneously from 
  two consoles and it works sufficiently (well, "underun!!! (at least 
...ms long)" message was there but i don't know, if is is serious bug or 
not). I thing that it should work transparently without special swithes 
or settings separately for each application or its instance, but i don't 
know if it is possible or not.


If some cards are able to do it by their hardware (are there such 
cards?) the mixer would not be used, in other cases it should be used 
automatically, and ALSA knows if to use it or not according to used 
sound card. Then ALSA would be KDE/Gnome/and_others independent and all 
applications supporting it (or supporting OSS) would be able to play 
simultaneously.


I wish you a lot of sucessful work,

Dan










-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
