From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001659]: dmix not working with ice1712
Date: Mon, 2 Jan 2006 23:07:15 +0100
Message-ID: <2672c3d254ada3d85a6a9fcc2eba3063@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BDAD7161
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 23:07:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1659> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1659
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-18-2005 21:07 CET
Last Modified:              01-02-2006 23:07 CET
======================================================================
Summary:                    dmix not working with ice1712
Description: 
In Debian bug 342026 the submitter reports:

> After an upgrade today [to 1.0.10rc1?], the dmix plugin stopped
working.
> 
>     $ mocp 	# or any other program trying to use alsa
>     ALSA lib pcm_direct.c:812:(snd_pcm_direct_initialize_slave)
requested or auto-format is not available
>     ALSA lib pcm_dmix.c:831:(snd_pcm_dmix_open) unable to initialize
slave
> 
> My ~/.asoundrc is the example configuration for using dmix with the
> ICE1712 chip (found e.g. at
http://alsa.opensrc.org/index.php?page=DmixPlugin).
> 
> # cat ~/.asoundrc
> # our ICE1712 dmix:
> pcm.ossmix {
>     type dmix
>     ipc_key 1024
>     slave {
>     pcm "hw:0,0"
>         period_time 0
>         period_size 1024
>         buffer_size 4096 # buffer size < 6653, but pow(x, 2)
>         rate 44100 # we want to play CDs only
>     }
>     bindings {
>         0 0
>         1 1
>     }
> }
> # Everything shall be dmixed, so redefine "default":
> pcm.!default {
>     type plug
>     slave.pcm "ossmix"
> }
> # OSS via aoss should d(mix)stroyed:
> pcm.dsp0 {
>     type plug
>     slave.pcm "ossmix"
> }
> ctl.mixer0 {
>     type hw
>     card 0
> }


He says that this config worked in ALSA 1.0.9.

He later adds:

> Adding 'format S32_LE' in the original .asoundrc seems to have fixed
> the problem. Apparently the default format (for ice1712 or generally?)
> has been changed to something that doesn't work.

As always, see http://bugs.debian.org/342026 for the complete log.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-18-05 22:31 
----------------------------------------------------------------------
Remove your .asoundrc and apply the attached patch.

Maintainers, please apply for 1.0.11 release.  Another user has confirmed
the patch fixes the problem.

----------------------------------------------------------------------
 jdthood - 01-02-06 23:07 
----------------------------------------------------------------------
I notice that this patch was not applied in 1.0.11rc2.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-18-05 21:07 jdthood        New Issue                                    
12-18-05 22:30 rlrevell       File Added: ICE1712-dmix.patch                    
12-18-05 22:31 rlrevell       Note Added: 0007072                          
01-02-06 23:07 jdthood        Note Added: 0007394                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
