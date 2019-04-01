From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: soundwire: Ensure that code is inside
 the code blocks
Date: Mon, 1 Apr 2019 15:40:03 -0600
Message-ID: <20190401154003.7eddc9e9@lwn.net>
References: <20190331223423.29855-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190331223423.29855-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc: linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon,  1 Apr 2019 00:34:22 +0200
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> The way the document is written now, Sphinx renders empty code blocks
> followed by the lines that should be inside them.
> 
> Unindent the code-block directives to fix this.
> 
> Fixes: 502c00d9c315 ("Documentation: soundwire: fix stream.rst markup warnings")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

That definitely makes things better.  Applied, thanks.

I'm going to take out the Fixes tag, though, since the named commit did
not, in fact, introduce that problem.  It's also good to copy authors of
patches named in Fixes tags so they can defend themselves :)

Thanks,

jon
