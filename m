From: De Fuuss <fuuss@hotmail.com>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Sun, 13 Jan 2008 18:06:29 +0000
Message-ID: <BAY109-W299C00A390D5FBCF60AF6BA9450@phx.gbl>
References: <BAY109-W329D5BB94B8FE49792D1C4A9440@phx.gbl>
	<5f52f6d70801121901p739c8ab2rd3755c8d21047db2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s15.bay0.hotmail.com (bay0-omc3-s15.bay0.hotmail.com
	[65.54.246.215]) by alsa0.perex.cz (Postfix) with ESMTP id 71EB224A06
	for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2008 19:06:30 +0100 (CET)
In-Reply-To: <5f52f6d70801121901p739c8ab2rd3755c8d21047db2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Claudio Matsuoka <cmatsuoka@gmail.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Following your advice, I tested per channel output. Using either 6stack-dig or 6stack-hp, I get noise from Front Left and Right jacks, using speaker-test (X=1 and 2) but not on any other channels.

Patrick

> Date: Sun, 13 Jan 2008 01:01:50 -0200
> From: cmatsuoka@gmail.com
> To: fuuss@hotmail.com
> CC: zhe.jiang@intel.com; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] intel-hd on an intel G33 motherboard
>
> 2008/1/12 De Fuuss :
>
>> I get the uneasy feeling that something is messed up with this board. Anyway, for completeness' sake, I attached the results of amixer contents, cat /proc/asound/card0/codec#0 and dmesg for the module loaded as 6stack-dig. I have to try 6stack-hp again to confirm if I get something there.
>
> I fixed the Inspiron output, and I'm adding the SG33G5M codec to the
> codecgraph codecs collection (git repository at
> http://helllabs.org/git/codecgraph.git). If nodes 0x14, 0x15, 0x16 and
> 0x17 are the front, rear, clfe and side connectors in the back panel,
> 6stack-hp should work (at least for the outputs). You can test the
> outputs using "speaker-test -Dplug:surround71 -c8 -sX" (where X varies
> from 1 to 8) and a pair of headphones.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
