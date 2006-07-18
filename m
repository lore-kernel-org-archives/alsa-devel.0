From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002137]: No mute controls for Audigy
	or Audigy 2ZS
Date: Tue, 18 Jul 2006 14:35:11 +0200
Message-ID: <f53b86f2b374ee33d08e96cae45200a9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C9D4A150
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:35:11 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2137> 
======================================================================
Reported By:                stdpikachu
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2137
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.15, 2.6.16
======================================================================
Date Submitted:             05-20-2006 15:23 CEST
Last Modified:              07-18-2006 14:35 CEST
======================================================================
Summary:                    No mute controls for Audigy or Audigy 2ZS
Description: 
The problem has been around for while, but have only just got around to
reporting it (incidentally, where do I search for previously file bug
reports?).

I have three computers, all with various flavours of Audigy cards, all
using the latest emu10k1 alsa driver. The problem also exists with the
in-kernel audigy driver. Googling for other people with the same problem
suggests the problem crept it quite a while ago.

No matter what UI is used, I can't mute most channels provided by the
audigy driver. For instance, in alsamixer I can only mute Headphones,
Line, CD, Phone, PC Speaker and Aux. ALl other channels are without mute
toggles.

The upshot of this is that mute controls in almost all alsa apps doesn't
work and the only way to mute the channel is to manually set master or PCM
volume to zero.

I read of a bug with one of the intel sound drivers that lost most of the
mute controls, maybe this is the same sort of thing.
======================================================================

----------------------------------------------------------------------
 pzad - 05-20-06 16:09 
----------------------------------------------------------------------
AFAIK Audigy alsa driver never had mute switches (sb live had). Only analog
mixer part has mute switches.

----------------------------------------------------------------------
 stdpikachu - 05-20-06 16:47 
----------------------------------------------------------------------
What does that mean in terms of giving emu10k1 mute functionality? It isn't
possible?

----------------------------------------------------------------------
 jcdutton - 05-20-06 17:02 
----------------------------------------------------------------------
Of course it is possible. It is just that time is spent on other things
instead.


----------------------------------------------------------------------
 rlrevell - 05-20-06 17:22 
----------------------------------------------------------------------
Wasn't it a deliberate design decision not to waste GPRs on mute controls,
as this can be implemented by the mixer app?

----------------------------------------------------------------------
 jcdutton - 05-20-06 17:27 
----------------------------------------------------------------------
One does not have to use GPRs to implement it.
One can just use local state variables instead.

----------------------------------------------------------------------
 pzad - 05-20-06 17:32 
----------------------------------------------------------------------
Simpler is waste GPRs. Audigy has plenty of GPRs to waste :-). Mute on
every controls needs 54 GPRs - there will be more then 256 GPRs free after
implementing them.

----------------------------------------------------------------------
 pzad - 05-20-06 19:57 
----------------------------------------------------------------------
Could you try this audigy_mute.patch ?
Not very much tested, but for me it works.
Need some work to support cards with 1361T chip (I don't have such card -
someone else have to finish it.

----------------------------------------------------------------------
 rlrevell - 05-20-06 21:17 
----------------------------------------------------------------------
pzad, did you forget to upload the patch?

----------------------------------------------------------------------
 pzad - 05-21-06 11:41 
----------------------------------------------------------------------
Sorry. It is there now.



----------------------------------------------------------------------
 stdpikachu - 05-24-06 21:45 
----------------------------------------------------------------------
Apols for the numpty reply, but what are the instructions for patching the
driver source? I've not done much kernel haXx0ring myself. I tried patch
-p0 against emufx.c, but when that fails I'm a little bit lost...!

Thanks for devoting the time and effort into all of this :)

P.S. Is the 1361T chip the one inside the Audigy LS?

----------------------------------------------------------------------
 pzad - 05-24-06 22:33 
----------------------------------------------------------------------
I think 1361T is in Audigy 4.

The simplest way is:
Get alsa-driver package - from www.alsa-project.org.
extract it somewhere
change dir to alsa-kernel dir in (should be in "somewhere" dir)
patch -p1 < path_to_patch
configure
make
make install
restart alsa (/etc/init.d/alsasound restart)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-20-06 15:23 stdpikachu     New Issue                                    
05-20-06 15:23 stdpikachu     File Added: alsamixer.png                    
05-20-06 15:23 stdpikachu     Distribution              => Gentoo          
05-20-06 15:23 stdpikachu     Kernel Version            => 2.6.15, 2.6.16  
05-20-06 16:09 pzad           Note Added: 0009884                          
05-20-06 16:47 stdpikachu     Note Added: 0009885                          
05-20-06 17:02 jcdutton       Note Added: 0009886                          
05-20-06 17:02 jcdutton       Status                   new => acknowledged 
05-20-06 17:22 rlrevell       Note Added: 0009887                          
05-20-06 17:27 jcdutton       Note Added: 0009888                          
05-20-06 17:32 pzad           Note Added: 0009889                          
05-20-06 19:57 pzad           Note Added: 0009891                          
05-20-06 21:17 rlrevell       Note Added: 0009892                          
05-20-06 21:18 rlrevell       Note View State: public: 9892                    
05-21-06 11:32 pzad           File Added: audigy_mute.patch                    
05-21-06 11:32 pzad           Note Added: 0009897                          
05-21-06 11:41 pzad           Note Edited: 0009897                         
05-24-06 21:45 stdpikachu     Note Added: 0009960                          
05-24-06 22:33 pzad           Note Added: 0009961                          
07-18-06 14:35 jcdutton       Status                   acknowledged => assigned
07-18-06 14:35 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
