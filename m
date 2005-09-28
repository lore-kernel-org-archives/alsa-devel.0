From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001251]: emagic a62m: maybe bug: arecord doesn't record anything, jack+jackrec work
Date: Wed, 28 Sep 2005 13:21:06 +0200
Message-ID: <dd876eecf841312bc0d8edccba089944@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5A801177
	for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2005 13:21:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1251> 
======================================================================
Reported By:                Robert_Schulze
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1251
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-11-2005 14:39 CEST
Last Modified:              09-28-2005 13:21 CEST
======================================================================
Summary:                    emagic a62m: maybe bug: arecord doesn't record
anything, jack+jackrec work
Description: 
When I want to record something from my emi a62m audiointerface, arecord
doesn't work:

"arecord -D emi -f cd > test.wav"
when issuing "aplay -vvv test.wav", the histogram shows up a permanent
peak of 36% during the whole file, no sound hearable.

Starting "jackd -d alsa -D emi" and issuing "jackrec -f test.wav -d 5
alsa_pcm:capture_1 alsa_pcm:capture_2" does record a valid file.

.asoundrc:

pcm.emi 
 {
 type hw
 card 1 
 }

ctl.emi
 {
 type hw
 card 1
 }

Card 0 is a solo1.
======================================================================

----------------------------------------------------------------------
 Robert_Schulze - 07-19-05 17:32 
----------------------------------------------------------------------
xxd -g1 test_2_24_98.wav:

0000000: 52 49 46 46 a0 3b 48 00 57 41 56 45 66 6d 74 20  RIFF.;H.WAVEfmt
0000010: 10 00 00 00 01 00 02 00 00 77 01 00 00 ca 08 00 
.........w......
0000020: 06 00 18 00 64 61 74 61 7c 3b 48 00 5f 5f 5f 5f 
....data|;H.____
0000030: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000040: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000050: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000060: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000070: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000080: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000090: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________

xxd -g1 test_6_16_48.wav:

0000000: 52 49 46 46 1c 7f 10 00 57 41 56 45 66 6d 74 20  RIFF....WAVEfmt
0000010: 10 00 00 00 01 00 06 00 80 bb 00 00 00 ca 08 00 
................
0000020: 0c 00 10 00 64 61 74 61 f8 7e 10 00 5f 5f 5f 5f 
....data.~..____
0000030: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000040: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000050: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000060: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000070: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000080: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000090: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________

xxd -g1 test_6_24_48.wav:
0000000: 52 49 46 46 20 38 80 00 57 41 56 45 66 6d 74 20  RIFF 8..WAVEfmt
0000010: 10 00 00 00 01 00 06 00 80 bb 00 00 00 2f 0d 00 
............./..
0000020: 12 00 18 00 64 61 74 61 fc 37 80 00 5f 5f 5f 5f 
....data.7..____
0000030: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000040: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000050: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000060: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000070: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000080: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________
0000090: 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 5f 
________________

The other two don't also work:

xxd -g1 test_2_16_48.wav:

0000000: 52 49 46 46 24 00 13 00 57 41 56 45 66 6d 74 20  RIFF$...WAVEfmt
0000010: 10 00 00 00 01 00 02 00 80 bb 00 00 00 ee 02 00 
................
0000020: 04 00 10 00 64 61 74 61 00 00 13 00 2f 2f 2f 2f 
....data....////
0000030: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000040: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000050: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000060: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000070: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000080: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000090: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////

xxd -g1 test_2_24_48.wav:

0000000: 52 49 46 46 ac 7e 17 00 57 41 56 45 66 6d 74 20  RIFF.~..WAVEfmt
0000010: 10 00 00 00 01 00 02 00 80 bb 00 00 00 65 04 00 
.............e..
0000020: 06 00 18 00 64 61 74 61 88 7e 17 00 2f 2f 2f 2f 
....data.~..////
0000030: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000040: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000050: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000060: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000070: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000080: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////
0000090: 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 2f 
////////////////


I noticed one more thing:

If I call:
> arecord -D emi -f cd | tee test.wav | aplay -D emi
the file "test.wav" contains valid recording data!

----------------------------------------------------------------------
 Robert_Schulze - 09-28-05 13:21 
----------------------------------------------------------------------
Could you already figure out, what's going wrong?
It seems to be a reasonable easy solution to open the device reading _and_
writing (capture + playback), while recording. Is it possible to simulate
that via a .asoundrc-file?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-11-05 14:39 Robert_Schulze New Issue                                    
07-11-05 16:20 Clemens LadischNote Added: 0005448                          
07-12-05 11:57 Robert_Schulze Note Added: 0005452                          
07-12-05 12:52 Clemens LadischNote Added: 0005453                          
07-12-05 17:29 Robert_Schulze Note Added: 0005456                          
07-14-05 11:02 Clemens LadischNote Added: 0005469                          
07-14-05 11:06 Robert_Schulze Note Added: 0005470                          
07-14-05 17:06 Robert_Schulze Note Added: 0005476                          
07-14-05 18:04 Clemens LadischNote Added: 0005478                          
07-19-05 17:32 Robert_Schulze Note Added: 0005529                          
09-28-05 13:21 Robert_Schulze Note Added: 0006410                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
