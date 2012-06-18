From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: Add snd_pcm_rate_bit_to_rate()
Date: Mon, 18 Jun 2012 10:47:03 +0100
Message-ID: <20120618094703.GA620@opensource.wolfsonmicro.com>
References: <1339774528-12358-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<s5hd34xm5d8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59611104176
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2012 11:47:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd34xm5d8.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 18, 2012 at 09:44:19AM +0200, Takashi Iwai wrote:
> At Fri, 15 Jun 2012 16:35:28 +0100,
> Dimitris Papastamos wrote:
> > 
> > This is essentially the reverse of snd_pcm_rate_to_rate_bit().
> > 
> > This is generally useful as the Compress API uses the rate bit
> > directly and it helps to be able to map back to the actual sample
> > rate.
> > 
> > Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> 
> Applied to topic/misc branch of sound git tree.
> If this change is necessary, simply pull that branch.

Thanks!
