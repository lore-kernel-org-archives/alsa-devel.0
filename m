From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp patch, version II
Date: 05 Mar 2003 15:21:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046874063.1458.15.camel@satellite.undata.org>
References: <E18qYvo-0004Cp-00@dardilly>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18qYvo-0004Cp-00@dardilly>
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

On Wed, 2003-03-05 at 14:38, Paul Davis wrote: 
> >in short, i am confused :) :(
> 
> but ... help is at hand. i checked my mail archives:
> 
> >The fifo status counts the number of words waiting in the FIFO. A value of
> >128 means that the fifo is full. 0 means the fifo is empty.
> 
> OK, so this means that 
> 
>     hdsp_fifo_wait (hdsp, 0, some_count);
> 
> is waiting till the FIFO is empty. by contrast, 
> 
>     hdsp_fifo_wait (hdsp, 127, some_count);
> 
> waits till there is 1 word available in the FIFO, meaning that we can
> write to it.
> 
How is that we can write to it if it is full ?

In the case the above question is stupid, and the fifo being full
meaning we can write to it, we have the following code in
snd_hdsp_initialize_firmware anyway:

for (i = 0; i < 24413; ++i) {
	hdsp_write(hdsp, HDSP_fifoData, firmware_ptr[i]);
	if (hdsp_fifo_wait (hdsp, 127, HDSP_LONG_WAIT)) {
		snd_printk ("timeout during firmware loading\n");
		return -EIO;
	}
}

Here it seems we write before checking if we can. The bad news is I've
just tested the other way round and it works no better.

> this doesn't help explain why we sometimes fail to see this condition
> being met. any insights?

Is it really that the condition is not being met ?
It should gracefully fail. That's what timeouts are for. If the
condition fails, then the driver should fail to instantiate, and the
boot process should go on. The problem is that we have a freeze.

Thomas, searching in all directions... 





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
