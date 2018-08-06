From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 12/12] ASoC: wm8903: use true and false for
	boolean values
Date: Mon, 6 Aug 2018 10:42:53 +0100
Message-ID: <20180806094253.GK18740@imbe.wolfsonmicro.main>
References: <cover.1533418275.git.gustavo@embeddedor.com>
 <a5b8afe476543dc45d3049b72b5dc718fbe1a010.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 9423A267822
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 11:42:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a5b8afe476543dc45d3049b72b5dc718fbe1a010.1533418275.git.gustavo@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 04, 2018 at 04:56:02PM -0500, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
