From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: obtaining timestamps from sequencer events
Date: Tue, 21 Dec 2004 10:13:20 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0412211011120.1746@pnote.perex-int.cz>
References: <20041221090854.16216.qmail@web51904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AA03D24E
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2004 10:16:47 +0100 (MET)
In-Reply-To: <20041221090854.16216.qmail@web51904.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michael Geis <michaelgeis11@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 21 Dec 2004, Michael Geis wrote:

> Hello. I wanted to add recording capability to my module to have an
> additional way of "importing" musical scores. One of Dr. Mathias
> Nagorni's examples shows exactly how to retrieve events from an external
> device. I get stuck, though, when I want to retrieve timestamps from
> those events. Following is a minimal program that sets up a connection
> to an external keyboard (72:0 in my case) and polls events. The problem
> lies in the fact that the time of of the incoming events is always zero.

You must set what kind of timestamp you need. See:

snd_seq_port_info_set_timestamping()
snd_seq_port_info_set_timestamp_real()
snd_seq_ev_timestamp_type()
snd_seq_ev_is_tick()
snd_seq_ev_is_real()

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
