From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: safe support for rewind in ALSA
Date: Sun, 21 Feb 2010 12:35:07 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1002211208120.3327@ecabase.localdomain>
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
	<4f3252891002141903q34144f58n60978e28e65640b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw02.mail.saunalahti.fi (gw02.mail.saunalahti.fi
	[195.197.172.116])
	by alsa0.perex.cz (Postfix) with ESMTP id C3DB8103805
	for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2010 11:38:24 +0100 (CET)
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

Hi,

On Mon, 15 Feb 2010, Raymond Yau wrote:

> Even using a high resolution timer , the application still cannot achieve
> latency better than the configured period size
>
> For USB case , the driver cannot give accurate hw pointer position , hw
> pointer increase in steps for the current implementation, (i.e. the graph is

... but that's a real hardware limitation for the USB-driver, right? And 
even in the USB case, hw pointer is incremented in steps of URB transfer 
size, so even in this case, latency of a highres timer based application 
is not limited by the set period-size.

Of course, there is no ALSA API to query the burst size (e.g. the 
granularity of hw_ptr updates), which is a real problem for generic apps 
(that are not hardcoded to work with just one ALSA driver).

But you can query the SNDRV_PCM_INFO_BATCH flag (it's set by e.g. the USB 
driver) and adjust your hrtimer-based application's logic based on that 
(if set, assume hw_ptr will jump in bursts). I know, not really ideal (you 
essentially have to e.g. disable PA glitch-free for these cards 
currently).

> This mean that the wake up time cannot be calculated using as number of
> sample/rate since the fuction is not linear especially when using max buffer
> size , min period --> max period size is much greater than the watermark

Yep, that's what SNDRV_PCM_INFO_BATCH flag warns you about.
