From: "David Sattler" <davidmindslip@hotmail.com>
Subject: Strange SPDIF problems on SBLive! and HDA-Intel - No fix found yet!
Date: Mon, 21 Feb 2005 17:05:30 -0500
Message-ID: <BAY15-F391F76A381EF7A41EACFD2B9610@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: alsa-devel-admin@lists.sourceforge.net
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

	From: 	  davidmindslip@hotmail.com
	Subject: 	SPDIF problems w/ SBLive! & hda-intel - No fix found yet...
	Date: 	February 21, 2005 4:53:48 PM EST
	To: 	  alsa-devel@lists.sourceforge.net

Hi all,

I know this is a question that's supposedly been fixed long ago, but I'm 
seeing problems with 1.0.8 and with CVS (even up to today, which should have 
an SPDIF patch for hda-intel) so I'll ask it again, hoping I don't get 
ignored or such!

Problem: Feeding .wav files to SPDIF on SBLive! has various results

Command:
	aplay -D "plug:spdif" -f cd file.wav
Result:
	Stutter... stutter.. stutter... stutter... stutter... of the first 1/2 
second over and over again....

Command:
	aplay -D "spdif" -f cd file.wav
(note not plug:spdif)
Result:
	Hear the file sped-up to 48KHz instead at the normal 44.1KHz pitch

Note: Both commands fail the same way regardless of -f dat or -f cd

Command:
	aplay -D "hw:0,0" -f cd file.wav
Result:
	Same as "-D spdif" -- too fast

Command:
	aplay -D "hw:0,1" -f cd file.wav
Result:
	aplay: main:508: audio open error: No such file or directory

Summary:
	Nothing lets me play a wav file properly through SPDIF on the SBLive!


Problem: Feeding AC3 or DTS to SBLive! results in amp playing static (not 
recognizing AC3-ishness of data)

Command:
	aplay -D "plug:spdif" -f <dat|cd> <dts.file|ac3.file>
Result:
	With amp in DTS or Dolby Digital mode: no sound
	With amp in Stereo PCM mode: undecoded garbage

Summary:
	Nothing lets me play a DTS or AC3 file properly through SPDIF on SBLive! 
(note, this is a very high-end decoder)


Problem: Nothing lets me use the SPDIF of my hda-intel (Asus P5GD1 
motherboard)

Command:
	aplay -D "plug:spdif" whatever...
Result:
	ALSA lib setup.c:548:(add_elem) Cannot obtain info for CTL elem 
(MIXER,'IEC958 Playback Default',0,0,0): No such file or directory
	aplay: main:508: audio open error: No such file or directory

Command:
	aplay -D "hw:0,0" whatever....
Result:
	Front speakers... good sound

Command:
	aplay -D "hw:0,1" <0,2 0,3 etc.>
Result:
	aplay: main:508: audio open error: No such file or directory

Also, I notice that in alsamixer I don't get anything referring to SPDIF, 
IEC, Digital, etc.


PLEASE (Takashi, I beg you!) I don't care which card I manage to get 
working, but I've been through lists and trial/error and hacking for days 
with no success. I'm *more* than happy to help debug, I've got the equipment 
at my disposal as well as the time.

ANY hints, either via list or personally at davidmindslip@hotmail.com would 
be *greatly* appreciated!

Many thanks,
David.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
