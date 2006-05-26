From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002157]: Regression on HP dc7600
	(0x103c, 0x3012)
Date: Fri, 26 May 2006 15:00:55 +0200
Message-ID: <f9b7b996963bc6131dc023a4c2edb8fa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E879177
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 15:00:55 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2157> 
======================================================================
Reported By:                ondrej
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2157
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Linux
Kernel Version:             2.6.15-23-amd64-xen
======================================================================
Date Submitted:             05-24-2006 11:39 CEST
Last Modified:              05-26-2006 15:00 CEST
======================================================================
Summary:                    Regression on HP dc7600 (0x103c, 0x3012)
Description: 
Sound stopped working when upgraded to anything higher then 1.0.9, there
was new code to add support for HDA intel (Realtek) on HP machines.

0x3012 is almost same as 0x3013, just Headphones and Front is reversed. 
And BTW "Front" is connector on the back of machine.
======================================================================

----------------------------------------------------------------------
 ondrej - 05-24-06 21:10 
----------------------------------------------------------------------
Just one more observation:

With ALS260_HP_3013 Front Mic can be muted/unmuted, volume works, but
Capture is not, f.e. Ekiga is not able to capture any input from
microphone and starts printing error messages.

----------------------------------------------------------------------
 tiwai - 05-26-06 15:00 
----------------------------------------------------------------------
I changed the model to HP3013 on HG repo now.

Does the capture from other source work?  What kind of error did you get?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 11:39 ondrej         New Issue                                    
05-24-06 11:39 ondrej         Distribution              => Ubuntu Linux    
05-24-06 11:39 ondrej         Kernel Version            => 2.6.15-23-amd64-xen
05-24-06 13:26 ondrej         Issue Monitored: ondrej                      
05-24-06 13:50 fuman          Issue Monitored: fuman                       
05-24-06 21:10 ondrej         Note Added: 0009959                          
05-26-06 15:00 tiwai          Note Added: 0009978                          
======================================================================
