From: noreply@alsa-project.org
Subject: [ALSA - driver 0000233]: Can't use microphone with all Applis
Date: Fri, 16 Jul 2004 12:42:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104253.2824B26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 815B5255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:42:53 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000233
======================================================================
Reported By:                mferrato
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     233
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Slackware + dropline ( alsa-drivers 0.9.8 ) + alsa-(allpkg)1.0.4
Kernel Version:             2.4.24
======================================================================
Date Submitted:             04-26-2004 00:12 CEST
Last Modified:              07-16-2004 12:42 CEST
======================================================================
Summary:                    Can't use microphone with all Applis
Description: 
When i select, with alsamixer, capture from microphone and no-mute, i hear 
in speakers what i have speaking in microphone, if high level i hear
"Larsen" (whistle)
when i use appli using microphone ( gnomemeeting, arecord, gnome sound
record ) no sound is recorded.
With gnomemeeting i have tried with Alsa or OSS driver, it's identical
All sound outputs are OK ( cdplayer, sound player from file or stream)
======================================================================

----------------------------------------------------------------------
 mferrato - 04-28-2004 01:15 CEST 
----------------------------------------------------------------------
Sorry, I am stupid 

I have searched in mailing-list and i found that below.
Also after activated with amixer
"Mic" "Capture" and "ADC" my problem was resolved
Thanks

From: Kai Vehmanen <kai@wa...>
recording problems with snd-cs46xx (was: Re: Re: Alsa-devel digest, Vol 1
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000810 - 3 msgs)  
2003-11-11 12:33

 Hi,
 
 this issue is over a year old, but in case someone stumbles on
 to the same problem. The solution is already documented at
 
    http://alsa.opensrc.org/index.php?page=cs46xx
 
 ... but it took me a while to find it. :)
 
 On Tue, 29 Oct 2002, Bob McElrath wrote:
 
 >>>Recording still seems to not work.  I still get about a 1Hz ticking
in
 > I cannot record anything at all, from any input (I haven"t tried from
 > SPDIF -- I don"t have a reliable SPDIF source anyway)  I get the 1Hz
 
 I had this very same problem with alsa-driver-0.9.8. The problem turned 
 out to be that I had not selected "ADC" as a capture source in alsamixer.

 So you need to select all three: "ADC", "Mic" and "Capture" for the 
 recording to work properly.
 
 PS Tested with IBM Thinkpad models T20 and T21.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-26-04 00:12 mferrato       New Bug                                      
04-26-04 00:12 mferrato       File Added: t.wav                            
04-26-04 00:12 mferrato       Distribution              => Slackware + dropline ( alsa-drivers 0.9.8 ) + alsa-(allpkg)1.0.4
04-26-04 00:12 mferrato       Kernel Version            => 2.4.24          
04-26-04 14:12 mferrato       Bug Monitored: mferrato                      
04-28-04 01:11 mferrato       Bug End Monitor: mferrato                    
04-28-04 01:15 mferrato       Bugnote Added: 0000967                       
05-01-04 10:51 tiwai          Assigned To               => tiwai           
05-01-04 10:51 tiwai          Resolution               open => not a bug   
05-01-04 10:51 tiwai          Status                   new => resolved     
07-16-04 12:42 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
