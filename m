From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How do create a dummy device for recording audio?
 Does it exist already?
Date: Fri, 23 Apr 2004 17:56:19 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404231752570.1891-100000@studcom.urz.uni-halle.de>
References: <4088380E.7070004@crome.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <4088380E.7070004@crome.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Caleb Crome <alsa@crome.org>
Cc: ALSA Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Caleb Crome wrote:
> Arek Korbik wrote:
> >pcm.file {
> >    type file
> >    slave {
> >        pcm "hw:0,0"
> >    }
> >    file "/tmp/file.raw"
> >}
>
> what do I do with that bit of configuration data?  I found the
> /usr/share/alsa/alsa.conf, and there is a similar pcm.file entry
> in that, but it seems to take parameters.

Put it into your ~/.asoundrc file, or into /etc/asound.conf for all
users.

> Since I have no sound card, how do I configure my system to use
> the dummy PCM driver and use the pcm.file plugin?

"modprobe snd-dummy" should work.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
