From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: searching volunteer to test Hoontech DSP24 to
	check if the driver is realy working well
Date: Sun, 5 Jan 2014 20:39:59 +0000
Message-ID: <201401052039.59438.gineera@aspect135.co.uk>
References: <loom.20140105T194353-495@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip07ir2.opaltelecom.net (out1.ip07ir2.opaltelecom.net
 [62.24.128.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C869260886
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 21:36:48 +0100 (CET)
In-Reply-To: <loom.20140105T194353-495@post.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: YvanM <funyvan@hotmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Yvan,

On Sunday 05 January 2014 19:16, YvanM wrote:
> First please apologize if I'm in the wrong place.

It is probably the best place.

> I have a Hoontech DSP24
> (http://fr.audiofanzine.com/carte-son-rack/hoontech/DSP24-+-ADDA2000-DSP200
>0-C-Port/), but I had problem to make it working.

Are you talking here about the PCI card, 8-channel audio unit, not the ADAT 
cards?  What problems are you having?

I have one of the audio card/rack pairs, which has been working fine with Alsa 
since years ago (not actually used recently).  In particular I have recorded 
live 8-channels from a mixing desk, and later played back all 8 to analogue 
mix-down.  I think the PC ran an updated Alsa-1.0.12 with a 2.4 linux kernel.  
I was involved in a patch fixing the MIDI several years ago and there were 
other users then, including a studio in Australia.  Maybe it broke more 
recently (all my systems are quite old)?

>I don't use it so, if 
> someone with knowledge wants to check if this soundcard is really
> recognized, I can send it to him. After that, feel free to play with it,
> improve the driver, or even sell it !
>
> The problem I had :
>   - spent 3 months to find on the Internet the following lines to had to
> /etc/modprobe.d/alsa-base to make the card recognized :
>  stall snd-ice1712 /sbin/modprobe --ignore-install snd-ice1712 && {
> /sbin/modprobe -Qb snd-ice1712 ; }
> options snd-ice1712 model=dsp24
>   - impossible to have "normal" stereo : it seems that each logical canal
> (right and left) is redirected to both right and left speaker.

I've never done anything like that.  Is your system running Pulseaudio?  Which 
distro/kernel are you using?

Others on this list may have more idea of the issues?

Regards

Alan
