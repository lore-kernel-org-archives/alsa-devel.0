From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/3] ASoC: wm9713: Use empty struct
	initializer
Date: Wed, 14 Feb 2018 15:48:52 +0000
Message-ID: <20180214154852.m36xmn54nzxmwbbh@localhost.localdomain>
References: <1518622745-12162-1-git-send-email-festevam@gmail.com>
 <1518622745-12162-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 133F2267193
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 16:48:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1518622745-12162-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 14, 2018 at 01:39:04PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> { 0 } only clears the first member of the structure.
> 
> The first member of the snd_soc_dapm_update struct is a pointer,
> and writing 0 to a pointer results in a sparse warning.
> 
> Use the empty struct initializer that clears all the struct members
> and fixes the sparse warning.
> 
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
