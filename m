From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: More hotplug problems
Date: Mon, 29 Nov 2004 18:17:56 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411291816050.9175-100000@studcom.urz.uni-halle.de>
References: <200411290853.58117.carlosjosepita@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A7F7E2B8
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 18:17:58 +0100 (MET)
In-Reply-To: <200411290853.58117.carlosjosepita@yahoo.com.ar>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Pita <carlosjosepita@yahoo.com.ar>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Carlos Pita wrote:
> The fact is that snd-seq is not listed as a dependency of snd-emu10k1,
> which I guess is right.

Yes, it's designed to be (auto)loaded later.

> But, since I'm using udev I can't autoload it later
> (on demand) because there is no /dev/snd/seq file.

When alsa-lib cannot open /dev/snd/seq, it tries to open /dev/aloadSEQ
(minor number 1) to trigger the autoloading.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
