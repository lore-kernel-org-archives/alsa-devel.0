From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000384]: Crackly PCM output.
Date: Mon, 20 Dec 2004 16:08:53 +0100
Message-ID: <baca07240b2ddacd0fc2033b34ef701a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AEEE32AC
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2004 16:08:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=384> 
======================================================================
Reported By:                bryanb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   384
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo dev sources
Kernel Version:             2.6
======================================================================
Date Submitted:             07-13-2004 19:28 CEST
Last Modified:              12-20-2004 16:08 CET
======================================================================
Summary:                    Crackly PCM output.
Description: 
When playing a sound through the speakers on Toshiba Tecra 8100 the only
sound produced is noise.
======================================================================

----------------------------------------------------------------------
 wallsga - 12-16-04 22:44 
----------------------------------------------------------------------
Update:

When the alsa ymfpci driver initializes so that sound can be heard

 a) both PCM playback and the legacy FM
     synthesizer can both generate audible sound

 b) PCM playback still has a faint "crackle" behind it


When the alsa ymfpci driver initializes so that sound isn't heard,

  a) neither PCM playblack nor legacy FM synth make sound.
  b) PCM playback attempts often generate static & loud crackles.


Any guesses?  Codec initialization problem or YMF744 digital mixer
problem?
Something else?



Lookin at some *BSD code and some AKM documents, the codec on board
the tecra8100, vendor ID AKM5, appears to be an AK4544 (no A suffix),
which was in mass production, but now discontinued by the manufacturer.

The datasheet for the AK4544A says it's vendor ID is AKM6.
The datasheet for the AK4544 is unavailable from the vendor's website.
Hopefully they're close enough.

----------------------------------------------------------------------
 wallsga - 12-20-04 16:08 
----------------------------------------------------------------------
17 Dec 04: Causal relationship found:

During AK4544 AC'97 codec initializaton, by keeping VRA
disabled (and thus also preventing the rate probes),
I was able to have sound on the Tecra 8100 every time
I loaded the alsa-1.0.7 driver.
(Sound quality still seems inferior to OSS, but that's
 another issue)

The attached tecra8100demo.patch will allow others
to verify this.  This demo patch is completely improper
as a long term fix.

The attached archive codec-init-seq.tar.gz has dumps
of the OSS and ALSA drivers' codec initialization
sequences (before applying the demo patch to ALSA).
Please keep in mind that writes to some YMF744
registers also perform codec reads & writes which
aren't logged.


I can only speculate as to what the real problem is:

	- AK4544 is a buggy chip wrt VRA ?
	- AK4544 can handle reads/writes to non-existant regs ?
	- AK4544 needs a more specific sequence to use VRA ?
	- YMF744 provides a BIT_CLOCK to the AK4544 instead
	    of having a crystal (?) and this causes VRA problems ?


TODO (by someone other than me):

	- Get a datasheet for the discontinued AK4544 from AKM
	    (i.e. Register 0x22, 3D Control, seems to differ from the AK4544A)
	- Other tecra8100 or YMF7x4/AK4544 users validate the demo patch.
	- Write a proper fix for ALSA which properly detects and compensates
	    for the AK4544.
	- Figure out how to get VRA working properly with this codec/laptop.
	- Figure out the source of the remaining soft "whistles" and "creaks"
	    that OSS does not seem to exhibit
	- Figure out why the volume seems lower compared to OSS


I am available to beta test full blown proper patches for this problem
with a short (24 hour minimum) turn-around time.

I am not readily available to respond to  "could you try this...?"
requests in a timely manner.  I could barely time find to debug what I
did.

-Andy

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 19:28 bryanb         New Issue                                    
07-13-04 19:28 bryanb         Distribution              => Gentoo dev sources
07-13-04 19:28 bryanb         Kernel Version            => 2.6             
07-29-04 22:43 codefathers    Note Added: 0001485                          
07-29-04 22:45 codefathers    Issue Monitored: codefathers                    
09-03-04 03:37 Derek_Burdick  Issue Monitored: Derek_Burdick                    
09-03-04 03:40 Derek_Burdick  Note Added: 0001684                          
10-23-04 23:24 c0ldevil       Note Added: 0002257                          
10-23-04 23:27 c0ldevil       Note Edited: 0002257                         
10-23-04 23:55 c0ldevil       Note Added: 0002259                          
10-23-04 23:56 c0ldevil       Note Added: 0002260                          
11-10-04 12:48 tiwai          Note Added: 0002369                          
11-17-04 18:14 c0ldevil       Note Added: 0002436                          
11-17-04 20:33 c0ldevil       Note Added: 0002442                          
11-17-04 20:39 rlrevell       Note Added: 0002443                          
11-18-04 14:30 tiwai          Note Added: 0002445                          
11-18-04 15:46 c0ldevil       Note Added: 0002446                          
11-18-04 15:56 c0ldevil       Note Added: 0002447                          
11-18-04 15:59 c0ldevil       File Added: dumps.zip                        
11-18-04 16:00 c0ldevil       Note Added: 0002448                          
11-18-04 19:44 tiwai          Note Added: 0002465                          
11-18-04 21:05 c0ldevil       Note Added: 0002471                          
11-18-04 21:29 c0ldevil       Note Edited: 0002471                         
11-22-04 14:24 wallsga        Note Added: 0002496                          
11-22-04 14:26 wallsga        Note Edited: 0002496                         
11-22-04 14:30 wallsga        Issue Monitored: wallsga                     
11-22-04 14:37 tiwai          Note Added: 0002498                          
11-23-04 16:14 wallsga        File Added: tecra8100-bug-data.tar.gz             
      
11-23-04 16:15 wallsga        Note Added: 0002520                          
12-16-04 22:44 wallsga        Note Added: 0002843                          
12-20-04 16:08 wallsga        Note Added: 0002883                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
