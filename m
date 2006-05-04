From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA 1.0.9rc2 (Linux kernel 2.6.12) and higher you
 don't need to setup Dmix ?
Date: Thu, 04 May 2006 19:28:50 +0200
Message-ID: <20060504172850.GC26321@turing.informatik.uni-halle.de>
References: <20060501103247.07cce99b.sevmek@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.urz.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 65B44239
	for <alsa-devel@alsa-project.org>; Thu,  4 May 2006 19:29:20 +0200 (MEST)
In-reply-to: <20060501103247.07cce99b.sevmek@free.fr>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Yannick-GNU/Linux <sevmek@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yannick-GNU/Linux wrote:
> I writing a doc to setup alsa and dmix for the Ekiga VoIP software. I
> read here : http://alsa2.opensrc.org/DmixPlugin
> quote : "NOTE: For ALSA 1.0.9rc2 and higher you don't need to setup
> dmix. Dmix is enabled as default for soundcards which don't support hw
> mixing."
> But i'm using kernel 2.6.13, ALSA Version 1.0.9b (from kernel.org)
> with the driver snd_intel8x0 (chip is nforce4 ultra, mother board ASUS
> a8n-e) and i need to explicitly set dmix via an .asoundrc to get
> software mixing.

The dmix plugin is part of the alsa-lib package.

You should always use an alsa-lib that is at least as new as the
kernel's alsa-driver.


HTH
Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
