From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: RE: Hammerfall DSP System Problems
Date: Tue, 10 Jun 2003 11:06:04 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGOECFCHAB.mknecht@controlnet.com>
References: <4732869.1055267407970.JavaMail.java@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4732869.1055267407970.JavaMail.java@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: frankgaetano@collegeclub.com
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
>  /sbin/modprobe snd-rawmidi
> /sbin/modprobe snd-hammerfall-mem
> /sbin/modprobe snd-hwdep
> /sbin/modprobe snd-hdsp
>
>  After I issue the last command I get the following errors:
>
> /lib/modules/2.4.19/kernel/sound/pci/rme9652/snd-hdsp.o: init_module:
> No such device
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters
>

I am having the very same problems with my HDSP 9652. What's even stranger
is, in my case, that for one evening the card worked, at least as far as
loading the driver. (No sound, but the driver loaded.) I was able to look at
/proc/asound/card0 (or whatever the directory/device was at the time...) and
see sensible stuff. I even took some screen shots and sent email to another
individual as I was debugging why I had no sound.

Later that evening I powered down. Upon rebooting the next morning it
failed, and has failed ever since. That was last Thursday evening.

I too am using 0.9.4 as provided in the Gentoo emerge, along with a custom
compiled kernel.

Like you I think the HDSP driver understands my firmware revision. I have
also downgraded and upgraded my firmware without success.

This whole Alsa/HDSP thing is amazingly weird...

- Mark




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
