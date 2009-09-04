From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: Is there a way to figure out if the clocks of two
	snd_pcm_t's deviate? (snd_pcm_info_get_sync?)
Date: Fri, 4 Sep 2009 07:52:51 -0500
Message-ID: <6160a5130909040552k34548733o3d2fc71e1a7362c8@mail.gmail.com>
References: <20090903230351.GA7493@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 27FA4244BB
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 14:52:52 +0200 (CEST)
Received: by pzk36 with SMTP id 36so776457pzk.7
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 05:52:51 -0700 (PDT)
In-Reply-To: <20090903230351.GA7493@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> I am looking for a way to find out whether the clocks of two
> snd_pcm_t's are perfectly in sync and don't deviate (or only deviate
> by a constant phase).

short answer:no
You would need hardware that would count the bit clock transitions and
provide the delta. Few devices provide this in the consumer space, and
when they do they actually perform an asynchronous sample-rate
conversion on the fly (cf. Freescale DSP563xx). Analog Devices also
provides dedicated sample-rate converters that perform this comparison
and resampling; they are typically used when multiple masters are
present.
All this nice hardware wouldn't work anyway for USB where audio is
transmitted in packets every ms; it's hard to guess what the real
audio speed is.
That's the reason why I introduced the resampling enable/disable in
the PA module-loopback code, only the user/system designer will know
if you have one master or more, and whether you should enable
variable-rate interpolation.
Cheers
- PL
