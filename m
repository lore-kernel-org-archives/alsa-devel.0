From: Frank Barknecht <fbar@footils.org>
Subject: Re: Some info about the Edirol UA-3 FX
Date: Mon, 2 Feb 2004 21:32:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040202203253.GB14461@fliwatut.scifi>
References: <20040202192250.GA12719@fliwatut.scifi> <008301c3e9c4$367b2dd0$a501a8c0@computer2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.218])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA24778
	for <alsa-devel@alsa-project.org>; Mon, 2 Feb 2004 21:33:26 +0100
Received: from fliwatut.scifi (xdsl-213-196-247-129.netcologne.de [213.196.247.129])
	by smtp2.netcologne.de (Postfix) with ESMTP id 07C4E3AF8E
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2004 21:32:54 +0100 (MET)
Received: from freak by fliwatut.scifi with local (Exim 3.36 #1 (Debian))
	id 1AnkkY-0003sT-00
	for <alsa-devel@alsa-project.org>; Mon, 02 Feb 2004 21:32:54 +0100
Content-Disposition: inline
In-Reply-To: <008301c3e9c4$367b2dd0$a501a8c0@computer2>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hallo,
Andreas Kuckartz hat gesagt: // Andreas Kuckartz wrote:

> Do you know if it works with a 2.4 kernel?

No, I didn't test this yet, but I strongly suppose, that it is the
same behaviour. I had the Edirol UA-20, when the Advanced mode wasn't
supported yet by ALSA (it is now). At that time, the normal mode was
working just fine, so I guess, that this is just a standard USB audio
device when not in Advanced mode. In advanced mode however lie all the
discerning features of the UA-3 FX, like higher samplerates. And
without a samplerate of 48000 you won't be happy with any USB device
because of the constant frame size of USB audio (the samplerate should
divide evenly by 1000). 

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
