From: Ivan Middleton <ivan_middleton@yahoo.com>
Subject: problems with external MIDI port
Date: Wed, 18 Sep 2002 14:10:19 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020918211019.55831.qmail@web13408.mail.yahoo.com>
Reply-To: ivan_middleton@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi all,

I'm having a problem with the ALSA sequencer.  First I was using
0.9.0rc2, and then I switched to cvs, hoping that things would be fixed
there.  But alas, the problems occur in both.  I was going to try the
0.5 release, but it didn't want to compile for me.

The problem is as follows: I am running a program (called Linux Pipe
Organ) which reads from the external MIDI port (64:0) via an ALSA
sequencer connection, and which also starts a TiMidity process and
sends events to it via ALSA sequencer connections.  (Basically, the
program is just relaying MIDI events, after some modifications.)  This
works fine for a few minutes, and then suddenly... nothing.  The ALSA
sequencer stops relaying events from the external MIDI port.  Now, my
digital piano is connected to the MIDI port, and it sends something
like 30 MIDI events per second (I don't know exactly what these are)
even when no keys are being pressed.  The problem I just described
occurs even if I never press any keys on the piano; I can tell by
watching /proc/asound/seq/clients, looking at the following lines

Client 132 : "Linux Organ" [User]
  Port   0 : "Linux Organ" (rWe-)
    Connected From: 64:0
  Input pool :
    Pool size          : 200
    Cells in use       : 0
    Peak cells in use  : 30
    Alloc success      : 27513
    Alloc failures     : 0

and noticing that after a while the "Alloc success" number stops
changing (when everything is working it goes up by about 30 every
second).

Now, I wanted to test whether this problem is the fault of Linux Pipe
Organ (hereafter LPO) or the ALSA sequencer.  So I recompiled LPO to
have it listen to T. Iwai's Virtual Keyboard instead of the external
MIDI port.  I then ran those programs, while simultaneously having
'aseqview' listen to 64:0 (the external MIDI port).  The same thing
happened again--after a little while, 'aseqview' stopped registering
anything from the MIDI port, even though LPO, Virtual Keyboard, and
TiMidity hadn't been communicating at all, only sitting there with
established connections.  After this, LPO was still listening to the
Virtual Keyboard just fine, meaning that the ALSA sequencer wasn't
completely trashed or anything.  When I had 'aseqview' listen to 64:0
in the absence of LPO, it seemed to work fine indefinitely.

So it seems that the ALSA sequencer has problems with the external MIDI
port in the presence of too many sequencer clients (8-10 in my
situation).  I really have no idea what's going on here.  I should
mention that my kernel is 2.5.33 and my sound card is sbawe.  Another
funny thing I found was that in order to get the external MIDI port
working again, I had to unload and reload the ALSA modules *twice* (I
think this was the case every time, anyway).

I'm hoping that the developers can reproduce this or at least have
ideas for things I should try in order to probe this problem some more.

Thanks for your time,
Ivan Middleton


__________________________________________________
Do you Yahoo!?
Yahoo! News - Today's headlines
http://news.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
