From: "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] snd_pcm_hw_params_set_rate_near val pointer
Date: 02 Mar 2004 12:47:36 -0600
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <87smgrdr1z.fsf@sulphur.joq.us>
References: <Pine.LNX.4.30.0403020021360.12748-200000@gwyn.tux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.30.0403020021360.12748-200000@gwyn.tux.org>
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Samuel S Chessman <chessman@tux.org>
Cc: "[jackit-devel]" <jackit-devel@lists.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Samuel S Chessman <chessman@tux.org> writes:

> In building and running jack 0.94 from current tar, segfault traced to
> alsa_driver at snd_pcm_hw_params_set_rate_near (line 388).
> 
> This occurs when switching to 16 bit or starting with 16 bit (-S option)
> 
> This is caused by snd_pcm_hw_params_set_rate_near parameter val needing
> to be a pointer, and alsa_driver passing in the frame rate instead.
>
> This occurs against current CVS of alsa. (2004-03-02)

I think this is the wrong fix, Sam.

Apparently, that parameter was changed in ALSA between 0.9 and 1.0.
For compatibility with the maximum number of systems, the JACK
alsa_driver is still compiled using ALSA_PCM_OLD_HW_PARAMS_API, which
selects the older (non-pointer) interface.

So, maybe this is an ALSA bug in emulating the older interface?

The patch you sent breaks JACK users still running ALSA 0.9, AFAICT.
It does at least generate this compiler warning...

  alsa_driver.c: In function `alsa_driver_configure_stream':
  alsa_driver.c:394: warning: passing arg 3 of `snd_pcm_hw_params_set_rate_near' makes integer from pointer without a cast

I am copying this response to alsa-devel.  If I'm wrong, someone there
will probably set me straight.  :-)
-- 
  joq


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
