From: Allan Klinbail <allank@labyrinth.net.au>
Subject: mtpav initial test results
Date: 18 Feb 2003 23:47:44 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045572470.2030.24.camel@littlewolf2.littlewolf>
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
To: Alsa-dev <alsa-devel@lists.sourceforge.net>
Cc: tiwai@suse.de, ws@seh.de
List-Id: alsa-devel@alsa-project.org

Hi Guys

Not much time to test tonight (due to a change in shift) but enough for
some initial results and some testing was done late last night 

The system tested is using yesterdays CVS alsa on Mandrake 9.0 using
MusE. 

If two tracks send to the same port when MusE is started the MTP-AV sees
signal from the computer but does not broadcast any data to output
ports. 

When a change is made to anything but the MIDI port selecation (I used
MIDI channel and sync features to check this at least 4 times) broadcast
is sent to all MIDI ports.

This is also true when trying only one track.. a change needs to be made
before the MTP-AV will see anything.. 

When I changed the port output to two separate the results were good and
each output would see the correct MIDI signal.  

MIDI clock seems to work well.

This was demonstrated a few times and is conclusive.. 

SMPTE/MTC sync does not seem to lock, however this was only using MusE
and MusE does not claim to have sync fully implemented yet, so this is
not conclusive.  

Something that happened a couple of times (but I can't nominate what
triggered it) is some ports after initially working then refused to
output. Only turning off the mtpav and starting it again seemed to fix
this. I will test this more tomorrow night. 

I have not yet tested MIDI input.. more soon. 

If anyone else has this device please add further comments. 

I hope this helps 

Allan Klinbail 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
