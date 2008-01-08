From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Disabling buffer fill level preprocessing by ALSA
Date: Tue, 8 Jan 2008 01:03:02 +0100
Message-ID: <20080108000302.GA19547@tango.0pointer.de>
References: <20071231171226.GA17953@tango.0pointer.de>
	<4782759B.5000208@superbug.co.uk>
	<20080107202104.GB31128@tango.0pointer.de>
	<4782A8F8.8080609@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A72B624A40
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 01:03:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4782A8F8.8080609@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 07.01.08 22:34, James Courtier-Dutton (James@superbug.co.uk) wrote:

> Are you going to be at FOMS. It might be easier to explain to you there.
> You are making assumptions about sound cards that might be wrong. E.g. 
> 2secs hw buffer for instance.

Yes, I will be at FOMS.

I ask for 2s of hw buffer, I take whatever ALSA gives me. If ALSA
cannot fulfil this request I am happy and take whatever I get. 

Also, if clock_getres() tells me that hrtimers are not available, or
when I cannot enable mmap mode for a device, I don't do
system-timer-based scheduling at all, instead I fall back to use a fixed
period size, the way ALSA suggests it.

I am not aware that I make any assumptions of the ALSA API that are not documented, besides:

- That I can fully (as in "what is in the hw buf and still unplayed")
  rewind a playback buffer from the front:0,
  surround40:, surround50:, surround41:, surround51: and surround71:
  devices when I managed to open them in mmap mode.

- That snd_pcm_sw_params_set_stop_threshold(.. , (snd_pcm_uframes_t) -1))
  disables automatic starting of the device.

- That snd_pcm_sw_params_set_start_threshold(.. , (snd_pcm_uframes_t) -1))
  disables automatic stopping on underrun.

- That snd_pcm_sw_params_set_avail_min(.. , INT_MAX) will never mark
  the PCM fd as ready in poll().

- That the mixer device for a device surround51:0 is called hw:0 

Which seem all pretty reasonable to me, and based on comments from
Takashi or Jaroslav on the ML, or by looking into the source code.

What other assumptions do you believe I am making that might be invalid?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
