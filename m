From: Arthur Peters <amp@singingwizard.org>
Subject: Single process freeze when opening capture device
Date: Wed, 28 May 2003 22:24:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054178657.5634.211.camel@newbie.localnet.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa dev List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have found what seems to be a bug in ALSA (CVS of this afternoon).
When a program opens certain PCM devices for capture the program blocks
forever in snd_pcm_open (both the library function and the kernel
function actually). The PCM device I have been testing it with is
surround40 on a emu10k1 (SBLive Value). I am trying to capture on this
device because I want to have jack use surround40 (actually a route
plugin device pointing to it) so that I can use all 4 outs and both ins
at the same time.

Below is a minimal setup that reproduces the problem for me.

alsa_freeze.c
------------------
#include <alsa/asoundlib.h>
 
int main( int argc, char* argv[] )
{
        snd_pcm_t *pcm;
        snd_pcm_open(&pcm, "surround40", SND_PCM_STREAM_CAPTURE, 0);
        return 0;
}
------------------

.asoundrc
------------------
<confdir:cards/EMU10K1.conf>
------------------

using SysRq-T I captured a kernel stack trace
------------------
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace:    [<e094908e>] [<e0922b20>] [<e0948f60>] [<e091b220>]
[<c018c325>]
  [<c014bf59>] [<c013ea43>] [<c013e968>] [<c013ed43>] [<c010774f>]
Warning (Oops_read): Code line not seen, dumping what data is available
 
Proc;  alsa_test_sim
 
>>EIP; 00000000 Before first symbol
 
Trace; e094908e <[snd-pcm]snd_pcm_open+12e/190>
Trace; e0922b20 <[snd]snd_fops+0/48>
Trace; e0948f60 <[snd-pcm]snd_pcm_open+0/190>
Trace; e091b220 <[snd]snd_open+e0/160>
Trace; c018c325 <devfs_open+195/210>
Trace; c014bf59 <path_lookup+39/40>
Trace; c013ea43 <dentry_open+d3/1e0>
Trace; c013e968 <filp_open+68/70>
Trace; c013ed43 <sys_open+53/c0>
Trace; c010774f <system_call+33/38>
------------------

I suspect that snd_pcm_open+12e is line 1974 in pcm_native.c. Everytime
I checked it was at this address.
------------------
		set_current_state(TASK_INTERRUPTIBLE);
                schedule();
           >>>> if (signal_pending(current)) { <<<
                        err = -ERESTARTSYS;
                        break;
                }
------------------

Please tell me you need anymore info or if you want me to try anything.

-Arthur


-- 
Arthur Peters <amp@singingwizard.org>



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
