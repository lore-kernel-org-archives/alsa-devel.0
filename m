From: Winfried Ritsch <ritsch@iem.at>
Subject: RME HDSP-MADI driver ready to check in...
Date: Wed, 21 Jan 2004 18:12:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16398.45827.395425.720776@seneca.iemnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Hello,

I have finished the ALSA RME HDSP-MADI driver 

 ( see http://www.rme-audio.com/english/hdsp/hdspmadi.htm )

I have it running for testing now since Oktober and think it is quite
stable. I also implemented the 192kHz stuff but had no hardware to
test this. I made one file hdspm.c and a header hdspm.h . Also I did a
description of config options (now only in german, but can be
translated, and some testing programms.

So my question are:

 -  how to commit it.  

 - where to place hdspm.c (since pci/rme9652 is somewhat misleading). My
suggestion is renaming rme9652 folder in pci to rme and also put the
rme96.c in it or put it in the pci/ folder.

 - is there a place to put the hdspm test-apps and docu somewhere ? 
  or should I setup a own page for it (wiki) ?

mfg Winfried Ritsch

--
- ao.Univ.Prof. DI Winfried Ritsch 
- ritsch _AT_ iem.at - http://iem.at/ritsch
- Institut fuer Elektronische Musik und Akustik
- University of Music and Dramatic Art Graz
- Tel. ++43-316-389-3510 (3170) Fax ++43-316-389-3171 
- PGP-ID 69617A69 (see keyserver http://wwwkeys.at.gpg.net/)
--




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
