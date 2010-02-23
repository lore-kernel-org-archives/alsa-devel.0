From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: safe support for rewind in ALSA
Date: Tue, 23 Feb 2010 10:44:22 +0800
Message-ID: <4f3252891002221844o46844423x92b275d36640b127@mail.gmail.com>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
	<alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
	<4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
	<4B72B665.3060903@ladisch.de>
	<4f3252891002102252vb6d7a94l76fb78e33da37775@mail.gmail.com>
	<4B73AFD5.4080205@ladisch.de>
	<alpine.LNX.2.00.1002110822480.19278@eeebox2.perex-int.cz>
	<4f3252891002141903q34144f58n60978e28e65640b4@mail.gmail.com>
	<alpine.DEB.1.10.1002211208120.3327@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id DFA93244DA
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 03:44:23 +0100 (CET)
Received: by pwi9 with SMTP id 9so2891675pwi.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 18:44:22 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1002211208120.3327@ecabase.localdomain>
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

2010/2/21 Kai Vehmanen <kvehmanen@eca.cx>

> Hi,
>
>
> On Mon, 15 Feb 2010, Raymond Yau wrote:
>
>  Even using a high resolution timer , the application still cannot achieve
>> latency better than the configured period size
>>
>> For USB case , the driver cannot give accurate hw pointer position , hw
>> pointer increase in steps for the current implementation, (i.e. the graph
>> is
>>
>
> ... but that's a real hardware limitation for the USB-driver, right? And
> even in the USB case, hw pointer is incremented in steps of URB transfer
> size, so even in this case, latency of a highres timer based application is
> not limited by the set period-size.
>
>
I guess alsa pulse plugin also has the same problem since the value returned
by pointer callback of the pulse device is also not accurate
