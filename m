From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000640]: azx code is nasty
Date: Tue, 11 Jan 2005 16:53:29 +0100
Message-ID: <8014e247c01a036aa5bf43ba2f4e6ebe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B8132290
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2005 16:53:29 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=640> 
======================================================================
Reported By:                russell
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   640
Category:                   PCI - azx
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     closed
Distribution:               Debian/Ubuntu
Kernel Version:             2.6.8.1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-10-2004 14:30 CET
Last Modified:              01-11-2005 16:53 CET
======================================================================
Summary:                    azx code is nasty
Description: 
Some of the code in the azx driver is very difficult to read, depending on
how you set up tabs etc in your IDE. This is a[n almost] purely cosmetic
change to codec_enum.c

I have commented out some of the snd_printdd()s inside the smaller helper
functions too (to make my poor l'il log look nicer). I have also changed
one obviously inefficient function (get_bit_value()) into a macro. All
seems to compile and work about as well as 1.0.7rc2 does (for me, not
particularly well - hence my work on it)
======================================================================

----------------------------------------------------------------------
 russell - 11-12-04 15:40 
----------------------------------------------------------------------
My apologies, I was not aware of that document. Should be more fixed now.

The one glaring area where it isn't is line length. At times, there are
indents up to 7 levels deep, leaving less than 30 characters for code - it
would be impractical to try to wrap some of this code. This is more of an
architectural issue with the code than simply a style issue (and it is
easy to teach most editors to render a tab as two characters wide, which
largely alleviates the problem). This is something which I hope to address
fairly soon.

----------------------------------------------------------------------
 tiwai - 12-08-04 19:54 
----------------------------------------------------------------------
The code is now completely written.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-10-04 14:30 russell        New Issue                                    
11-10-04 14:30 russell        File Added: codec_enum.c                     
11-10-04 14:30 russell        Distribution              => Debian/Ubuntu   
11-10-04 14:30 russell        Kernel Version            => 2.6.8.1         
11-12-04 12:22 tiwai          Note Added: 0002393                          
11-12-04 15:40 russell        Note Added: 0002398                          
11-12-04 15:40 russell        File Added: codec_enum.c                     
12-08-04 19:54 tiwai          Status                   new => resolved     
12-08-04 19:54 tiwai          Resolution               open => fixed       
12-08-04 19:54 tiwai          Assigned To               => tiwai           
12-08-04 19:54 tiwai          Note Added: 0002792                          
12-08-04 19:54 tiwai          Assigned To              tiwai =>            
01-11-05 16:53 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
