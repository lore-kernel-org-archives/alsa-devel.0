From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001618]: No Sound on Acer with Intel ICH6 HDA and Realtek ALC260
Date: Sat, 18 Feb 2006 23:48:45 +0100
Message-ID: <425d45ff0c89ab761182a85f1397b729@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C511B1B7
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2006 23:48:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1618> 
======================================================================
Reported By:                robertw
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1618
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu 5.10
Kernel Version:             2.6.12-10-686
======================================================================
Date Submitted:             12-04-2005 21:24 CET
Last Modified:              02-18-2006 23:48 CET
======================================================================
Summary:                    No Sound on Acer with Intel ICH6 HDA and Realtek
ALC260
Description: 
I can load the snd-hda-intel module and play a file via aplay or xmms or
play a cd without any error, but I cannot hear anything neither via the
build-in speakers nor via headphones. All volume controllers are at 70%
and unmuted, except for PCM, because there is no mute/unmute-button.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001517 No sound on hda-intel on Acer TravelMat...
======================================================================

----------------------------------------------------------------------
 jwoithe - 02-14-06 00:07 
----------------------------------------------------------------------
Er-ku: to answer your latest questions.

The reason the ALC260 "test" model is a debug feature is simple: the
existing ALC880 "test" model is a debug feature and I figured there must
have been a reason for that.  I don't know what that reason is, and it is
possible that one could make an argument that both the ALC260 and the
ALC880 test models should always be compiled in.  That decision however is
up to the maintainers (Takashi probably).  I would support any moves to
make these models always available, but I didn't feel it was my right to
make such a call as part of the ALC260 test model patch.

As far as enabling debug mode in a non-distributor ALSA, the steps I would
try are as follows.

 1) get the new ALSA driver source package (either a release tarball or
from     
    CVS), unpack it as appropriate and change into its top-level
directory.

 2) use options to ./configure to activate debug mode:
      ./configure --with-debug=full
    should work (I *think* "full" turns on CONFIG_SND_DEBUG)

 3) run "make" to build the new driver.  Then as root do "make install".

The last part of step 3 should replace your vendor-supplied ALSA modules
with those you've just compiled.  Then either reload ALSA (using whatever
scripts are provided by your distro, or by hand) or reboot to activate
those new modules.

Note that all this is from memory; others should feel free to correct if
I've made any glaring errors or omissions. :)

----------------------------------------------------------------------
 AndyP - 02-18-06 23:48 
----------------------------------------------------------------------
I have just downloaded the cvs version of alsa drivers, alsa lib, alsa
utils and built the drivers with debug enabled. When using the model=test
option I can now get sound from the line-out socket on the front of the
notebook as well as input from the micophone. Still can't get anything
from the headphone socket or from the builtin speakers. My notebook (Acer
Aspire 1642WLMi) is identified as subsystem id 1025-160d by the Realtek
ALC260 codec. 
The following was noticed from running the test option.

ALC260 Mixer Setup --Test
PCM			No Effect
CD			No Effect
Mono			No Effect
Beep			No Effect
HP-Out loopback		No Effect
HP-Out pin mode 	No Effect
Input Source 		No Effect
Input Source 1 		No Effect
LINE-OUT loopback 	No Effect
LINE-OUT pin mode 	No Effect
LINE1			No Effect
LINE1 pin mode		Line out Output through Line out. 
                        Headphone Output through Headphone output is
tinny
LINE2			No Effect
LINE2 pin mode		Headphone Cuts Treble through Line out, others no effect
LOUT1			Controls Volume on Line Out
LOUT2			No Effect
MIC1			Internal/Ext MIC Volume
MIC1 pin		Mic 80pc bias or Mic 50pc bias both allow mic input
MIC2			No Effect
MIC2 pin		No Effect
Is there anything else I can try in order to get output through the
speakers or the headphone socket ? Also, I can't hear anything when
playing CD's.

I also get the following error message when using Alsaplayer ? Is this
part of the problem in not getting output ? Any suggestios welcome.


/usr/lib/alsaplayer/output/libalsa_out.so: symbol
snd_pcm_hw_params_set_periods_near, version ALSA_0.9.0rc4 not defined in
file libasound.so.2 with link time reference


I could not find a suitable output module on your
system. Make sure they're in "/usr/lib/alsaplayer/output/".
Use the -o parameter to select one.

