From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Bluetooth headset driver
Date: Mon, 26 Apr 2004 22:01:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <408D78B4.4000700@superbug.demon.co.uk>
References: <1083001170.4dmq5ufy93r4@cybertux.akr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1083001170.4dmq5ufy93r4@cybertux.akr.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christian Ege <chege@cybertux.info>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Christian Ege wrote:
> Hi anyone working on something simalar to this?
>    http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/
> 
> The author of this driver won't continue his work because he switched to MAC OS
> ;-(
> 
> I think the way he tried to integrate this driver into alsa isn't the best way.
> 
> I am not that kind of Kernel guru but if there are some other people arround
> here interested in that stuff it shouldn't be too much work to integrate this
> driver in alsa.
> 
> Or isn't there any interest in bluetooth communication ;-)
> 
> 
> cu
> chege
> 

I have been working on a bluetooth alsa driver, but it turns out to be a 
lot more complicated that one would at first think.
1) The bluetooth headset profile is a "profile" and therefore deemed to 
be a user space and not a kernel space program.
2) The current bluez bluetooth stack in the kernel does not provide any 
"playback" position feedback, so we would not be able to implement 
snd_pcm_delay() and therefore it would be extremely difficult to make a 
low latency app using it. The first use of a headset profile is for full 
duplex speach, which requires low latency, so that is a problem.
3) audio data path would therefore go from alsa-lib(userspace) -> 
alsa-driver(kernel-space) -> headset profile (userspace) -> bluez stack 
(kernel space). Extremely messy in my view!
(What http://www.dcs.gla.ac.uk/~jp/snd-bt-sco/ currently does in fact)

Summary: -
Until the bluez stack provides a mechanism for us to do 
"snd_pcm_delay()", there is very little point advancing with the alsa 
side for bluetooth.

Who will want to use a headset that has large uncontrollable latencies?

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
