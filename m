From: Mattia Dongili <malattia@linux.it>
Subject: Re: patch_realtek: support Vaio Type G
Date: Tue, 17 Nov 2009 07:47:56 +0900
Message-ID: <20091116224756.GA7504@kamineko.org>
References: <20091116140227.GA4386@kamineko.org> <s5hbpj2jzus.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.kamineko.org (static-220-247-10-204.b-man.svips.gol.ne.jp
	[220.247.10.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F1261037FE
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 23:48:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hbpj2jzus.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 16, 2009 at 03:42:03PM +0100, Takashi Iwai wrote:
> At Mon, 16 Nov 2009 23:02:27 +0900,
> Mattia Dongili wrote:
> > 
> > Hi Takashi,
> > 
> > my laptop (Vaio Type G) used to work (although the valume was pretty
> > low) with model=hippo until 2.6.29 then from 2.6.30 it stopped being
> > supported throwing this message:
> > hda-intel: azx_get_response timeout, switching to polling mode: last cmd=0x01570900
> 
> Still doesn't work 2.6.32-rc7 without your patch?

No, now tested on .32-rc7 and model=hippo still doesn't work. I have to
admit thought that I see

[  286.236022] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
[  286.236114] HDA Intel 0000:00:1b.0: setting latency timer to 64
[  287.392510] hda-intel: azx_get_response timeout, switching to polling mode: last cmd=0x015b8000

even with my patch. But at least I get sound.

Thanks
-- 
mattia
:wq!
