From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: safe support for rewind in ALSA
Date: Mon, 15 Feb 2010 11:03:36 +0800
Message-ID: <4f3252891002141903q34144f58n60978e28e65640b4@mail.gmail.com>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
	<alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
	<4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
	<4B72B665.3060903@ladisch.de>
	<4f3252891002102252vb6d7a94l76fb78e33da37775@mail.gmail.com>
	<4B73AFD5.4080205@ladisch.de>
	<alpine.LNX.2.00.1002110822480.19278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f171.google.com (mail-pz0-f171.google.com
	[209.85.222.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ED25244D8
	for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2010 04:03:38 +0100 (CET)
Received: by pzk1 with SMTP id 1so3332432pzk.16
	for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2010 19:03:37 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002110822480.19278@eeebox2.perex-int.cz>
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

2010/2/11 Jaroslav Kysela <perex@perex.cz>

> On Thu, 11 Feb 2010, Clemens Ladisch wrote:
>
> >> Do you mean that PA only wake up once when configure sound card to use
> two
> >> periods per buffer ?
> >
> > When using two periods per buffer, ALSA tries to wake up PA two times.
> > However, PA ignores the sound card's interrupts and is woken up by its
> > own timer.
>
> PA can drive the wake-ups using avail_min sw parameter. If this value is
> high enough, no userspace wake up is called, only interrupt is processed
> and internal ring buffer pointers in the driver are updated.
>
>                                        Jaroslav
>

Even using a high resolution timer , the application still cannot achieve
latency better than the configured period size

For USB case , the driver cannot give accurate hw pointer position , hw
pointer increase in steps for the current implementation, (i.e. the graph is
a stepping fuction if you plot the position of hardware pointer against time
elasped ) .

This mean that the wake up time cannot be calculated using as number of
sample/rate since the fuction is not linear especially when using max buffer
size , min period --> max period size is much greater than the watermark

The glitch is most likely underrun,

Refer to

http://thread.gmane.org/gmane.linux.alsa.devel/60371/focus=60535

The delay value cannot be used for buffer filling, of course (also in
standard - no-XRUN case - avail functions should be used).
