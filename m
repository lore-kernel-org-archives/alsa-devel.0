From: Florian Bomers <Florian.Bomers@sun.com>
Subject: Re: snd_pcm_hw_params_current() ?
Date: Fri, 04 Oct 2002 11:04:23 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D9DD827.B4C02E22@sun.com>
References: <Pine.LNX.4.33.0210041401090.713-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Thu, 3 Oct 2002, Florian Bomers wrote:
> 
> > Hi,
> >
> > there is snd_pcm_sw_params_current() but not snd_pcm_hw_params_current(). How
> > can I get the current hardware configuration for a given snd_pcm_t handle ? Am I
> > missing something ?
> 
> Hardware parameters must be configured from application all time.

So that means that I need to cache hw params if I ever want to use them again ?
E.g. my app does this:

open(), set hw params, set sw params
free hw params and sw params to save memory

work with the device: start/write/stop/etc.

When I now want to know the buffer size, I would like to obtain the current hw
params which I had set above to the pcm handle.

I understand that I initially need to set hw params to a pcm handle before I
could get current hw params, but once I did that, especially in prepared/running
state, the device has well-defined hw params and why shouldn't people be allowed
to query them ?

Thanks !
Florian

> 
>                                                 Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project  http://www.alsa-project.org
> SuSE Linux    http://www.suse.com
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
