From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: alsa virtual sound card (with networked output)
Date: Wed, 12 Jan 2011 10:38:00 +0900
Message-ID: <AANLkTiku5K4fd8fgNQ7m=sywyB6VmK4UZyoQq8nVswQg@mail.gmail.com>
References: <AANLkTinXD8u9riu9uwhJPsdKthUHDmK5K1o_+7vv4mcU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id C25F924408
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 02:38:01 +0100 (CET)
Received: by bwz10 with SMTP id 10so129217bwz.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:38:01 -0800 (PST)
In-Reply-To: <AANLkTinXD8u9riu9uwhJPsdKthUHDmK5K1o_+7vv4mcU@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Metyl Methylius <the.metyl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 11:51 PM, Metyl Methylius <the.metyl@gmail.com> wrote:
> Hello everyone,
>
> I was wondering if its possible to just create a "virtual" sound card
> using alsa which will just sent its audio stream to other computer
> (using TCP/IP or UDP for example). On the other end there would be
> some kind of server (or just nc -u -l -p 31337 | aplay ). I want to do
> it on alsa layer because other aps using alsa will get immediate
> support.
>
> It should be something like described in
>
> http://alsa.opensrc.org/index.php/Network
>
> but with transparent support for all alsa based applications. I dont
> care about syncronization or transmission delay. Any pointers as how
> this could be done in alsa ?

If anything in kernel space, I'd suggest we have Audio-Over-Ethernet(AOE).
Audio-Over-IP(AOIP) isn't much useful for commercial application requiring
low-latencies, besides that can be done from User-Space like PulseAudio.
