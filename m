From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: maximum PCM DMA buffer sizes for PCI hw
Date: Sat, 7 Oct 2006 14:03:39 +0200
Message-ID: <20061007140339.09ed6a79.pochini@shiny.it>
References: <Pine.LNX.4.61.0610061002220.8573@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp-out12.alice.it (smtp-out12.alice.it [85.37.17.107])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 52948245
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Oct 2006 23:13:02 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0610061002220.8573@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 6 Oct 2006 10:16:20 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> Hi all,
> 
> 	while working on ALSA bug#2481 I figured that we do not allow to 
> setup large DMA buffers for hardware which is capable using that. I do not 
> think that it's right behaviour.

> echoaudio - 256KB - might be increased (?)

I pass default=128K and max=256K to snd_pcm_lib_preallocate_pages(), but
there are no hw limits. Most apps use a much smaller buffer to keep latency
low, so I though it was a reasonable size. I didn't want to waste too much
non-swappable memory. If you decide to raise the 256K limit, please let me
know, because I have to lower the .periods_max value (the s-g list stays in
one page, so if the buffer is too big, the s-g list may not fit in one page).


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
