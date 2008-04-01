From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Detecting new alsa sequencer clients (with some
 event loop) so that i can subscribe them
Date: Tue, 01 Apr 2008 09:01:50 +0200
Message-ID: <47F1DDDE.5090703@ladisch.de>
References: <20080401034801.7ad2696d.chromisx@nedlinux.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 66E5E2436E
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Apr 2008 09:02:18 +0200 (CEST)
In-Reply-To: <20080401034801.7ad2696d.chromisx@nedlinux.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "R. Dresens" <chromisx@nedlinux.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

R. Dresens wrote:
> I'm currently writing an application that will be able to 'auto
> subscribe' itself to a certain sequencer client when that client
> becomes available to the system. I want (for example) to be able to
> plug in a USB MIDI interface, and when I do that then my application
> detects this and does a subscription on it, just like aconnect would
> do.
>
> A possible solution is polling; every second or so, i could generate a
> list of clients with snd_seq_query_next_client and look for a certain
> client name (libpcre comes to mind here;), but I was wondering if there
> is a better solution? ..in other words, is it possible to get such
> events from the system in a similar way like one would receive regular
> MIDI events?

Subscribe to SND_SEQ_CLIENT_SYSTEM:SND_SEQ_PORT_SYSTEM_ANNOUNCE.
Try "aseqdump -p 0:1" to see what events you get.


HTH
Clemens
