From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001214]: With Terratec DMX6fire, digital inputs cannot be selected correctly -always internal digital source
Date: Tue, 23 Aug 2005 18:52:57 +0200
Message-ID: <a85e1e0e47625b89c06eb01bc2939c42@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF9D3263
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2005 18:52:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1214> 
======================================================================
Reported By:                alanmann
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   1214
Category:                   envy24control
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-27-2005 15:27 CEST
Last Modified:              08-23-2005 18:52 CEST
======================================================================
Summary:                    With Terratec DMX6fire, digital inputs cannot be
selected correctly -always internal digital source
Description: 
The DMX6fire sound card has onboard 'digital in' for direct connection from
a CD drive as well as coax and optical front panel in and out. 
Envy24control has no button to select the internal source, but in fact it
seems always selected and works fine.  Consequently the front panel inputs
never work,(I can only test optical, but internal source is always
working) although the selector 'SPDIF input' changes the panel lights
correctly, and the 'SPDIF on/off' swaps the lights whichever way they
were.
======================================================================

----------------------------------------------------------------------
 alanmann - 07-08-05 22:09 
----------------------------------------------------------------------
Being new to working with software, I'm not sure strictly what you mean by
a 'patch'.  I have edited the source files of envy24control, working to
successive levels, preserving each one:-
  1. Purely correcting errors and making the minimum changes necessary;

  2. Tidying up the controls a little, particularly in respect of
DMX6fire, eg so the panel LED correctly lights when front input is
selected, removing the separate button, and changing several of the
titles; for DMX6fire users this should make a lot more sense;

  3. Re-working the window and tab action of the control panel so the
'mixer-out' meters always show, and the 'input-meters' are on a separate
tab to the PCMs to reduce scrolling.  I am still working on this version,
hoping to then re-arrange controls to reduce the minimum window size. 
This is purely to improve usability etc.

These have been achieved so far by editing envy24control.c, hardware.c and
levelmeters.c.  The new files could be available if desired.

----------------------------------------------------------------------
 alanmann - 08-23-05 18:52 
----------------------------------------------------------------------
I'm slowly getting the idea, and have posted two patches to alsa-devel
mailing list on 18.8.05.  Hopefully they may be of some use.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-27-05 15:27 alanmann       New Issue                                    
06-27-05 16:05 tiwai          Note Added: 0005274                          
06-29-05 22:39 alanmann       Note Added: 0005318                          
07-08-05 14:48 tiwai          Note Added: 0005428                          
07-08-05 22:09 alanmann       Note Added: 0005435                          
08-23-05 18:52 alanmann       Note Added: 0005913                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
