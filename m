From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: Patch to fix LIN_OUT1 on Audigy2 cards (+ others)
Date: Wed, 12 Mar 2003 22:16:33 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303122216.33901.adq_dvb@lidskialf.net>
References: <200303120648.HAA27496@www1.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303120648.HAA27496@www1.pobox.sk>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: p z oooo <pzad@pobox.sk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Please ignore the disable-AC97 mixer part of my Audigy2 patch. it isn't that 
simple...

It seems the AC97 is only used for capture on the Audigy2.. As you said, you 
need it to control capturing from mike, line in etc. 

However, it also seems that the microphone input is routed through the FX 
processor and the AC97 in serial.... To adjust the mike volume, you have to 
mess with: (from AC97) "Master", "Mic", "Mic Boost", and (from the EMUFX?) 
"Capture", and "AC97" (Note: NOT "AC97 Capture"... that does nothing!). 
"AC97" has the most effect on the volume, so I assume it must be first in the 
chain... but all the others have a cumulative effect on the recorded volume.

Oh for "Line in": only "Master", and "Line" work, which actually makes sense.

-- 
adq


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
