From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: [MusE] weird behavior, midi I/O, 0.6.0pre3, current alsa cvs
Date: 14 Nov 2002 19:22:13 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1037330533.32544.635.camel@cmn37.Stanford.EDU>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: muse@seh.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Freshly compiled 0.6.0pre3 on RedHat 8.0. Using current (fresh compile)
alsa CVS and a Midisport 2x2 usb midi interface. This is what happens
(finally found some sequence of events I could repeat!):

- erase previous muse configuration files to start from scratch
- unplug midi interface
- stop alsa
- start alsa
- plug in midi interface, driver gets loaded

BEGIN A
- start "muse -m -M" to see what's going on
- configure midi, select the proper interface, enable REC
- play on keyboard --> stdout shows midi in msgs received
- create a track, arm recording
- play on keyboard --> messages on stdout show midi output errors, midi
output light on hardware interface does not blink:
  MidiAlsaDevice::putEvent(): midi write error, returns -19 expected 28:
No such device
- save configuration (*)
- quit muse
END A

(*) If I do not save the muse configuration and just quit and restart
muse, I get the same result (A) again and again. Now let's see what
happens if I _do_ save the configuration before quitting:

BEGIN B
- start "muse -m -M"
- play on keyboard --> stdout shows midi in msgs
- create a track, arm recording
- play on keyboard --> stdout shows midi in and out msgs, output light
on hardware midi interface blinks (ie: midi is being sent)
- quit muse
END B

So everything seems to be working... but try that again and:

BEGIN C
- start "muse -m -M"
- play on keyboard --> stdout shows midi in msgs
- create a track, arm recording
- play on keyboard --> stdout shows midi in and out msgs, output light
on midi interface DOES NOT blink (but no alsa level errors on stdout)
- open "TrackInfo" panel
- increment OChn to "2"
- play on keyboard --> stdout shows midi in and out msgs, output light
on midi interface BLINKS!
- decrement OChn to "1"
- play on keyboard --> output still working.....
END C

At this point I can repeat C and get the same results (ie: output only
works after I change the output channel). I cannot get back the A or B
behaviors. 

Very confusing...

On one hand Muse is having some issue with the default configuration or
lack of stored configuration. Midi output starts working only after
saving the configuration in Muse. 

But even with the configuration saved the behavior is not consistent.
The first time after doing A (see B) is different from all others (see
C). Can anyone out there make sense of this? Looks like a weird
interaction between alsa and muse (something similar happens with muse
0.5.3b - with the _same_ binary that was working with a previous version
of alsa). 

-- Fernando




-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
