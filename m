From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Strange err=25 result.
Date: Wed, 14 Jan 2004 14:09:02 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40054D7E.5010902@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some debug output from calling snd_pcm_wait() when a USB device is 
unplugged.

(pcm_hw.c from /alsa-lib/src/pcm/pcm_hw.c)
file=pcm_hw.c:406 function=snd_pcm_hw_status err=25
pcm_hw.c: snd_pcm_hw_status() SNDRV_PCM_IOCTL_STATUS failed.

According to errno.h,
#define ENOTTY          25      /* Not a typewriter */

I would think that the following would be a better err result.
#define ENODEV          19      /* No such device */
or even
#define EPIPE           32      /* Broken pipe */

I have looked through alsa-lib and alsa-kernel and cannot find any place 
in the code that sets errno to 25!

Can anybody help?

My aim is to let the application detect when a usb audio device is 
unplugged, so that the application can release all alsa resources.
The application will then poll the alsa-lib trying to open the device 
again, and continually get errors until the audio usb device is plugged 
in again. For my application to achieve this, I would need a specific 
errno for the "usb device unplugged" that will not get confused with 
over/underruns or other errors that might not be "usb unplugged" related.

Cheers
James


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
