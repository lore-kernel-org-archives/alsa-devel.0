From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Help with ALSA application development
Date: Thu, 12 Jul 2007 09:00:22 +0200
Message-ID: <1184223622.7360.1199760151@webmail.messagingengine.com>
References: <61c0054e0707111455j6981b200s883e82bf8b0a87bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 333C41037F3
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 09:00:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61c0054e0707111455j6981b200s883e82bf8b0a87bd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Kavan wrote:
> Does anyone know of some sample code for S8 formatted,
> 8k rate capture and playback.

Have a look at test/pcm_min.c in the alsa-lib package.

You cannot use hw_params after calling snd_pcm_hw_params_free().


HTH
Clemens
