From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Unexpected hw_pointer value (pcm_lib.c)
Date: Sun, 12 Oct 2003 13:27:14 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1065979634.1786.56.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

Can anyone tell me how does pcm_lib.c cope with buffer wrap around ?
I'm missing something like:

delta =  pointer_current - pointer_prev;
if (delta < 0)
   delta += period_size;
 
Well, indeed i'm getting some warnings then and when, after i enabled
the ALSA debug option:

ALSA sound/core/pcm_lib.c:216: Unexpected hw_pointer value (stream = 0,
delta: -586, max jitter = 8192): wrong interrupt acknowledge?

Delta has a negative value, thus the if statement :

if ((snd_pcm_uframes_t)delta < runtime->buffer_size / 2) {
    snd_printd("Unexpected hw_pointer value (stream = %i, d
    return 0;
}

... is always true. Well, as the code looks like, the situation when the
period pointer wraps around back to cero isn't handled correctly. Or is
that handled by other means ? Maybe i just oversaw something. Can anyone
give me more insight over this ? Thanks...

Best Regards

Manuel Jander.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
