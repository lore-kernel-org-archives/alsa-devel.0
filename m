From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: ssm2518: Fix off-by-one error by
	ffs()
Date: Wed, 01 Jan 2014 16:42:39 +0100
Message-ID: <52C4376F.7000809@metafoo.de>
References: <1387795375-17083-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-079.synserver.de (smtp-out-181.synserver.de
 [212.40.185.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 598C22610A9
 for <alsa-devel@alsa-project.org>; Wed,  1 Jan 2014 16:42:19 +0100 (CET)
In-Reply-To: <1387795375-17083-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/23/2013 11:42 AM, Takashi Iwai wrote:
> ffs() returns the bit position from 1, while the ssm2158 driver code
> assumes it being 0-based.  Also, the bit mask computation of the two
> channel slots are incorrect; it must have worked just casually.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
