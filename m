From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001987]: Upmix Feature Request
Date: Fri, 31 Mar 2006 20:38:25 +0200
Message-ID: <4446e39556f16ed35f499bbedfdf8e9d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 63752169
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 20:38:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1987> 
======================================================================
Reported By:                the-me
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1987
Category:                   CORE - control
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.16.1
======================================================================
Date Submitted:             03-31-2006 20:38 CEST
Last Modified:              03-31-2006 20:38 CEST
======================================================================
Summary:                    Upmix Feature Request
Description: 
Hi,

I, and many users more, want a feature at the alsamixer, called Upmix.
I've got an Terratec Aureon 5.1 Fun and I tried many things, but it's not
able, that I can hear an mp3 with upmixed 5.1 sound. Here is my actual
.asoundrc:

pcm.ch51upmix {
        type route
        slave.pcm surround51
        slave.channels 6
        ttable.0.0 1
        ttable.1.1 1
        ttable.0.2 1
        ttable.1.3 1
        ttable.0.4 0.5
        ttable.1.4 0.5
        ttable.0.5 0.5
        ttable.1.5 0.5
}
pcm.!default
{
        type plug
        slave.pcm ch51upmix
}
pcm.lowpass {
type ladspa
path "/usr/lib/ladspa"
plugins [ {
label lpf
input {
controls [ 50 ]
}
} ]
}


With this .asoundrc, all speakers work, but my subwoofer doesn't play only
low frequen...

Can you please add such a feature?


Greetz, Patrick
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 20:38 the-me         New Issue                                    
03-31-06 20:38 the-me         Distribution              => Debian          
03-31-06 20:38 the-me         Kernel Version            => 2.6.16.1        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
