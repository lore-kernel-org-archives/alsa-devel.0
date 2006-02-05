From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001819]: Monitor capability feature request
Date: Sun, 5 Feb 2006 04:39:59 +0100
Message-ID: <a5aa214e481c106ef428147f871f2af3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D852519F
	for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2006 04:39:59 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1819> 
======================================================================
Reported By:                djandruczyk
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - lib
Issue ID:                   1819
Category:                   0_general
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             02-04-2006 19:42 CET
Last Modified:              02-05-2006 04:39 CET
======================================================================
Summary:                    Monitor capability feature request
Description: 
 I'd like to suggest a potential feature with the capability of monitoring
ANY pcm output (or combination of simultaneous outputs).  The aim being to
be able to do the following via alsa-lib:

1. record output from arbritrary applications or combination thereof
without requiring any application modification and without looping back
the physical outputs to inputs on the sound hardware (which introduces
noise and unwanted latency and use of a recording source that might
otherwise be in use.
2. perform monitoring of select streams (in the case of multiple pcm
streams running at once)

>From the application's point of view that would want to use this I
envision something along these lines:

- App registers a callback with ALSA-lib to be notified if a new stream is
created or destroyed.
- App then queries alsa lib for a current list of running streams (whether
to physical devices or streams feeding into dmix)
- App requests a "monitor connection" to a stream or combination of
streams and registers a callback function to be called anytime this stream
is upated from an application (limitation in that all streams requested
share same SW params for simplicity)  This should be flexible in the case
of dmix to be able to monitor 1 feed  up to n feeds where n being the max
number of streams that dmix is handling concurrently. The monitored
connection will have a total number of channels equal to the sum of
monitored channels selected.  
for example: lets say dmix is multiplexing 3 applications to one physical
hw:0 device.  the monitor requests 2 out of those three (for wahtever
reason, it doesn't matter) The monitor callback should deliver the data to
the callback as a 4 channel stream in the format of:
 L (stream 1),R(stream 1), L(Stream 2), R(stram2) (interleaved).  The
restriction being that the SW params of the streams that are to be
monitored must all match, otherwise it would become very difficult to
calculate and handle all the possible permutations of handling mixmatched
streams.

- App's callback function is called each time the outside application
issues a write to ALSA lib and is able to monitor the audio stream from
said app in realtime.  If outside application closes, the notification
callback will be called and the app monitoring the stream will gracefully
handle the event, deregister the monitor callbacks, and if wanted,
re-query also lib for current streams and connect to another.

Potential issues:
  This would ONLY work for applications using the ALSA lib library and PCM
plugins plughw, dmix, etc.  It would (probably) NOT function for direct
access, to hw:0 (thought it may be implementable, I don't know enough of
ALSA internals to know if it would be possible). It most definitely would
not work for things that mmap the sound device buffer directly, but I
would guess that a large portion of applications do not use that method.
(though I may be wrong and would appreciate a correction if I am so)

======================================================================

----------------------------------------------------------------------
 djandruczyk - 02-04-06 20:58 
----------------------------------------------------------------------
jack isn't necessarily a solution as there are many apps that DO NOT WORK
with jack, and in some cases the application may not have source
availablity for modification.

I've looked into the file plugin but it hasn't worked well, and was next
to impossible to use in an interactive form. (realtime)  My primary
motivation for this ability is to be able to monitor/analyze audio streams
in realtime without having to modify any of the apps that may be monitored
(as in some cases they can't). (jack==not all apps work, esd==ick!,
arts==uggh!)

----------------------------------------------------------------------
 Raymond - 02-05-06 04:39 
----------------------------------------------------------------------
Can those sound cards which support hardware mixing use the hardware mixer
to record all the playback ?

Is it feasible to create a virtual pcm catpure device for those sound card
to capture the playback ?

The 8/16 bits audio is already resampled to 48000 Hz by the hardware
sample rate convertor before sending to AC97 codec.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-04-06 19:42 djandruczyk    New Issue                                    
02-04-06 19:53 rlrevell       Status                   new => resolved     
02-04-06 19:53 rlrevell       Resolution               open => fixed       
02-04-06 19:53 rlrevell       Assigned To               => rlrevell        
02-04-06 19:53 rlrevell       Note Added: 0007921                          
02-04-06 20:22 perex          Note Added: 0007923                          
02-04-06 20:58 djandruczyk    Status                   resolved => feedback
02-04-06 20:58 djandruczyk    Resolution               fixed => reopened   
02-04-06 20:58 djandruczyk    Note Added: 0007926                          
02-05-06 04:39 Raymond        Note Added: 0007928                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
