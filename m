From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ASoC: Intel: Fix incorrect sizeof() in
 sst_hsw_stream_get_volume()
Date: Wed, 16 Apr 2014 18:33:56 +0300
Message-ID: <20140416152815.GG4963@mwanda>
References: <20140413195636.32f31cb2@spike>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 74BDE26538B
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 17:34:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140413195636.32f31cb2@spike>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Engelmayer <cengelma@gmx.at>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 13, 2014 at 07:56:36PM +0200, Christian Engelmayer wrote:
> Fix an incorrect sizeof() usage in sst_hsw_stream_get_volume(). sst_dsp_read()
> is called to read into a variable of type u32, but is passed sizeof(u32 *) for
> argument 'size_t bytes'. Detected by Coverity: CID 1195260.
> 
> Signed-off-by: Christian Engelmayer <cengelma@gmx.at>

There are a couple others in this file.  I introduced one of them.  :(
Sorry about that.  I'll send a patch for that.

regards,
dan carpenter
