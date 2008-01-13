From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Sun, 13 Jan 2008 01:01:50 -0200
Message-ID: <5f52f6d70801121901p739c8ab2rd3755c8d21047db2@mail.gmail.com>
References: <BAY109-W329D5BB94B8FE49792D1C4A9440@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id E3E82248E6
	for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2008 04:01:53 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1161489rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2008 19:01:50 -0800 (PST)
In-Reply-To: <BAY109-W329D5BB94B8FE49792D1C4A9440@phx.gbl>
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
To: De Fuuss <fuuss@hotmail.com>
Cc: Jiang zhe <zhe.jiang@intel.com>, ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2008/1/12 De Fuuss <fuuss@hotmail.com>:

> I get the uneasy feeling that something is messed up with this board. Anyway, for completeness' sake, I attached the results of amixer contents, cat /proc/asound/card0/codec#0 and dmesg for the module loaded as 6stack-dig. I have to try 6stack-hp again to confirm if I get something there.

I fixed the Inspiron output, and I'm adding the SG33G5M codec to the
codecgraph codecs collection (git repository at
http://helllabs.org/git/codecgraph.git). If nodes 0x14, 0x15, 0x16 and
0x17 are the front, rear, clfe and side connectors in the back panel,
6stack-hp should work (at least for the outputs). You can test the
outputs using "speaker-test -Dplug:surround71 -c8 -sX" (where X varies
from 1 to 8) and a pair of headphones.
