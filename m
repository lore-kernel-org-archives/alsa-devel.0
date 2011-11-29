From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC: Dynamic CODEC DAI
Date: Tue, 29 Nov 2011 15:20:43 -0600
Message-ID: <12599.1035638892$1322601685@news.gmane.org>
References: <4ED42C0E.2080300@codeaurora.org>
	<000001ccae35$0122cf60$03686e20$@bossart@linux.intel.com>
	<4ED47847.7020206@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A1E7F103A90
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 22:20:44 +0100 (CET)
In-Reply-To: <4ED47847.7020206@codeaurora.org>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Patrick Lai' <plai@codeaurora.org>
Cc: 'alsa-devel' <alsa-devel@alsa-project.org>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> Please excuse my lack of understanding about AC97. There is a codec
> driver /sound/soc/codec/ac97.c. However, only one DAI is defined and
> supports both playback/capture with 2 as max channels. I don't see how
> static CODEC DAI definition is going to satisfy my requirements. I am
> still bounded to DAI link structure definition which takes only one
> CODEC DAI. In this case with ac97.c, I am still limited to work with
> pre-defined CODEC DAI in ac97.c  Is there an example for grouping ac97
> channels?

In theory AC97 can convey multiple slots (12 if I am not mistaken). It's
somewhat similar to SLIMbus, but with a fixed slot allocation, no bit clock
scalability and it's not truly bidirectional. The limitation to stereo
reflects codec limitations, not the standard.
