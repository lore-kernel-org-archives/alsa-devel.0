From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: LiveDrive MIDI
Date: Tue, 9 Dec 2003 22:02:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <S19912AbTLIUCX/20031209200223Z+9280@nic.funet.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>From: Eckhard Jokisch <e.jokisch@u-code.de>
>>
>> Now we should look at why LiveDrive "midi-in" does not work.
>
>As far as I remeber it worked half a year ago.. no?

Another person with LiveDrive said it does work, but
it does not work for me. The port works in MS Windows with
the driver:  SB Live! Midi In [C000]

I have Alsa 1.0.0pre3. I tested with
  amidi -d -p hw:0,0
but nothing was read in (hw:0,1 and hw:0,2 were available as
well with the same result; no other devices were available).

Would anyone would like to tell the simplest way to test the
midi-in port? I have "cat /dev/midi"ed for all midi device files
in /dev/ and in /dev/snd/; 58 files in total.

Please no Timidity nor Fluidsynth as they refused to compile.
I have Rosegarden but it did not read midi-in either if
I made the recording correctly (it is too complex program for
a simple testing, IMHO).

Anything which I could try out? I could even add debug
messages to the dirver and re-compile, if that helps the testing.

Regards,
Juhana


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
