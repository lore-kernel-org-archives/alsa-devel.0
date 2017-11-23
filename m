From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 7/7] ASoC: wm8994: mark expected switch
	fall-throughs
Date: Thu, 23 Nov 2017 06:41:27 +0000
Message-ID: <20171123064127.rg5vuj76oqmftcvm@localhost.localdomain>
References: <cover.1510170034.git.garsilva@embeddedor.com>
 <94d7abf866dbcc4052a36ca14e53f1ff8aa30e83.1510170034.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 51387266CFB
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 07:41:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <94d7abf866dbcc4052a36ca14e53f1ff8aa30e83.1510170034.git.garsilva@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 08, 2017 at 02:04:43PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 402005
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
