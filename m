From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001610]: Capture Source Select sets incorrectly
Date: Thu, 1 Dec 2005 22:29:19 +0100
Message-ID: <453c8dceb75b5b89f82321cf59f07158@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2771C194
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2005 22:29:19 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1610> 
======================================================================
Reported By:                psa
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1610
Category:                   simple mixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-01-2005 22:29 CET
Last Modified:              12-01-2005 22:29 CET
======================================================================
Summary:                    Capture Source Select sets incorrectly
Description: 
Simple mixer sets AC97 MX1A incorrectly: only left channel is updated.
Reason: capabilities include 'cswitch-joined', while in reality it's not
joined.
This is caused by a feature bug in src/mixer/simple_none.c in
selem_update() in capture joined analyses. SM_CAP_CSWITCH_JOIN is reset if
CTL_CAPTURE_ROUTE or CTL_CAPTURE_SWITCH has more than one channels, but
not if CTL_CAPTURE_SOURCE has more than one channels, as it should since
SM_CAP_CSWITCH_JOIN is used in _snd_mixer_selem_set_switch() (called
indirctly by snd_mixer_selem_set_capture_switch() called by amixer (or
alsamixer)). If SM_CAP_CSWITCH_JOIN is set in
_snd_mixer_selem_set_switch() channel is always set to 0. When tying to
set right channel nothing is done since sw mask has 1 only for chnnel 1,
but for channel 0.

Fix: in selem_update() add to the condition for reseting
SM_CAP_CSWITCH_JOIN, CTL_CAPTURE_SOURCE.
diff (also enclosed):

-------------------------------------------------------------------
*** simple_none.c.myorg Fri Nov 25 02:21:54 2005
--- simple_none.c       Thu Dec  1 23:13:54 2005
***************
*** 768,774 ****
        if (cchannels > 1) {
                if (simple->ctls[CTL_CAPTURE_ROUTE].elem ||
                    (simple->ctls[CTL_CAPTURE_SWITCH].elem &&
!                    simple->ctls[CTL_CAPTURE_SWITCH].values > 1)) {
                        caps &= ~SM_CAP_CSWITCH_JOIN;
                }
                if (simple->ctls[CTL_CAPTURE_VOLUME].elem &&
--- 768,776 ----
        if (cchannels > 1) {
                if (simple->ctls[CTL_CAPTURE_ROUTE].elem ||
                    (simple->ctls[CTL_CAPTURE_SWITCH].elem &&
!                    simple->ctls[CTL_CAPTURE_SWITCH].values > 1) ||
!                   (simple->ctls[CTL_CAPTURE_SOURCE].elem &&
!                    simple->ctls[CTL_CAPTURE_SOURCE].values > 1)) {
                        caps &= ~SM_CAP_CSWITCH_JOIN;
                }
                if (simple->ctls[CTL_CAPTURE_VOLUME].elem &&
---------------------------------------------------------------------

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-01-05 22:29 psa            New Issue                                    
12-01-05 22:29 psa            File Added: simple_none.c.diff                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
