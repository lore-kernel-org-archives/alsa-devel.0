From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALI M5451 (CMI 9739): PCM always muted?
Date: Mon, 03 May 2004 10:04:34 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405031002250.11208-100000@studcom.urz.uni-halle.de>
References: <20040502101851.GB515@schottelius.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.Uni-Halle.DE [141.48.3.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA12336
	for <alsa-devel@alsa-project.org>; Mon, 3 May 2004 10:04:43 +0200
In-reply-to: <20040502101851.GB515@schottelius.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nico Schottelius <nico-linux-alsa@schottelius.org>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nico Schottelius wrote:
> anyone knows if there is the possibility to adjust sound volume or
> not.

CMI hardware doesn't have this capability.

It would be possible to write a plugin that scales sound data in
software before sending it to the device, but nobody has done this
yet.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
