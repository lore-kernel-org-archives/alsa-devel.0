From: Anders Torger <torger@ludd.luth.se>
Subject: RME9652 HDSP and DSP status?
Date: Wed, 9 Apr 2003 09:05:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304090905.50939.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I'm a bit uncertain which of RME's hammerfall cards that currently work 
with ALSA (cvs or stable). Looking at RME's website, these are the RME 
Hammerfall products:

RME DIGI9652/RME DIGI9636 - the old classic cards no longer manufactured
   http://www.rme-audio.de/english/hammer/d9652.htm

RME Hammerfall DSP - Cardbus or PCI interface with breakout boxes
   http://www.rme-audio.de/english/hdsp/cardpci.htm
   http://www.rme-audio.de/english/hdsp/digifa.htm
   http://www.rme-audio.de/english/hdsp/multifa.htm

RME HDSP9652 - the new version of RME DIGI9652  
   http://www.rme-audio.de/english/hdsp/hdsp9652.htm

RME HDSP9632 - to be released
   http://www.rme-audio.de/english/hdsp/hdsp9632.htm

RME HDSP MADI - to be released
   http://www.rme-audio.de/english/hdsp/hdspmadi.htm

The only cards I know work with ALSA from own experience, is the RME 
DIGI9652 and RME DIGI9636 (aka "RME Hammerfall" and "RME Hammerfall 
Light").

The ALSA sound card matrix state support for Hammerfall DSP as well. 
Does this include both the Cardbus and PCI interface, and both breakout 
boxes (digiface and multiface)? Are there any limitations in 
functionality?

Does the rme9652 driver work with the new Hammefall version, HDSP9652?

/Anders Torger


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
