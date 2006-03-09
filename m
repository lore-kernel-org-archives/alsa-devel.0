From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Bt87x Audio Capture
Date: Thu, 09 Mar 2006 14:11:46 +0100
Message-ID: <20060309131146.GA4299@turing.informatik.uni-halle.de>
References: <440F4F06.4030904@kmit.sk>
 <20060309074930.GA993@turing.informatik.uni-halle.de>
 <440FF003.5050106@kmit.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <440FF003.5050106@kmit.sk>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ondrej Ivani?? <ondrej@kmit.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ondrej Ivani?? wrote:
> >>bt878: AUDIO driver version 0.0.0 loaded
> >
> >This is the wrong module.  "bt878" is the old OSS driver, but you want
> 
> I didn't have OSS support in kernel and this module is from media/dvb:

Oops.  The OSS driver would have been "btaudio".

> /lib/modules/2.6.15-gentoo-r1-3/kernel/drivers/media/dvb/bt8xx/bt878.ko

The bt878 driver in the 2.6.15 kernel is buggy; it grabs the audio
function even for non-DVB cards.

> >to use the "snd-bt87x" driver.
> 
> I was unloaded all modules form kernel and loaded only snd_bt87x module:
> 
> localhost init.d # modprobe snd_bt87x load_all=1 enable=1
> localhost init.d # cat /proc/asound/cards
> --- no soundcards ---

The snd-bt87x driver in the same kernel has a bug that prevents it from
working with the load_all parameter.  This was fixed with this patch:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=c840a4c08e9814c197d30b631b782c420e26869a;hp=aaaa2e0d45c22aec11ac2325a488d27e392a0f96;hb=54c63cfc153c6909a5d5dbe6072e8704b091f30e;f=sound/pci/bt87x.c


HTH
Clemens


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
