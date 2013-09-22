From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [RFC/RFT PATCH] ALSA: hda - hdmi: Add ATI/AMD
 multi-channel audio support
Date: Mon, 23 Sep 2013 00:14:11 +0300
Message-ID: <523F5DA3.6070103@iki.fi>
References: <1379872233-32210-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 371FB2650BD
 for <alsa-devel@alsa-project.org>; Sun, 22 Sep 2013 23:14:17 +0200 (CEST)
In-Reply-To: <1379872233-32210-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, =?UTF-8?B?UGV0ZXIgRnLDvGhiZXJnZXI=?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

Just a small update on a few things.

22.09.2013 20:50, Anssi Hannula kirjoitti:
[...]
> Since there is no ELD support (unless out-of-band communication with the
> graphics driver is added so that they can provide it to us directly),
> ELD is currently emulated with only the basic information populated
> (speaker mask, SADs, connection type). There are some bits missing on
> the radeon driver side (the SADs etc are not populated) so currently
> the ELD emulation only works on fglrx. ELD emulation is not needed for
> multi-channel playback.

Actually, it seems this support is already there in radeon open-source
driver. It was added in 3.11 for some chips and 3.12 for others. I
haven't tested yet, though.

[...]
> HBR mode (needed for DTS-HD/TrueHD passthrough) is not working yet, and
> the released documentation does not mention it.

I'm hearing we may get HBR docs soon. If so, I'll update the patch
accordingly at that time.

[...]
> +				/* in paired mode we need to take into account
> +				 * the occupied channel pairs instead of just the
> +				 * channel count */
> +				for (c = 0; c < 8; c++) {
> +					if (cap->speakers[c] || cap->speakers[c+1])
> +						chanpairs++;
> +				}

s/c++/c += 2/

That part is still untested though.

-- 
Anssi Hannula
