From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How do create a dummy device for recording audio?
 Does it exist already?
Date: Mon, 26 Apr 2004 18:29:34 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404261825390.25756-100000@studcom.urz.uni-halle.de>
References: <4089663E.4000200@crome.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <4089663E.4000200@crome.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Caleb Crome <caleb@crome.org>
Cc: ALSA Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Caleb Crome wrote:
> >>>pcm.file {
> >>>   type file
> >>>   slave {
> >>>       pcm "hw:0,0"
> >>>   }
> >>>   file "/tmp/file.raw"
> >>>}
>
> Alright, I did what you suggested, and real player comes up and connects
> to the dummy sound card (I had to do a modprobe snd-pcm-oss and
> snd-mixer-oss).   However, I don't get a file called /tmp/file.raw.

You have to configure the program to use the PCM named "file" instead
of the default "default".

However, Realplayer uses the OSS emulation through /dev/dsp0.  To make
that work with your "file" device, add the following to the config
file:

  pcm.dsp0 = file

and try to run realplayer with the aoss script from the alsa-oss
package.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
