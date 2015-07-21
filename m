From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ASoC: max98925: reading beyond the end of
	the array
Date: Tue, 21 Jul 2015 13:57:43 +0300
Message-ID: <20150721105743.GO5422@mwanda>
References: <20150721085527.GA22070@mwanda>
 <20150721104350.GP11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id BA96D26071F
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 12:57:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150721104350.GP11162@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Anish Kumar <yesanishhere@gmail.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 21, 2015 at 11:43:50AM +0100, Mark Brown wrote:
> On Tue, Jul 21, 2015 at 11:55:27AM +0300, Dan Carpenter wrote:
> > Debug prints are seldom useful and this one has an annoying thing where
> > it reads one space beyond the end of the array on error.
> 
> It's a pretty big stretch to say that debug prints are rarely useful...

I asked Anish if it was worth fixing and he said to delete it.

regards,
dan carpenter
