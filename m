From: Vince <fuzzy77@free.fr>
Subject: Re: [OOPS] Alsa 0.9.4 / kernel 2.6.0-test1-mm1
Date: Mon, 21 Jul 2003 11:21:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F1BB0B0.9040201@free.fr>
References: <Pine.LNX.4.44.0307191823440.3903-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0307191823440.3903-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Sat, 19 Jul 2003, Vince wrote:
> 
> 
>>Jaroslav Kysela wrote:
>>
>>>On Fri, 18 Jul 2003, Vince wrote:
>>>
>>>
>>>
>>>>P.S.: I intended to test alsa 0.9.5 (in the hope that this bug was 
>>>>already known & has already been fixed), but unfortunately I get a 
>>>>compile error (I simply dropped alsa-kernel 0.9.5 in the 2.6.0-test1-mm1 
>>>>source tree):
>>>
>>>
>>>Copy also header files from alsa-kernel/include to linux/include/sound.
>>>
>>>						Jaroslav
>>
>>Thanks... If I made no mistake in installation, it appears that I still 
>>get the exact same oops with 0.9.5 (btw alsa-kernel/include/version.h 
>>still says 0.9.4 in the tarball):
> 
> 
> Please, send us contents of /proc/asound/card0/pcm0p/sub0/* files after 
> oops occured.

Here it is right after the oops:

diablo:~$ cat /proc/asound/card0/pcm0p/sub0/hw_params
closed
diablo:~$ cat /proc/asound/card0/pcm0p/sub0/info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ES1371/1
name: ES1371 DAC2/ADC
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
diablo:~$ cat /proc/asound/card0/pcm0p/sub0/prealloc
64
diablo:~$ cat /proc/asound/card0/pcm0p/sub0/status
closed
diablo:~$ cat /proc/asound/card0/pcm0p/sub0/sw_params
closed

Information that may help : it looks like festival tries to play a 
16kHz/16bit/mono file trough oss... If I redirect its output to "aplay 
-f S16_LE -r 16000", everything works fine.

Vincent



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
