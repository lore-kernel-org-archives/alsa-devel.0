From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: Re: SALSA-Lib: Playback overrun on initial PCM start
Date: Fri, 29 Jun 2007 13:16:12 -0400
Message-ID: <20070629131612.6365191c.alsauser@pragmasoft.com>
References: <20070628150108.271f4493.alsauser@pragmasoft.com>
	<s5hmyyjcdtv.wl%tiwai@suse.de>
	<20070629112409.27e67cea.alsauser@pragmasoft.com>
	<s5hbqeyd9s7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.server.rpi.edu (smtp6.server.rpi.edu [128.113.2.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 72AC310380F
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2007 19:13:06 +0200 (CEST)
In-Reply-To: <s5hbqeyd9s7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Jun 2007 18:07:20 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> OK, looks like a bug in salsa-lib, then.
> I fixed some remaining bugs and release 0.0.4 now.  Please give it a
> try.  (Note that it might take some time until the ftp server is
> exported / mirrored.)

Much better :)

I no longer get the PlayBack overrun on PCM start.  However, it appears
that "poll" or the snd_pcm_sw_params_set_avail_min (=4096) is not being
properly honored.  With the normal alsa-lib, when the "poll" returns
snd_pcm_avail_update reports that space is available for 4096 frames.
However, in my initial testing, when running with SALSA lib, only about
100 frames or so are available when the poll returns.

I will examine this more closely.
