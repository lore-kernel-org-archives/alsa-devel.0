From: Manuel Jander <mjander@embedded.cl>
Subject: ALSA driver
Date: Sun, 09 Mar 2003 16:48:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E6BA88C.5040908@embedded.cl>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi everyone,

I'm writing a Vortex ALSA driver, recycling most hardware stuff from the 
experimental OSS driver on savannah. I only own a AU8820, but support 
for the other cards shouldnt be difficult, because anything was done 
with portability in mind, and i keep looking into the other cards 
disassembled binary driver from time to time.

Right now the MPU401, ac97 mixer and the gameport work.
PCM audio is still broken, because it causes a system lockup (freeze),
but the good thing is that i actually get sound (one DMA bufer pass).

The au8820-driver (OSS) doesn't has this problem, but it has some buffer 
related bug that causes memory corruption. Mostly repeated open/close 
procedures causes this to happen. The symptoms are random segfaults and 
artifacts on the screen the more i open/close the /dev/dsp file.

Regarding the ALSA driver:
I'm very lost about what could be the problem. It looks like the card
gets stuck, because i tricked the ALSA higher level into thinking the 
DMA was not advancing and it still locked up.
If i comment out the line that starts the FIFO, no lockup occurs and 
anything is fine except that i only get a "tick" instead of audio
playback.

I would like to upload my code somewhere on the CVS, with the hope
soemone can help a bit with this.
Could someone give me write permission on the CVS somewhere else than 
au8820-driver ?

Best Regards

Manuel Jander.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
