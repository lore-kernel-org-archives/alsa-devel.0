From: Paul Davis <paul@linuxaudiosystems.com>
Subject: MIDI port names
Date: Wed, 19 Feb 2003 07:40:06 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302191240.h1JCe6A18300@linuxaudiosystems.com>
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

a few days ago i told mark knecht that i would change the name of the
ports that show up under the sequencer that correspond to the
Hammerfall MIDI ports.

in looking at the code, i now realize i have no idea how to do this,
since the port names are set up (AFAICT) by the module that maps
rawmidi ports to the sequencer API and vice versa. 

however, the midisport 2x2 seems to be able to do this. can i get a
pointer on how its done? or better yet, can we form all the port names
in a consistent way, such as card->shortname + " port " + N ?

--p



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
