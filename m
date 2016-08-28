From: Joe Perches <joe@perches.com>
Subject: Misuses of ** ? (was Re: [PATCH 1/1] ASoC: Intel: Atom: add a
 missing star in a memcpy call)
Date: Sun, 28 Aug 2016 10:50:36 -0700
Message-ID: <1472406636.26978.95.camel@perches.com>
References: <20160828173945.27721-1-nicolas.iooss_linux@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160828173945.27721-1-nicolas.iooss_linux@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Iooss <nicolas.iooss_linux@m4x.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Julia Lawall <julia.lawall@lip6.fr>, Dan Capenter <error27@gmail.com>
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2016-08-28 at 19:39 +0200, Nicolas Iooss wrote:
> In sst_prepare_and_post_msg(), when a response is received in "block",
> the following code gets executed:
> 
>     *data = kzalloc(block->size, GFP_KERNEL);
>     memcpy(data, (void *) block->data, block->size);

Yuck, thanks.

Julia, Dan, could cocci or smatch help find any other
similar misuses here?
