From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa virtual sound card (with networked output)
Date: Tue, 11 Jan 2011 17:33:58 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101111726040.28150@eeebox2.perex-int.cz>
References: <AANLkTinXD8u9riu9uwhJPsdKthUHDmK5K1o_+7vv4mcU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CBBA2444B
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:33:59 +0100 (CET)
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

On Tue, 11 Jan 2011, Metyl Methylius wrote:

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

I plan to add network support to the alsaloop utility (in the current 
repository of the alsa-utils package) using the snd-aloop loopback kernel
module on the playback (producer) side. This solution would be 100% 
transparent for all current ALSA apps. But I don't have any estimate when 
I start the work on this. Any volunteer? I think that it would be best to 
use the RTP UDP streaming.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
