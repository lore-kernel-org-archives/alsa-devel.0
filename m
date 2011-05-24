From: Stephen Warren <swarren@nvidia.com>
Subject: Re: aplay can't run in background since adding pause
	support
Date: Tue, 24 May 2011 09:48:52 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A481E3@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A4808F@HQMAIL01.nvidia.com>
	<s5hoc2s4p8c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id C3861103847
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 18:49:02 +0200 (CEST)
In-Reply-To: <s5hoc2s4p8c.wl%tiwai@suse.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote at Monday, May 23, 2011 11:55 PM:
> At Mon, 23 May 2011 13:55:44 -0700, Stephen Warren wrote:
> >
> > Jaroslav,
> >
> > In recent versions of aplay, if I try to either run them in the
> > background, or run them in the foreground, then ^Z and bg them, they
> > hang indefinitely:
> > ...
> 
> IMO, it's safer to add an option for interactive mode like below.
> As aplay has been used since long time ago, we shouldn't introduce
> any regression to this basic program.

Tested-by: Stephen Warren <swarren@nvidia.com>

(with -i, behaves as before, without -i, works in background as expected)

Thanks.

> ---
> diff --git a/aplay/aplay.1 b/aplay/aplay.1
> index b6caf0b..8cd1d56 100644
> --- a/aplay/aplay.1
> +++ b/aplay/aplay.1
> @@ -137,6 +137,10 @@ by typing aplay.
>  Record.  This is the default if the program is invoked
>  by typing arecord.
>  .TP
> +\fI\-i, \-\-interactive\fP
> +Allow interactive operation via stdin.
> +Currently only pause/resume via space key is implemented.
> +.TP
>  \fI\-\-disable\-resample\fP
>  Disable automatic rate resample.
>  .TP
...

-- 
nvpublic
