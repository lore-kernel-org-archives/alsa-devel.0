From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Add weak routes for sidetone style
	paths
Date: Mon, 13 Jun 2011 18:43:48 +0100
Message-ID: <4DF64C54.5030209@ti.com>
References: <1307980397-4035-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 30C5224340
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 19:43:57 +0200 (CEST)
In-Reply-To: <1307980397-4035-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 13/06/11 16:53, Mark Brown wrote:
> Normally DAPM will power up any connected audio path. This is not ideal
> for sidetone paths as with sidetone paths the audio path is not wanted in
> itself, it is only desired if the two paths it provides a sidetone between
> are both active. If the sidetone path causes a power up then it can be
> hard to minimise pops as we first power up either the sidetone or the main
> output path and then power the other, with the second power up potentially
> introducing a DC offset.
> 
> Address this by introducing the concept of a weak path. If a path is marked
> as weak then DAPM will ignore that path when walking the graph, though all
> the relevant controls are still available to the application layer to allow
> these paths to be configured.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc-dapm.h |    2 +
>  sound/soc/soc-dapm.c     |   87 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+), 0 deletions(-)

Acked-by: Liam Girdwood <lrg@ti.com>
