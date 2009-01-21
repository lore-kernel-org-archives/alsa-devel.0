From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] cmi8330: add OPL3 support
Date: Wed, 21 Jan 2009 08:49:54 +0100
Message-ID: <4976D3A2.70608@ladisch.de>
References: <20090121081816.b3d1246b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7C6041037E3
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 08:49:58 +0100 (CET)
In-Reply-To: <20090121081816.b3d1246b.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Krzysztof Helt wrote:
> +		err = snd_opl3_timer_new(opl3, 0, 1);
> +		if (err < 0)
> +			return err;

Does this chip really have a working timer implementation?
(There is a timer test program in alsa-lib/test/.)


Best regards,
Clemens
