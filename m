From: Taupter <taupter@baydenet.com.br>
Subject: Re: Quick SBLive/AWE32 synth question
Date: Wed, 31 Jul 2002 20:03:41 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D486CCD.2040600@baydenet.com.br>
References: <200207301624.02609.bownie@bownie.com> <s5hy9bsf2x1.wl@alsa2.suse.de> <200207311902.02690.bownie@bownie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: bownie@bownie.com
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Richard Bown wrote:
> Takashi Iwai wrote:
> 
> 
>>can you check whether this happens on SB Live only or both on SB Live
>>and AWE?
> I'm trying to reproduce the problem with another sequencer but to tell the
> truth I'm having a problem finding one that does on-board ALSA synths too.

try noteedit.

http://rnvs.informatik.tu-chemnitz.de/~jan/noteedit/noteedit.html

to get ALSA MIDI output with it you'll need to install the TSE3 library 
by Peter Goodliffe.

http://tse3.sourceforge.net/

>>could you try to make a short midi clip which can cause the same
>>behavior, so that i can test to reproduce on my machine?
> I will do once I've convinced myself it's not us.

I would do the test right now if I could get my ALSA working... I 
reinstalled MDK8.2 and the kernel 2.4.18-8.1mdk. ALSA 0.9.0rc2 compiles 
fine, installs, but

service alsa start

tells me:

Starting ALSA version 
none:/lib/modules/2.4.18-8.1mdk/kernel/sound/acore/snd.o: unresolved 
symbol register_sound_special_R69a88294
/lib/modules/2.4.18-8.1mdk/kernel/sound/acore/snd.o: unresolved symbol 
unregister_sound_special_R99c95fa5
modprobe: insmod /lib/modules/2.4.18-8.1mdk/kernel/sound/acore/snd.o failed
modprobe: insmod snd failed


Any ideas?


Taupter



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
