From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ALSA: asihpi: fix an information leak in
 asihpi_hpi_ioctl()
Date: Mon, 5 Jan 2015 12:33:22 +0300
Message-ID: <20150105093322.GA15033@mwanda>
References: <20141222074946.GA9737@mwanda>
 <s5hmw6ais9g.wl-tiwai@suse.de>
 <54A25D49.4000502@blennerhassett.gen.nz>
 <54A3972B.5010703@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54A3972B.5010703@blennerhassett.gen.nz>
Sender: kernel-janitors-owner@vger.kernel.org
To: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 31, 2014 at 07:26:51PM +1300, Eliot Blennerhassett wrote:
> Add missing limits to keep copied data within allocated buffer.
> 

Could you give me a Reported-by tag for this?

regards,
dan carpenter

