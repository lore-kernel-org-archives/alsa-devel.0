From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: possible ALSA bug/feature (was: important recording broke. why?)
 (fwd)
Date: Fri, 21 Mar 2003 16:16:04 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303211610150.20651-100000@vaino.wakkanet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Cc: The Eye <the.eye@gmx.li>
List-Id: alsa-devel@alsa-project.org

Hi,

first please read the mail to ecasound-list below. 

It seems that with newer ALSA versions, snd_pcm_read[in]()  sometimes
returns -EIO even though documentation says nothing about this. After some
testing this seems to not happen on direct hw-access, only with
the pcm_plugin. The EIO comes from snd_pcm_wait(). 

Is this a bug or or a feature?

Btw; the error does not seem to be critical. If I handle
     the EIO the same way as EPIPE (i.e. run xrun 
     handling code), the recording will continue fine.

---------- Forwarded message ----------
Date: Fri, 21 Mar 2003 12:45:53 +0000
From: The Eye <the.eye@gmx.li>
Reply-To: ecasound-list@wakkanet.fi
To: ecasound-list@wakkanet.fi
Subject: [ecasound] important recording broke. why?

Yesterday I had an important recording (a radio-show I did) ... I had it
scheduled via at, the same command I always use, i.e.
ecasound -b:2048 -z:intbuf -z:db,200000 -r -ev -t:8400 -f:s16_le,2,44100 
-i:alsa,default -o:laermraw.raw


OK, this has always worked ... now I read my mails today, and what do I
see in my inbox? the following:
****************************************************************************
*               ecasound v2.2.2-pre1 (C) 1997-2003 Kai Vehmanen                
****************************************************************************
- [ Session created ] ------------------------------------------------------
- [ Chainsetup created (cmdline) ] -----------------------------------------
(eca-chainsetup-parser) Setting buffersize to (samples) 2048.
(eca-chainsetup-parser) Enabling extra buffering on realtime devices.
(eca-chainsetup-parser) Using double-buffer of 200000 sample frames.
(eca-chainsetup) Raised-priority mode enabled. (prio:50)
(eca-chainsetup-parser) Set processing time to 8400.00.
- [ Connecting chainsetup ] ------------------------------------------------
(eca-chainsetup) 'rt' buffering mode selected.
(eca-chainsetup) Audio object "alsa", mode "read".
(audio-io) Format: s16_le, channels 2, srate 44100, interleaved.
(eca-chainsetup) Audio object "laermraw.raw", mode "read/write".
(audio-io) Format: s16_le, channels 2, srate 44100, interleaved.
- [ Chainsetup connected ] -------------------------------------------------
(eca-controller) Connected chainsetup:  "command-line-setup".
- [ Controller/Starting batch processing ] ---------------------------------
- [ Engine init - Driver start ] -------------------------------------------
(eca-engine) Prefilling i/o buffers.
(audioio-alsa) warning! playback overrun - samples lost!  Break was at least 
0.05 ms long.
(audioio-alsa) Read error! Stopping operation.
Warning: DBC_REQUIRE failed - "samples_read >= 0", samplebuffer.cpp, 757.
sh: line 61:  2821 Segmentation fault      ecasound -b:2048 -z:intbuf 
-z:db,200000 -r -ev -t:8400 -f:s16_le,2,44100 -i:alsa,default -o:laermraw.raw



is this a bug? btw this happened after approx. 2 minutes of recording ..

since I myself wasn't present (I was in the studio, doing the radio show
that should have been recorded), the recording is of course lost .. darn!

-- 
Michael Hellwig  aka  The Eye                 olymp.idle.at admin
check out http://homepage.uibk.ac.at/~csaa5128 for gpg public key
        and don't hesitate to look at http://laerm.or.at

--
To unsubscribe send message 'unsubscribe' in the body of the
message to <ecasound-list-request@wakkanet.fi>.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
