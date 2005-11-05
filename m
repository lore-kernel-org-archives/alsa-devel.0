From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Fix for slow snd-ali5451 initialization
Date: Sat, 05 Nov 2005 15:22:12 -0500
Message-ID: <1131222132.13627.19.camel@mindpipe>
References: <Pine.LNX.4.61.0511051136400.16526@sixpak.sixpak.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0511051136400.16526@sixpak.sixpak.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Vince Busam <vince@sixpak.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-11-05 at 11:38 -0800, Vince Busam wrote:
> The snd-ali5451 driver takes 10 seconds to load, which is quite annoying 
> on a laptop that boots every day.  This patch lowers that to a much more 
> managable time, and still works fine on my laptop.
> 
> Vince
> 
>      Summary: Speed up ali5451 initialization
> 
>      The patch speeds up loading the ali5451 driver by lowering the
>      wait time in snd_ali_codec_ready()

Does not apply against current ALSA or kernel sources.  Please provide
an updated patch.

Also, why is this an issue?  Do your distros init scripts delay the boot
until this driver is loaded?  Shouldn't it be loading all drivers in
parallel?

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
