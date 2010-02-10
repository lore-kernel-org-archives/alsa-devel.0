From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: safe support for rewind in ALSA
Date: Wed, 10 Feb 2010 21:19:01 +0800
Message-ID: <4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<20100201180139.GC15509@sirena.org.uk>
	<alpine.LNX.2.00.1002011903330.25340@eeebox2.perex-int.cz>
	<alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
	<alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
	<alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 110A0244C7
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 14:19:02 +0100 (CET)
Received: by pzk36 with SMTP id 36so9786099pzk.23
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 05:19:02 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
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

2010/2/10 Kai Vehmanen <kvehmanen@eca.cx>

> Hi,
>
>
> On Tue, 9 Feb 2010, Raymond Yau wrote:
>
>
>  why do PA insist to use one period per buffer when only those ISA drivers
>> and intel8x0 have periods_min =1 , the most common HDA driver and most
>> sound
>> cards have periods_min =2 ?
>>
>
> That is discussed at length here:
> http://0pointer.de/blog/projects/pulse-glitch-free.html
>


most of the motherboard which have ISA bus for the ISA sound card did not
have high resolution timer ( PA glitch free mode require high resolution
timer )

The rest of those sound cards which have period_mins = 1 are regarded as
broken by PA developer  (e.g. intel8x0 ,emu10k1 , ens1371 , ... ) and aplay
did not work with one period per buffer too.

what is the hardware requirement for the driver to support one period per
buffer ?

if none of the those driver can be fixed

 why don't we change the period_min of all those broken drivers from 1 to 2
?
