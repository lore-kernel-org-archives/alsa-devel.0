From: Frank Barknecht <fbar@footils.org>
Subject: Re: Some info about the Edirol UA-3 FX
Date: Mon, 2 Feb 2004 20:30:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040202193059.GA13097@fliwatut.scifi>
References: <20040202192250.GA12719@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.218])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA22949
	for <alsa-devel@alsa-project.org>; Mon, 2 Feb 2004 20:31:37 +0100
Received: from fliwatut.scifi (xdsl-213-196-226-9.netcologne.de [213.196.226.9])
	by smtp2.netcologne.de (Postfix) with ESMTP id 5FA7339CEF
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2004 20:31:04 +0100 (MET)
Received: from freak by fliwatut.scifi with local (Exim 3.36 #1 (Debian))
	id 1Anjmd-0003QH-00
	for <alsa-devel@alsa-project.org>; Mon, 02 Feb 2004 20:30:59 +0100
Content-Disposition: inline
In-Reply-To: <20040202192250.GA12719@fliwatut.scifi>
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
Frank Barknecht hat gesagt: // Frank Barknecht wrote:

> I tested the Edirol UA-3 FX in my series of tests now, and this is
> another device I cannot get to work. I get "no modules for USB product
> 582/50/100" in the logfiles. Attached is several diagnostics
> information for later use. 

Now I discovered a teenytiny switch on the back if the UA-3 FX that
switches the "Advanced Driver"  features of the device on or off.
Setting this to OFF, I now got ALSA to recognize the device as a
simple 44100 Hz device. No higher samplerates, though.
Probably a quirk is needed?

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
