From: Erik =?ISO-8859-1?Q?G=FCnther?= <erikg@bokus.com>
Subject: ALSA Configuration program
Date: 14 Oct 2002 23:34:37 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1034638477.2263.62.camel@cool.homelan.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, I'm farly new to ALSA I would like to have a simple but advanced GUI
mix/configuration program. This program should be for (l)users like me
that only wonts play around a bit with his/hers sound system but don't
wont to the extreme things that you can do with ALSA. 

My problem is that I have a 4-channel sound card (SB Live!) and 4
speakers. I get the front and rear to work as expected but I don't have
a master volume (only the front are affected by master volume) nor do I
get the mute correctly (the rear speakers  don't get killed). I don't
expect you to fix my problem here but I would like a mixer/config GUI. 

This GUI should have: 

* A interface where you can virtually connect the different speakers to
different output channels. This should be done with mouse drag and drop
style. This GUI are for moving speakers left to right or front to rear
in any configuration. The GUI should play music in the speaker that are
currently being connected. 

* An interface to virtually palace the speakers in a virtually room.
(This room don't have to be more then a square, but I feater versions
this could also be configurable) The exact position aren't that
important (see below). The GUI should play music in the speaker that are
currently being moved. 

* In the virtual room mentioned above the user should place him/her self
and when moving the user the center of the music are also moved. The GUI
should indicate with regular wave pattens from each speaker have much of
its effect it is using. 

* In the same way as above for the bass and treble. This I'm not shore
about I'm no sound expert so configuring bass and treble in this way
might be totally wrong. It might have to be adjusted in more 3D-way. My
idea for configuring bass and treble are that it should be configured in
about the same way as from alpha-channels in a picture.   

* There should be a command line options to the mix/config program for
use for special keys from the keyboard. The functions that are
interesting here are master volume and mute. (The most common keys on
keyboard to day). It would be nice to actually connect the keys to
functions inside the GUI. But then the GUI has to talk to the WM in some
way... 

If there are other features that are easy to understand in ALSA with a
GUI and reasonable used by common users then they should also be added. 

Most of the features mentioned above are probably all ready implemented
in one or more GUI:s but most mixers just have bars for control. I would
like to have a mixer/config program that combines several common parts
to a more integrated and advanced functions. 

There are most certainly many thing that I have missed and some are far
more complex then I thing they are. And to that I can only say one
thing. You are the experts if anyone can make this work you are. 



/erikg - have no time to do this I'm a (l)user ;)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
