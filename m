From: "Chris Pechie" <cpechiealsa@hotmail.com>
Subject: 0.9.4 library mem leak?
Date: Wed, 11 Jun 2003 17:17:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Law15-F55Xp4Pqsh1lB00068d37@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I modified the code in amixer.c for my own use.  Instead of being a command 
line utility that ends after every mixer access, I have it as a function 
call from a larger program.  I also cut it down quite a bit so that I am 
only using sset for Master and PCM.

The problem that I am running into is that after each iteration of this 
code, I am losing 4k of memory.  When I kill my program, all memory is 
returned to the system, so it points towards the alsa library as being the 
culprit.

I kept the basic initialization scheme of amixer intact in my program, which 
includes successive calls to snd_mixer_open, snd_mixer_attach, 
snd_mixer_selem_register, and snd_mixer_load.  In debugging this problem, I 
found that the memory is lost after the call to snd_mixer_load.  One would 
assume that snd_mixer_close would take care of all memory allocations, but 
it does not seem to clean it up properly.  This leads me to believe that 
some unexpected allocation is being made in snd_mixer_load.

I traced it down into the library code, and I got to a point where I 
commented out the ioctl call in the function snd_ctl_hw_elem_list and this 
seemed to remedy the problem.  To go one step back, I see that this function 
is being accessed in a while loop in the function snd_hctl_load.  Within 
this loop is the function snd_ctl_elem_list_alloc_space, and I looked at its 
code to see if anything was out of whack, but it all seemed OK.  At this 
point, I'm running out of ideas.....plus, I think I may have looked right at 
the problem piece of code but did not recognize it.

Has anyone come across this before?  Am I doing something wrong, or is the 
library really leaking?  Can anyone out there point me in the right 
direction?  Any and all help on this would be greatly appreciated!  I can't 
accept the fact that amixer can only be used as a command line interface to 
save that 4k per access!

  ----- Chris Pechie

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
