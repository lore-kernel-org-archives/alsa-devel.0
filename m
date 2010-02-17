From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: safe support for rewind in ALSA
Date: Wed, 17 Feb 2010 16:46:56 +0100
Message-ID: <20100217154656.GF6891@tango.0pointer.de>
References: <alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
	<alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
	<4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
	<4B72B665.3060903@ladisch.de>
	<4f3252891002102252vb6d7a94l76fb78e33da37775@mail.gmail.com>
	<4B73AFD5.4080205@ladisch.de>
	<alpine.LNX.2.00.1002110822480.19278@eeebox2.perex-int.cz>
	<4f3252891002141903q34144f58n60978e28e65640b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A58C7103871
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 16:47:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4f3252891002141903q34144f58n60978e28e65640b4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 15.02.10 11:03, Raymond Yau (superquad.vortex2@gmail.com) wrote:

> For USB case , the driver cannot give accurate hw pointer position , hw
> pointer increase in steps for the current implementation, (i.e. the graph is
> a stepping fuction if you plot the position of hardware pointer against time
> elasped ) .

The granularity of write transfer blocks and of playback pointer
updates is currently not quriable nor configurable in ALSA. We only
have periods which tries to cover both in a way.

For the use in PA it is really important to get better APIs for
this. Ideally both for querying the latency and the transfer
granularityand configuring it, but most importantly for querying it.

This has been discussed before on this mailing list, btw.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
