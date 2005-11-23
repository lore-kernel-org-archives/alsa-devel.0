From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001594]: 'playback.pcm {' missing from PMacToonie.conf
Date: Wed, 23 Nov 2005 20:30:33 +0100
Message-ID: <3d12ad75092a3594222aa30d0e789321@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3369A1B4
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 20:30:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1594> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1594
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-23-2005 20:30 CET
Last Modified:              11-23-2005 20:30 CET
======================================================================
Summary:                    'playback.pcm {' missing from PMacToonie.conf
Description: 
The submitter of Debian bug report 340478 reports that there is a line
missing from conf/cards/PMacToonie.conf.  The file contains the following
invalid block:

# default with dmix+softvol & dsnoop
PMacToonie.pcm.default {
        @args [ CARD ]
        @args.CARD {
                type string
        }
        type asym
                type plug
                slave.pcm {
                        type softvol
                        slave.pcm {
                                @func concat
                                strings [ "dmix:CARD=" $CARD ",FORMAT=S16"
]
                        }
                        control {
                                name "PCM Playback Volume"
                                card $CARD
                        }
                }
        }
        capture.pcm {
                type plug
                slave.pcm {
                        @func concat
                        strings [ "dsnoop:CARD=" $CARD ",FORMAT=S16" ]
                }
        }
}


The resulting error is:

ALSA lib conf.c:1596:(snd_config_load1) :51:1:Unexpected }

The user says that adding

    playback.pcm {

fixes the problem.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-05 20:30 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
