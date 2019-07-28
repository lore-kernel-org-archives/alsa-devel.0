From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [PATCH v2 0/2] ALSA: usb-audio: fix PCM device
 order
Date: Sun, 28 Jul 2019 12:56:41 +0300
Message-ID: <f79b0618c66223e2df58e2fde619e0dcaadc549c.camel@iki.fi>
References: <20190727093006.9870-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
 [64.147.123.21])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6590DF803D5
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2019 11:56:50 +0200 (CEST)
In-Reply-To: <20190727093006.9870-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Alexander Tsoy <alexander@tsoy.me>
List-Id: alsa-devel@alsa-project.org

On Sat, 2019-07-27 at 11:30 +0200, Takashi Iwai wrote:
> Hi,
> 
> this is a rewrite of the old USB-audio fix patch I obviously
> overlooked to adapt to 5.3 kernel with a preliminary cleanup patch.
> 
> Totally untested, so any test / feedback would be appreciated.

Thanks for the patches! Unfortunately I can't test them, and the
reporter who prompted me to ping apparently isn't going to test them
either. Hopefully the patches are still relevant to Alexander so maybe
he could test them.

-- 
Tanu

https://www.patreon.com/tanuk
https://liberapay.com/tanuk
