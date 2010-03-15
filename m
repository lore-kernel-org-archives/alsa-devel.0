From: Matija Nalis <mnalis-alsadev@voyager.hr>
Subject: Re: cmipci and sound skipping ?
Date: Mon, 15 Mar 2010 20:35:57 +0100
Message-ID: <20100315193557.GA3884@eagle102.home.lan>
References: <20100313201138.GA25034@eagle102.home.lan>
	<4B9E2550.4030404@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx01.voyager.hr (mx01.voyager.hr [83.139.110.18])
	by alsa0.perex.cz (Postfix) with ESMTP id DB5EE10381B
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 20:36:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B9E2550.4030404@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 15, 2010 at 01:17:20PM +0100, Clemens Ladisch wrote:
> Matija Nalis wrote:
> > My card is "Asonic C-Media8738, 4 channel" and mostly works with snd_cmipci
> > driver - it is just that (even on completely unloaded system) the sound is
> > (very annoyingly) skipping.
> > ...
> > ALSA pcm_lib.c:316: BUG: pcmC0D0p:0, pos = 4294918144, buffer size = 16384, period size = 1024
> > 
> > Note that the pos is *always* the same (4294918144 = 0xffff4000 = -16384) which might be important.
> 
> This looks like a hardware bug.
> 
> It's possible that we can get a valid pointer by reading the register
> multiple times.  Please try the patch below.

Thanks Clemens, that patch seems to have fixed it !

-- 
Opinions above are GNU-copylefted.
