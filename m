From: Timur Tabi <timur@freescale.com>
Subject: Re: Confused about 'default' device
Date: Tue, 23 Oct 2007 15:45:10 -0500
Message-ID: <471E5D56.6010306@freescale.com>
References: <471E4E2A.9090105@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F75224A70
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Oct 2007 22:45:16 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9NKjCQZ005815
	for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2007 13:45:13 -0700 (MST)
In-Reply-To: <471E4E2A.9090105@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> I'm having a hard time understand when ALSA does sample rate and format 
> conversion, and when it doesn't.

Some more info:

I'm trying to play a movie with 441000 Hz audio.

If I specify "-ao alsa", mplayer calls snd_pcm_hw_params_set_rate_near() with a 
value of 44100.  The call fails and returns an error code.

If I specify "-ao alsa:device=hw=0.0", snd_pcm_hw_params_set_rate_near() does 
not fail, even though it's being passed the same parameters.

So what is it about the default device that makes 
snd_pcm_hw_params_set_rate_near() fail?
