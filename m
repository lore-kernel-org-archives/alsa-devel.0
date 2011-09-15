From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: uninitialized variable i used in
	wait_for_dc_servo
Date: Thu, 15 Sep 2011 10:54:28 +0100
Message-ID: <20110915095427.GB7988@opensource.wolfsonmicro.com>
References: <1316055154.3496.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9595310389B
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 11:54:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316055154.3496.6.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 10:52:34AM +0800, Axel Lin wrote:
> @@ -722,7 +723,7 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, u16 mask)
>  
>  		} else {
>  			msleep(1);
> -			if (--i) {
> +			if (--i == 0) {

You should avoid making random stylistic changes that aren't needed when
doing things like this.
