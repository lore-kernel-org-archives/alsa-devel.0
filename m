From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 01/01] alsa: sound/soc/pxa/pxa2xx_pcm.c,
	check and set	invalid dma_ch to be <= to 0 in pxa2xx_pcm_hw_free()
Date: Sat, 20 Dec 2008 13:10:20 +0000
Message-ID: <20081220131019.GB6859@sirena.org.uk>
References: <494C8816.20802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 67A6F1037E3
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 14:10:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <494C8816.20802@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sware <microcontrolfreak@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, stephen.ware@eqware.net, ALSA project mailing list <alsa-devel@alsa-project.org>, Dennis O'Brien <dennis.obrien@eqware.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 19, 2008 at 09:52:22PM -0800, sware wrote:

> From: Stephen Ware <stephen.ware@eqware.net>, Dennis O'Brien <dennis.obrien@eqware.net>

...

> Signed-off-by: Dennis O'Brien <dennis.obrien@eqware.net>

The patch itself is good but could you please clarify what's going on
with the author and signoff lines (apart from anything else the multiple
authors appears to be confusing git, it's ignoring Dennis).

The combination of git format-patch and send-email is handy for
generating something that applies easily.
