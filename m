From: "John S. Denker" <jsd@monmouth.com>
Subject: Re: sb16 gets wedged when doing overlapped i/o (full
 duplex)
Date: Thu, 05 Dec 2002 08:45:09 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEF5865.7060109@monmouth.com>
References: <Pine.LNX.4.05.10212051304370.3576-100000@pulsar.kss-loka.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.05.10212051304370.3576-100000@pulsar.kss-loka.si>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Uros Bizjak <uros@kss-loka.si>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Uros Bizjak wrote:

>   Did you try to set 16bit DMA allocation flag to Playback or Capture?

I tried setting it to Capture.
No joy.  ALSA gets wedged just the same as before.

By the way, is this DMA Allocation thingy documented anywhere?????

I had to do a huge find|grep to figure out what this
suggestion was referring to.  Alsamixer knows nothing
of this switch.  Amixer knows nothing of this switch.
Fortunately alsactl can deal with it.

 From the keen-grasp-of-the-obvious department:
This project would be a lot better off if there were
better documentation, and (some) comments in the code.
Why write the code if it's not going to be used?
If it's not documented, it's not going to be used!

>   Also, there are problems if your ISA bus is overclocked to more
> than 8MHz.

I haven't been messing with that.
But thanks for the hint; I'll fire up the oscilloscope and
take a look when I get a chance.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
