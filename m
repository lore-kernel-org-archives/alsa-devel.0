From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000384]: Crackly PCM output.
Date: Thu, 16 Dec 2004 22:44:18 +0100
Message-ID: <062b18e65be3e48e7587a468b4c72a9a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 34A49251
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 22:44:22 +0100 (MET)
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
Last Modified:              12-16-2004 22:44 CET
======================================================================
Summary:                    Crackly PCM output.
Description: 
When playing a sound through the speakers on Toshiba Tecra 8100 the only
sound produced is noise.
======================================================================

----------------------------------------------------------------------
 wallsga - 11-23-04 16:15 
----------------------------------------------------------------------
Attaching file tecra8100-bug-data.tar.gz.

In the following note

"working" means "pcm playback of a .wav file through 
                 the Tecra8100's built-in speakers is
                 acceptable to the human ear"

"oss driver" means "the yfmpci driver supplied with the
                    Redhat 9.0/linux-2.4.20-8 distribution"

"alsa driver" means "the snd-ymfpci driver and supporting
                     modules provided by alsa-drivers-1.0.7"


1) In the uploaded archive, "lspci.oss" and "lspci.alsa" give
the "lspci -xxxvv" dumps with the oss and alsa driver loaded
respectively.  The alsa driver was not working at this time.
Note the "Legacy Audio Control" PCI Configuration Register (0x40-0x41)
is different.  OSS leaves it at the chipset default (0x907f), alsa
zeros it.

I modified my alsa driver to write the "old_legacy_ctrl" value
back to this register right after reading it, instead of writing
"legacy_ctrl" to the register.  As I expected, it had no effect
on the problem.

In other "lspci" output in the archive, you will notice this change
in my alsa driver's behavior.


2) I conclude that loading & unloading the oss driver before the 
alsa driver is not a work-around, simply a superstition.  It seems to
have no bearing on whether the alsa driver will work.

The only method that I came up with to get the alsa driver working
properly
was to repeat the following sequence until the sound was acceptable:

  rmmod `lsmod | awk '/^snd/ {print $1}' | grep -v page`
  rmmod soundcore
  modprobe snd-card-0
  /bin/aumix-minimal -f /etc/.aumixrc -L
  aplay /usr/share/sounds/(somefile).wav

As a guess, the alsa driver worked properly in less than < 10% of the
load attempts.

This type of response indicates an uninitialized variable problem to
me.  But that may not jibe with being a Tecra8100 specific problem.
(I suggest that we reconsider if this is a Tecra8100 only problem.)


3) The oss driver *always* works.


4) Diffs of /proc/asound/card0/codec97#0/* and lscpi output between 
alsa working and alsa not working yield zero differences.


5) Diffs of /proc/asound/card0/ymfpci between alsa working and alsa
not working sometimes show differences to register 0x60 and the one that
follows (AC97CMDDATA and AC97CMDADDR, IIRC), sometimes show differences
to the last four registers (PLAYBACKCTRLADDR, EFFECTSCTRLADDR,
RECORDCTRLADDR,
& WORKBASE, IIRC), and sometimes show differences to both sets.

I modified my oss driver to dump the values for the
last four registers as it loaded them.  OSS would work using the same
values in the last four registers as a non-working alsa driver load.
A working alsa driver load and a non-working alsa driver load could use 
the same values in the last four registers.


6) Added mdelay(20) to the alsa driver after the image load (in addition
to the udelay(100)) just like the oss driver.  This had no effect.


7) Watching /proc/interrupts and (a)play-ing a particular wave file:

   - oss driver always used 51 interrupts
   - non-working alsa driver load always used 74(? IIRC) interrupts
   - non-working alsa driver load oss-emulation always used 67 (? IIRC)
        interrupts


That's as much as I can do on this problem until 01 Dec.  
I'd really like to get rosegarden working on this laptop.  I hope this
helps.


-Andy

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
