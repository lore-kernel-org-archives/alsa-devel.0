From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000346]: no master volume set when maestro/alsa settings save & "restart"
Date: Sun, 20 Mar 2005 13:22:49 +0100
Message-ID: <4ae17d8636a3ac8f3f2951cf1013bdbd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 30CF0250
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 13:22:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=346> 
======================================================================
Reported By:                phoenixreads
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   346
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-26-2004 12:00 CEST
Last Modified:              03-20-2005 13:22 CET
======================================================================
Summary:                    no master volume set when maestro/alsa settings save
& "restart"
Description: 
Gentoo uses a init.d script to handle alsa, called alsasound

Stop: unloads the modules and saves settings using alsactl.
Start: loads appropriate modules and calls alsactl restore #
======================================================================

----------------------------------------------------------------------
 phoenixreads - 06-30-04 19:40 
----------------------------------------------------------------------
At the moment the board I am using has integrated audio and using the
via82xx driver. I turn it on (was previously disabled) and reconfigured
alsa to use it as the only audio source. Side note: alsactrl does not seem
to care if integrated audio is enabled or not and saves the setting
regardless. The alsasound script works as expected. And just in case,
remember I had the exactly same behavior on a Intel PII board. Who knows
it could be this particular soundcard? Is there a way to do a black and
white test on the "hardware" level? The software seems to be happy and
reporting the change but is the hardware?

----------------------------------------------------------------------
 jdthood - 03-20-05 13:22 
----------------------------------------------------------------------
>   bash-2.05b# modprobe snd-maestro3
> the Master volume is at 0
> setting the Master volume with
>   bash-2.05b# amixer sset Master 28
> does not work even thou it registers so
>   bash-2.05b# /usr/sbin/alsactl restore
> This works but...
>   bash-2.05b# modprobe -r snd-maestro3
>   bash-2.05b# modprobe snd-maestro3
>   bash-2.05b# /usr/sbin/alsactl restore
> does not work

I think that this would have to be a driver bug.
Should this report be reassigned to alsa-driver?

Submitter: Was the problem fixed in a laster release of ALSA?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-04 12:00 phoenixreads   New Issue                                    
06-26-04 12:21 eradicator     Issue Monitored: eradicator                    
06-30-04 16:43 tiwai          Note Added: 0001360                          
06-30-04 19:26 phoenixreads   Note Added: 0001363                          
06-30-04 19:40 phoenixreads   Note Added: 0001364                          
03-20-05 13:22 jdthood        Note Added: 0004080                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
