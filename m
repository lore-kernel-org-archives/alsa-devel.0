From: Maarten Baert <maarten-baert@hotmail.com>
Subject: Re: Audio passthrough on Pandaboard using ALSA API
Date: Fri, 28 Feb 2014 22:53:40 +0100
Message-ID: <BLU0-SMTP1962DEBCF39E61EE38F75C4E2820@phx.gbl>
References: <918abfafedb24121b6e6f66e46b9b000@BY2PR06MB581.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s20.blu0.hotmail.com (blu0-omc3-s20.blu0.hotmail.com
 [65.55.116.95]) by alsa0.perex.cz (Postfix) with ESMTP id 2D22A2651FD
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 22:53:45 +0100 (CET)
In-Reply-To: <918abfafedb24121b6e6f66e46b9b000@BY2PR06MB581.namprd06.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Vadimi@wavesglobal.com
List-Id: alsa-devel@alsa-project.org

Your application does not handle overruns and underruns (EPIPE indicates
that either of these is happening). It also doesn't have any drift
correction, so overruns/underruns are to be expected (the sample rate of
the capture and playback stream is not guaranteed to be exactly matched).

By the way, there is a tool called 'alsaloop' (from alsa-utils) which
does exactly the same thing, but with drift correction and more options ...

Maarten Baert

On 28/02/14 09:47, Vadim Izmalkov wrote:
> Hello
>
> I created simple application that makes audio pass-through (from analog input to analog output),
>
> After 2-10 seconds get error like:
> AlsaPassthrough: pcm.c:693: snd_pcm_close: Assertion `pcm' failed.
> or
> write to audio interface failed (Broken pipe)
>
> Seems I have problem with buffer size/time or somethink like that.
> Parameters used:
> Buffer - 100 ms / 4800 frames / 19200 bytes
> Period - 10 ms / 480 frames / 1920 bytes
>
> Buffer length used 19200 bytes.
> char buffer[19200];
>
> Write/read function used as follow
> snd_pcm_readi(pcm, buffer, frames);
> snd_pcm_writei(pcm, buffer, frames);
>
> Have somebody any suggestion?
