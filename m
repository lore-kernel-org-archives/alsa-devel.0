From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 0/7] snd-aoa: add snd-aoa
Date: Sun, 28 May 2006 21:00:26 +0200
Message-ID: <20060528190026.754474000@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CE472191
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 21:02:44 +0200 (MEST)
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
Cc: linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

The following patches would add snd-aoa to the Linux source tree. I'm
posting them here in the spirit of getting review fairly early, it works
fine for those machines it handles but has some rough edges like not
providing headphone detection at the moment.

There are plans to fix this, but they might be influenced by your comments
so I'm holding off there a bit. One thing that will probably be done is
moving all the alsa controls for various inputs from the codecs to the
fabric, the fabric needs to know these anyway and code can be simplified and
prepared for headphone/... detection if the codecs simply provide hooks to
turn on/off the various in- and outputs.

Any comments are appreciated.

Thanks,
johannes
