From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000321]: Left front channel always
	muted on boot
Date: Fri, 23 Jun 2006 15:44:05 +0200
Message-ID: <919858635d06bb6799f4b3241d7dee10@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8163E22C
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jun 2006 15:44:05 +0200 (MEST)
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
Last Modified:              06-23-2006 15:44 CEST
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
 hlabs - 06-23-06 14:52 
----------------------------------------------------------------------
Hi Raymond,

After alinja patch and rebooting left channel not muted completely, but
has much less volume level than right channel.
I must manually change linked l/r volume slider to
restore equial volume level.

----------------------------------------------------------------------
 Raymond - 06-23-06 15:44 
----------------------------------------------------------------------
http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x851.htm

The index field holds the index number of this control. If there are
several different controls with the same name, they can be distinguished
by the index number. This is the case when several codecs exist on the
card. If the index is zero, you can omit the definition above.

you have to ask tiwai why those index controls have different name

	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		iface MIXER
		name PCM
		value.0 168
		value.1 168
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 255'
		iface MIXER
		name 'PCM Center'
		index 1
		value 0
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 255'
		iface MIXER
		name 'PCM Sub'
		index 2
		value 0
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		iface MIXER
		name 'PCM Rear'
		index 3
		value.0 0
		value.1 0
	}

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
10-21-05 03:51 64bitten       Note Added: 0006509                          
11-18-05 21:03 goldenfish     Note Added: 0006758                          
11-18-05 21:04 goldenfish     File Added: proc_changes.diff                    
06-20-06 22:55 effie          Issue Monitored: effie                       
06-20-06 23:05 effie          Issue End Monitor: effie                     
06-20-06 23:29 effie          Note Added: 0010356                          
06-20-06 23:31 effie          Note Edited: 0010356                         
06-21-06 06:10 Raymond        Note Added: 0010382                          
06-21-06 09:05 goldenfish     Note Added: 0010384                          
06-21-06 09:07 goldenfish     File Added: asound.state                     
06-21-06 09:37 herby          Note Added: 0010388                          
06-21-06 10:00 Raymond        Note Added: 0010389                          
06-21-06 10:01 Raymond        Note Edited: 0010389                         
06-21-06 10:17 Raymond        Note Edited: 0010389                         
06-21-06 10:36 Raymond        Note Edited: 0010389                         
06-21-06 14:25 Raymond        Note Edited: 0010389                         
06-22-06 06:30 Raymond        Note Added: 0010417                          
06-22-06 11:30 Raymond        Note Edited: 0010417                         
06-23-06 14:03 hlabs          Note Added: 0010447                          
06-23-06 14:10 Raymond        Note Added: 0010448                          
06-23-06 14:18 hlabs          File Added: asound.state.1                    
06-23-06 14:20 hlabs          Note Added: 0010449                          
06-23-06 14:52 hlabs          Note Added: 0010450                          
06-23-06 15:44 Raymond        Note Added: 0010452                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
