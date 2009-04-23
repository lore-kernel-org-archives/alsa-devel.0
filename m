From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 1/1] ASoC: TWL4030: Add VDL path support
Date: Thu, 23 Apr 2009 10:37:47 +0300
Message-ID: <200904231037.47874.peter.ujfalusi@nokia.com>
References: <49EE996E.40504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id F379D103835
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 09:38:19 +0200 (CEST)
In-Reply-To: <49EE996E.40504@samsung.com>
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

On Wednesday 22 April 2009 07:13:34 ext Joonyoung Shim wrote:
> Add DAPMs for VDL(Voice Down Link) path. To support VDL path, we have
> to change DAPMs of outputs(Earpiece, PreDrive Left/Right, Headset
> Left/Right, Carkit Left/Right) from mux to mixer.
>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---

Yes, this has been posted some time ago, I thought you gave up on it ;)
At the moment I don't have any means to actually test this particular patch, 
but after reading it through I think the comments given for the earlier series 
has been addressed with this. I don't see any particular reason why this can 
not be applied...

Mark commented a while ago about the AudioL1, AudioL2, AudioR1, AudioR2 naming 
to be changed to HiFiL1, etc, but I don't have any problems with the current 
naming, since it reflects the naming used in the TRM.


Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
