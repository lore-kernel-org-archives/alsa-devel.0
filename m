From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0000991]: ADS Instant Music (RDX-150) works perfectly for outputing audio
Date: Mon, 14 Mar 2005 18:48:43 +0100
Message-ID: <daf3440574d86e9e5a03ec6e7437619b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 408D21B0
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2005 18:48:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=991> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   991
Category:                   soundcard matrix
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-14-2005 18:44 CET
Last Modified:              03-14-2005 18:48 CET
======================================================================
Summary:                    ADS Instant Music (RDX-150) works perfectly for
outputing audio
Description: 
I purchased a device from ADS Tech called 'Instant Music'. Model number
RDX-150. All output functions (analog and spdif-optical) work perfectly
under Alsa. I'm currently using the device every day between an FC2/Planet
machine and out home theater system using a TOSLINK input on the receiver
and Aqualung under Gnome.

Please add this device to the sound Card Matrix.

Here's a link:

http://www.adstech.com/products/RDX-150/intro/RDX-150_intro1.asp?pid=RDX-150
======================================================================

----------------------------------------------------------------------
 Mark Knecht - 03-14-05 18:48 
----------------------------------------------------------------------
To be clear I am only using the device for stereo output. I have not tested
any 5.1.

Here's the modprobe.conf info for the system. We needed the device to not
be the default sound device. 

[mark@dragonfly mark]$ cat /etc/modprobe.conf
alias eth0 8139too
 
alias snd-card-0 snd-intel8x0
options snd-intel8x0 index=0
alias snd-card-0 snd-intel8x0
install snd-intel8x0 /sbin/modprobe --ignore-install snd-intel8x0 &&
/usr/sbin/alsactl restore >/dev/null 2>&1 || :
remove snd-intel8x0 { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-intel8x0
 
alias snd-card-1 snd-usb-audio
options snd-usb-audio index=1
 
alias usb-controller ehci-hcd
alias usb-controller1 uhci-hcd
alias wlan0 ndiswrapper
[mark@dragonfly mark]$

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-14-05 18:44 Mark Knecht    New Issue                                    
03-14-05 18:48 Mark Knecht    Note Added: 0003905                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