Failed to load output plugin "alsa". Trying defaults.
/usr/lib/alsaplayer/output/libalsa_out.so: symbol
snd_pcm_hw_params_set_periods_near, version ALSA_0.9.0rc4 not defined in
file libasound.so.2 with link time reference


Thanks
  AndyP

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-05 21:24 robertw        New Issue                                    
12-04-05 21:24 robertw        Distribution              => Ubuntu 5.10     
12-04-05 21:24 robertw        Kernel Version            => 2.6.12-10-686   
12-05-05 07:12 jwoithe        Note Added: 0006908                          
12-05-05 19:35 timmy          Note Added: 0006914                          
12-06-05 15:52 tiwai          Note Added: 0006925                          
12-06-05 18:10 robertw        Note Added: 0006930                          
12-06-05 20:07 tiwai          Note Added: 0006934                          
12-06-05 20:08 tiwai          File Added: alc-cvs-fix.diff                    
12-06-05 20:09 tiwai          Note Added: 0006935                          
12-06-05 22:51 robertw        Note Added: 0006938                          
12-07-05 14:59 tiwai          Note Added: 0006941                          
12-07-05 15:00 tiwai          File Added: alc-cvs-fix2.diff                    
12-07-05 23:10 robertw        Note Added: 0006952                          
12-08-05 17:19 tiwai          Note Added: 0006957                          
12-08-05 22:01 robertw        File Added: codec#0                          
12-08-05 22:02 robertw        File Added: codec#1                          
12-08-05 22:03 robertw        File Added: asound.state                     
12-08-05 22:05 robertw        Note Added: 0006963                          
12-09-05 15:09 tiwai          Note Added: 0006966                          
12-09-05 16:35 robertw        Note Added: 0006967                          
12-09-05 17:03 tiwai          Note Added: 0006969                          
12-09-05 17:17 robertw        Note Added: 0006970                          
12-14-05 13:22 mytux          Issue Monitored: mytux                       
12-19-05 02:11 rlrevell       Note Added: 0007077                          
01-02-06 21:55 robertw        Note Added: 0007391                          
01-04-06 17:29 tiwai          Note Added: 0007441                          
01-04-06 22:00 robertw        Note Added: 0007453                          
01-04-06 22:16 robertw        Note Edited: 0007453                         
01-11-06 23:38 lobstaj        Note Added: 0007572                          
01-11-06 23:48 rlrevell       Note Added: 0007573                          
01-12-06 00:20 lobstaj        Note Added: 0007575                          
01-12-06 00:26 rlrevell       Note Added: 0007576                          
01-12-06 01:16 mytux          Note Added: 0007577                          
01-12-06 01:20 mytux          Note Edited: 0007577                         
01-12-06 14:13 robertw        Note Added: 0007586                          
01-12-06 14:43 lobstaj        Note Added: 0007587                          
01-12-06 16:45 eudoxos        Issue Monitored: eudoxos                     
01-12-06 21:04 rlrevell       Note Added: 0007591                          
01-13-06 01:11 rlrevell       Relationship added       duplicate of 0001517
01-13-06 08:03 eudoxos        Note Added: 0007631                          
01-13-06 11:30 er-ku          Issue Monitored: er-ku                       
01-16-06 00:32 jwoithe        Note Added: 0007682                          
01-17-06 23:32 ilovetronik    Issue Monitored: ilovetronik                    
01-19-06 23:36 ajmitch        Issue Monitored: ajmitch                     
02-08-06 14:46 svilen         Note Added: 0007965                          
02-09-06 00:29 jwoithe        Note Added: 0007969                          
02-09-06 09:04 hweigel        Issue Monitored: hweigel                     
02-10-06 11:02 svilen         Note Added: 0007999                          
02-12-06 21:42 AndyP          Note Added: 0008031                          
02-12-06 22:11 wattazoum      Note Added: 0008032                          
02-12-06 22:14 rlrevell       Note Added: 0008033                          
02-12-06 23:05 er-ku          Note Added: 0008034                          
02-12-06 23:07 er-ku          Note Edited: 0008034                         
02-13-06 00:45 jwoithe        Note Added: 0008035                          
02-13-06 06:42 er-ku          Note Added: 0008037                          
02-13-06 06:43 er-ku          Note Edited: 0008037                         
02-14-06 00:07 jwoithe        Note Added: 0008066                          
02-18-06 23:48 AndyP          Note Added: 0008125                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
