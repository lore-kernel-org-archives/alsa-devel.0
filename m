From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Maximum buffer size on HDA
Date: Fri, 13 Jun 2008 21:13:03 +0200
Message-ID: <20080613191303.GA3899@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 74F0710381E
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 21:13:03 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Heya,

the HDA driver allows a playback buffer size of something like 64K
onyl. Is this a driver limitation or a limitation of the hardware?
Skimming through the docs I cannot see anything like this, and I got
the idea that the audio buffer is maintained in system memory, not
sound card memory, so why this limit?

I'd like to buffer more than 64K, especially for surround playback in
PA. Something like 2s or so. I am kind of disappointed I can't do this
right now on HDA.

Thanks,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
