From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Remove obsolete cleanup
	for clientdata
Date: Fri, 09 Sep 2011 12:41:24 +0300
Message-ID: <2947540.kyBvp2XKE8@barack>
References: <1315558020.2332.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id EE4F6103AEC
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 11:41:28 +0200 (CEST)
Received: by mail-bw0-f43.google.com with SMTP id s6so1207089bka.30
	for <alsa-devel@alsa-project.org>; Fri, 09 Sep 2011 02:41:26 -0700 (PDT)
In-Reply-To: <1315558020.2332.0.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Friday 09 September 2011 16:47:00 Axel Lin wrote:
> The i2c core will clear the clientdata pointer automatically,
> we don't have to set the `data' field to NULL in remove() or
> if probe() failed anymore.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
