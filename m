From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp patch, version II
Date: 05 Mar 2003 12:05:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046862340.1767.30.camel@satellite.undata.org>
References: <200303042322.h24NMSZ04964@linuxaudiosystems.com>
	 <1046854925.1721.11.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046854925.1721.11.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-03-05 at 10:02, Thomas Charbonnel wrote:
> I'm experiencing complete system lockups with this, in every possible
> situation:
> * cold boot
> * reboot
> * post boot module insertion
> 
> I did power off the card after updating, so the firmware has to be
> loaded.
> 
> I get no message from the driver.
> 
> No timeout ever occurs. (I left the machine hanging for at least 10
> minutes)
> 
> My system: 
> Kernel 2.4.20 ck3
> Alsa-driver 9.0rc8 + hdsp patch II applied
> Cardbus + multiface
> 
> Thomas
> 

If I try to get out of hanged state with the magic sysrq sigterm or
sigkill sequence, I get a flood of snd_printk messages from the
hdsp_fifo_wait(...) function in hdsp.c (line 501), with count = 127.
There are two places where hdsp_fifo_wait is called with count = 127:
hdsp_write_gain (line 550)
hdsp_initialize_firmware (line 3013)
I checked with the last working code I have, but can't find the problem.
I tried to switch back to the pre-udelay code in hdsp_fifo_wait, but the
problem is still here.

Any idea ?

Thomas




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
