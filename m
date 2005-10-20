From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000321]: Left front channel always muted on boot
Date: Thu, 20 Oct 2005 05:18:52 +0200
Message-ID: <1b075c56e606d4c9869b4e2626a1e644@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B16C713E
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2005 05:18:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=321> 
======================================================================
Reported By:                64bitten
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   321
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     acknowledged
Distribution:               gentoo
Kernel Version:             2.6.6
======================================================================
Date Submitted:             06-02-2004 08:09 CEST
Last Modified:              10-20-2005 05:18 CEST
======================================================================
Summary:                    Left front channel always muted on boot
Description: 
ice1724 (M Audio Revolution 7.1 in my case) always restores the mixer
settings at boot, but the left front channel is muted regardless.  The fix
is to run alsamixer and adjust the slider again.  This forces the channel
to unmute.  Should I be worried "amixer scontrols" reports everything as
"Mono" as well?
======================================================================

----------------------------------------------------------------------
 sst4 - 10-20-05 02:36 
----------------------------------------------------------------------
I have the same problem on Mandriva 10.2 - was lazy to report it.

I believe the problem existed in Mandriva 10.1 too.

----------------------------------------------------------------------
 Fran - 10-20-05 05:18 
----------------------------------------------------------------------
Well, I have the same problem, in my case the speaker not working is the
right one, and the slider I have to change in alsamixer is "DAC" (the
first one).
There are no differences between amixer or asound.state before and after,
that's coherent with the problem, restoring or saving the state doesn't
help.
The only difference I see in asound.state between this DAC and the others
is the "index" property: (I guess this is why this one is called "DAC" and
the other ones are "DAC n")
        control.20 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 255'
                iface MIXER
                name 'DAC Volume'
                value 230
        }
        control.21 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 255'
                iface MIXER
                name 'DAC Volume'
                index 1
                value 230
        }

I'm not sure what else to look at, but I can test whatever you like, just
ask please.
I'm using standalone ALSA 1.0.9 and kernel 2.6.12 but this seems to be a
problem with every version of alsa, since this bug is really old. Mi sound
card is an M-Audio Revolution 7.1

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-04 08:09 64bitten       New Issue                                    
06-02-04 08:09 64bitten       Distribution              => gentoo          
06-02-04 08:09 64bitten       Kernel Version            => 2.6.6           
12-17-04 03:15 K6-III         Note Added: 0002845                          
12-17-04 06:46 herby          Note Added: 0002846                          
12-17-04 06:51 rlrevell       Note Added: 0002847                          
12-21-04 07:09 64bitten       File Added: amixer.bad                       
12-21-04 07:10 64bitten       Note Added: 0002896                          
04-09-05 17:24 jdthood        Status                   new => acknowledged 
10-20-05 02:36 sst4           Note Added: 0006497                          
10-20-05 05:18 Fran           Note Added: 0006498                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
