From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000717]: MIDI input does not generate interrupts
Date: Thu, 20 Jan 2005 19:14:24 +0100
Message-ID: <b8e996db151b5e0f3da7ae513b02c3ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2A7A223D
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2005 19:14:24 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=717> 
======================================================================
Reported By:                pelzi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   717
Category:                   PCI - es1938
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian Sarge
Kernel Version:             2.4.27
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-09-2004 14:52 CET
Last Modified:              01-20-2005 19:14 CET
======================================================================
Summary:                    MIDI input does not generate interrupts
Description: 
No high level midi events are generated, though raw midi events are
received. I.e. amidi -d produces results, but the corresponding
arecordmidi does not.
The possible cause, as suggested on the alsa-user mailing list, is that no
interrupts are generated on incoming midi events. In generel, the
soundcard does generate interrupts tough, e.g. on audio channel events.

======================================================================

----------------------------------------------------------------------
 pelzi - 12-20-04 01:58 
----------------------------------------------------------------------
Ah, I see, there are news at the main page. Tried to delete the original
patch, but I'm not authorized, tried to upload it once again, but it has
to have a different name - so an authorized person will have to clean up
the mess ;-) As writing my email address in a text file doesn't count as
"signing" for me, I also added a detached GPG signature.

----------------------------------------------------------------------
 tiwai - 12-20-04 14:38 
----------------------------------------------------------------------
Thanks, I applied your patch now to CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-09-04 14:52 pelzi          New Issue                                    
12-09-04 14:52 pelzi          Distribution              => Debian Sarge    
12-09-04 14:52 pelzi          Kernel Version            => 2.4.27          
12-09-04 15:27 tiwai          Note Added: 0002802                          
12-10-04 13:22 pelzi          Note Added: 0002804                          
12-10-04 14:38 Clemens LadischNote Added: 0002805                          
12-10-04 15:14 pelzi          File Added: es1938_c_MIDI_Patches.diff            
       
12-10-04 15:16 pelzi          Note Added: 0002806                          
12-16-04 18:40 tiwai          Note Added: 0002837                          
12-20-04 01:48 pelzi          Note Added: 0002865                          
12-20-04 01:56 pelzi          File Added: es1938_c_MIDI_Patches_signed_off.diff 
                  
12-20-04 01:56 pelzi          File Added:
es1938_c_MIDI_Patches_signed_off.diff.asc                    
12-20-04 01:58 pelzi          Note Added: 0002866                          
12-20-04 14:38 tiwai          Status                   new => resolved     
12-20-04 14:38 tiwai          Resolution               open => fixed       
12-20-04 14:38 tiwai          Assigned To               => tiwai           
12-20-04 14:38 tiwai          Note Added: 0002874                          
12-20-04 14:38 tiwai          Assigned To              tiwai =>            
01-20-05 19:14 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
