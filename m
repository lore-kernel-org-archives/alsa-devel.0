From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000334]: EMU10K1, capturing audio is impossible
Date: Mon, 30 Aug 2004 12:04:56 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040830100456.B3A663B024@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 044CF232
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2004 12:05:54 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000334
======================================================================
Reported By:                netslayer
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     334
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.7rc love-sources
Resolution:                 not a bug
======================================================================
Date Submitted:             06-13-2004 23:30 CEST
Last Modified:              08-30-2004 12:04 CEST
======================================================================
Summary:                    EMU10K1, capturing audio is impossible
Description: 
I have an Audigy (EMU10K2 -- on EMU10K1 drivers). It has worked perfectly
in 0.9.8, and in 1.0.x I can playback audio fine, but capturing seems
impossible.

In 0.9.8 I was able to select a capture source in alsamixer by selecting
it with the space bar. The source had "---" areas above it that meant it
had the capture ability. In 1.0.x that whole functionality is gone, and I
see no more way to capture audio. 

I have all my sources up to 100%, and when I plug in an audio to source
into LINE IN on the Audigy, I hear nor can record anything. If I unmute
LINE IN in alsamixer, then I hear pass through audio, which I don't want.
I want to be able to record it, but not hear it through a pass through. 

I know several people with this problem, and I myself have a few of these
cards dedicated to MythTV PVR boxes, and this problem makes it impossible
to upgrade ALSA... It's been 6 months since I tried this, and since nobody
reported it, I thought I would. 
======================================================================

----------------------------------------------------------------------
 netslayer - 06-14-2004 01:38 CEST 
----------------------------------------------------------------------
Just to clarify, I figured out that recording audio off of LINE IN does
work. However, there is no way of recording audio with LINE muted, so as
not to hear the pass through. I want to be able to record, just like in
0.9.8 from the LINE IN, without having to actually listen to the pass
through audio when it is unmuted.

----------------------------------------------------------------------
 pzad - 06-14-2004 08:19 CEST 
----------------------------------------------------------------------
ALSA 0.9.8 uses as ADC AC97, ALSA 1.0.x uses philips ADC (windows drivers
uses philips ADC too and works similiar to alsa 1.0.x).
If you want capture Line In:
-unmute and set Line In volume
-unmute and set volume for Analog Mix Capture Volume
-mute (set volume to 0) for Analog Mix Playback Volume, if don't waqnt to
listen line in while recording.

----------------------------------------------------------------------
 pzad - 08-06-2004 15:01 CEST 
----------------------------------------------------------------------
Helped this ???

----------------------------------------------------------------------
 pzad - 08-30-2004 12:04 CEST 
----------------------------------------------------------------------
Not response for 2 weeks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-13-04 23:30 netslayer      New Bug                                      
06-13-04 23:30 netslayer      Distribution              => Gentoo          
06-13-04 23:30 netslayer      Kernel Version            => 2.6.7rc love-sources
06-14-04 01:38 netslayer      Bugnote Added: 0001305                       
06-14-04 08:19 pzad           Bugnote Added: 0001306                       
06-28-04 09:15 pzad           Status                   new => assigned     
06-28-04 09:15 pzad           Assigned To               => pzad            
08-06-04 15:01 pzad           Bugnote Added: 0001540                       
08-06-04 15:02 pzad           Description Updated                          
08-06-04 15:02 pzad           Steps to Reproduce Updated                    
08-06-04 15:02 pzad           Additional Information Updated                    
08-06-04 15:02 pzad           Status                   assigned => feedback
08-30-04 12:04 pzad           Bugnote Added: 0001667                       
08-30-04 12:04 pzad           Resolution               open => not a bug   
08-30-04 12:04 pzad           Status                   feedback => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
