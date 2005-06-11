From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: audgiy two zs and emu10k1
Date: Sun, 12 Jun 2005 00:07:40 +0100
Message-ID: <42AB6EBC.5080201@superbug.co.uk>
References: <Pine.LNX.4.63.0506110156090.19442@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0506110156090.19442@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: edoardo <edoardo@lastorina.it>
Cc: alsa developers' list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

edoardo wrote:
> 
> hi gals, hi dudes. i thought this would be the right place to post this
> question. i bought an audigy two zs card, and got it to work with
> emu10k1. i've got a problem though. analogic output works fine, whereas
> digital output don't seem to work at all. no sound comes out. also, i've
> plugged in an optical cable and looked into the other side of it, and no
> red beam is comin' out.
> 
> i thought a developer who worked on the driver might be able to answer
> this question. is this a missing feature? need i trigger any special
> parameter?
> 
> two final notes. i've tried togglin' 'audigy analog/digital output
> jack'. when it's on analogic output works, when it's off it don't.
> digital output never works. also, i ran alsaconf and it prints 'no
> supported pnp or pci card found.', although my card is detected at boot
> as an audigy two and, as i typed before, analogic output works fine.
> 
> how can i enable digital output? maybe i'm usin' the wrong cable?help! : )
> 
> thankyou! : )
> 
> ciao! : )
> 
> edoardo
> 

Post the output of:
lspci -vn | grep -1 0401

also the output of:
cat /proc/asound/cards




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
