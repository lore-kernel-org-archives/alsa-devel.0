From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] usb/caiaq: decrease period_bytes_min
Date: Thu, 24 Jan 2008 19:00:09 +0100
Message-ID: <20080124180009.GB12888@buzzloop.caiaq.de>
References: <20080124174407.GA12888@buzzloop.caiaq.de>
	<s5habmv2k1t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 93666243BC
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 19:00:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5habmv2k1t.wl%tiwai@suse.de>
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

On Thu, Jan 24, 2008 at 06:46:38PM +0100, Takashi Iwai wrote:
> > This patch increases the snd_pcm_hardware->period_bytes_min field in the
> 
> decrease, right? :)

On closer examination, 128 is actually less than 4096, yes. Except for
very large values of 128. ;)

Daniel
