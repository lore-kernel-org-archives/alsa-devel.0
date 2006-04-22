From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001987]: Upmix Feature Request
Date: Sat, 22 Apr 2006 06:50:11 +0200
Message-ID: <7e5559618de4431bd6b159e778150a9a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B4288161
	for <alsa-devel@alsa-project.org>; Sat, 22 Apr 2006 06:50:11 +0200 (MEST)
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
Status:                     feedback
Distribution:               Debian
Kernel Version:             2.6.16.1
======================================================================
Date Submitted:             03-31-2006 20:38 CEST
Last Modified:              04-22-2006 06:50 CEST
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

----------------------------------------------------------------------
 rlrevell - 04-13-06 17:14 
----------------------------------------------------------------------
No I don't think it does low pass filtering for the sub

----------------------------------------------------------------------
 Raymond - 04-22-06 06:50 
----------------------------------------------------------------------
Where can I find that 3 channels ladspa plugin with lowpass filter ?

http://alsa.opensrc.org/SurroundSound

On my card, I can re-route the stereo to the equalizer to provide low
frequency output for a subwoofer and use hardware mixer to mix stereo to
center.

quadraphonic to left, right bass and lfe

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 20:38 the-me         New Issue                                    
03-31-06 20:38 the-me         Distribution              => Debian          
03-31-06 20:38 the-me         Kernel Version            => 2.6.16.1        
03-31-06 20:40 the-me         Note Added: 0009048                          
03-31-06 21:02 rlrevell       Status                   new => closed       
03-31-06 21:02 rlrevell       Note Added: 0009049                          
03-31-06 21:15 the-me         Status                   closed => feedback  
03-31-06 21:15 the-me         Resolution               open => reopened    
03-31-06 21:15 the-me         Note Added: 0009050                          
04-01-06 01:03 Raymond        Note Added: 0009052                          
04-01-06 10:39 the-me         Note Added: 0009053                          
04-02-06 10:42 Raymond        Note Added: 0009059                          
04-02-06 11:44 the-me         Note Added: 0009060                          
04-02-06 14:36 Raymond        Note Added: 0009061                          
04-02-06 14:57 the-me         Note Added: 0009062                          
04-02-06 16:26 Raymond        Note Added: 0009063                          
04-04-06 09:33 Raymond        Note Added: 0009111                          
04-13-06 12:52 the-me         Note Added: 0009257                          
04-13-06 13:05 the-me         Note Edited: 0009257                         
04-13-06 17:14 rlrevell       Note Added: 0009263                          
04-22-06 06:50 Raymond        Note Added: 0009432                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
