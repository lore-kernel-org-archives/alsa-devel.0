From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] twl6040: fix wrong kfree in twl6040_remove
	and	twl6040_codec_remove
Date: Fri, 16 Jul 2010 10:36:25 +0100
Message-ID: <20100716093625.GD18376@sirena.org.uk>
References: <1279272408.2594.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 040B22441B
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 11:36:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279272408.2594.1.camel@mola>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 16, 2010 at 05:26:48PM +0800, Axel Lin wrote:
> Memory allocation part:
> We allocate a memory in twl6040_codec_probe():
>         priv = kzalloc(sizeof(struct twl6040_data), GFP_KERNEL);
>         twl6040_codec = codec = &priv->codec;

Could you please try to take on board the feedback you were given
yesterday about this sort of stuff?  Both the feedback about formatting
your patch so it's easy to apply and the collisions with other, more
substantial, work that's going on?
