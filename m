From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001699]: Alsa 1.0.11rc2 and Unknown symbol
Date: Mon, 2 Jan 2006 16:38:32 +0100
Message-ID: <1cf330135595ea216c6150dc1d213832@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D15DD134
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 16:38:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1699> 
======================================================================
Reported By:                kratz00
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1699
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-02-2006 16:38 CET
Last Modified:              01-02-2006 16:38 CET
======================================================================
Summary:                    Alsa 1.0.11rc2 and Unknown symbol
Description: 
Alsa 1.0.10 is working on the same system/configuration but 1.0.11rc1 and
rc2
produce the following error output:

FATAL: Error inserting snd
(/lib/modules/2.6.15-rc7/kernel/drivers/sound/acore/snd.ko): Unknown
symbol in module, or unknown parameter (see dmesg)

output from dmesg:
snd: Unknown symbol pm_register
snd: Unknown symbol pm_unregister

I found out if I disable ACPI in my kernel then it's also working with
1.0.11rc*
but I need ACPI support and it's working fine with 1.0.10 so there must be
a problem with 1.0.11rc*

# Power management options (ACPI, APM)
CONFIG_PM=y

<->

# Power management options (ACPI, APM)
# CONFIG_PM is not set
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-06 16:38 kratz00        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
