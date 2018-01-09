From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: Re: [PATCH][next] ASoC: TSCS42xx: make functions pll_event and
 dac_event static
Date: Tue, 9 Jan 2018 08:52:30 -0700
Message-ID: <20180109155227.xlg45ob3rqqme2yz@localhost.localdomain>
References: <20180108231444.8415-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180108231444.8415-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 08, 2018 at 11:14:44PM +0000, Colin King wrote:

> The functions pll_event and dac_event are local to the source and do
> not need to be in global scope, so make them static.

This looks good to me. Thanks for catching this. You can add:

Reviewed-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
