From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Changes over dmix: 1.0.11rc4 and future
Date: Sat, 01 Apr 2006 14:19:13 -0500
Message-ID: <1143919154.30769.16.camel@mindpipe>
References: <s5h64lzalr0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64lzalr0.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-03-27 at 18:35 +0200, Takashi Iwai wrote:
> Hi,
> 
> it looks like the 1.0.11rc4 announcement isn't sent out, so here I'd
> like to explain what has been changed over dmix recently.
> 
> As of 1.0.11rc4, dmix accepts more flexible buffer sizes than the
> earlier versions did.  The buffer size is basically arbitrary.  The
> only restriction is that it's aligned to the period size, and the
> minimal periods are two.
> 
> With this change, some applications have positive influences, and some
> have negative.  The regression, for example with speaker-test, happens
> because there was no upper limit of buffer size.  It's already fixed
> in the CVS version (by setting max periods = 1024).
> 
> If you have a problem with dmix what didn't happen ago, try to define
> 
> 	defaults.pcm.dmix_variable_buffer false
> 
> in ~/.asoundrc.
> 

Does not work (alsa-lib and utils from today's CVS):

$ aplay -Dplug:dmix51 /usr/share/sounds/error.wav 
ALSA lib pcm.c:6650:(snd_pcm_slave_conf) Unknown field
variable_buffer_size
aplay: main:547: audio open error: Invalid argument

.asoundrc:

defaults.pcm.dmix_variable_buffer false
pcm.dmix51 {
        type upmix
        slave.pcm {
                type dmix
                ipc_key {
                        @func refer
                        name defaults.pcm.ipc_key
                }
                ipc_gid {
                        @func refer
                        name defaults.pcm.ipc_gid
                }
                slave {
                        pcm "hw:0,0"
                        period_size 512
                        periods 10
                        channels 6
                        variable_buffer_size true
                }
        }
}

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
