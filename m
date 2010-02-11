From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: safe support for rewind in ALSA
Date: Thu, 11 Feb 2010 08:27:25 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002110822480.19278@eeebox2.perex-int.cz>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<20100201180139.GC15509@sirena.org.uk>
	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
	<alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
	<4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
	<4B72B665.3060903@ladisch.de>
	<4f3252891002102252vb6d7a94l76fb78e33da37775@mail.gmail.com>
	<4B73AFD5.4080205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D8787243CA
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 08:27:25 +0100 (CET)
In-Reply-To: <4B73AFD5.4080205@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Feb 2010, Clemens Ladisch wrote:

>> Do you mean that PA only wake up once when configure sound card to use two
>> periods per buffer ?
>
> When using two periods per buffer, ALSA tries to wake up PA two times.
> However, PA ignores the sound card's interrupts and is woken up by its
> own timer.

PA can drive the wake-ups using avail_min sw parameter. If this value is 
high enough, no userspace wake up is called, only interrupt is processed 
and internal ring buffer pointers in the driver are updated.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
