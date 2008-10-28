From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Remove unused variable 'codec'
	from	sound/soc/codecs/tlv320aic23.c
Date: Tue, 28 Oct 2008 10:05:11 +0000
Message-ID: <20081028100510.GB9068@sirena.org.uk>
References: <dfeb90390810280003i5a5171fam2f8bc6627dc1b4ab@mail.gmail.com>
	<s5h7i7t6vvj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BC5A924356
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 11:05:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7i7t6vvj.wl%tiwai@suse.de>
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
Cc: Manish Katiyar <mkatiyar@gmail.com>, alsa-devel@alsa-project.org, troy.kisky@boundarydevices.com, Arun KS <arunks@mistralsolutions.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2008 at 08:07:12AM +0100, Takashi Iwai wrote:
> Arun KS wrote:

> > Troy has got some patch which adds support for more mclk frequencies.
> > So that variable will be required.

> Please let me know the state of Troy's patch.
> If his fix is to be merged to 2.6.28 kernel, then I'll keep the code
> as is.  If it's for the next kernel (2.6.29), I'll fix this warning
> now.

Adding additional MCLK frequencies would normally be a new feature and
non-mergable.  OTOH, it's a new driver and the changes shouldn't be
invasive.
