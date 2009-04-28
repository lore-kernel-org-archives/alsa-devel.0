From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Fix gain control for
	earpiece amplifier
Date: Tue, 28 Apr 2009 14:56:48 +0300
Message-ID: <200904281456.49255.peter.ujfalusi@nokia.com>
References: <49F6C9CD.1020808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 957C724429
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 13:57:41 +0200 (CEST)
In-Reply-To: <49F6C9CD.1020808@samsung.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Joonyoung Shim <jy0922.shim@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "bhmin@samsung.com" <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 28 April 2009 12:18:05 ext Joonyoung Shim wrote:
> The gain control for earpiece amplifier uses 0dB ~ 12dB according to the
> TRM, but the present code is implemented to -6dB ~ 6dB.

You are right on this...

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
