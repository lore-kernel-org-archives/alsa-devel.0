From: Ray Heasman <nurf@spamcop.net>
Subject: Re: Firewire Audio Support
Date: 27 Aug 2003 18:26:24 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062033984.4389.328.camel@maze.mythral.org>
References: <2689281.1062002361328.JavaMail.nobody@wamui09.slb.atl.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <2689281.1062002361328.JavaMail.nobody@wamui09.slb.atl.earthlink.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ametts2@mindspring.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, 2003-08-27 at 09:39, ametts2@mindspring.com wrote:
> I have a MOTU 828 -- are there any efforts underway to support FireWire (IEEE-1394), multi-channel audio devices under ALSA?  
> 

I have successfully streamed audio to ISO61883 complaint devices from
Linux. I used a slightly hacked 1394 video kernel module to do so. This
was back when the alsa documentation was non-existent, and I decided I
didn't have enough time to write an alsa version. (I was using it to
test a prototype firewire link layer chip, so actual OSS or ALSA support
was superfluous )

One thing I do know though, is that the first MOTU boxes were not
ISO61883 compliant in any way. They used their own proprietary format.
I had a look at one with a 1394 bus analyser, and it looked easy enough
to figure out.

> If so, please tell me where to find more info!

I'm afraid you now know as much as I do. The only reason I chirped up
was that if someone needs help figuring out the format, or has questions
about on-the-wire formats for 61883 or mLAN devices, I can help. If
nothing else, I have a firewire bus analyser.

Have you looked here? : http://www.linux1394.org/amdtp.html

It looks like they are doing it the way I did - simple user-land access
to an interface that gives you raw access to the bus.

Cheers,
Ray




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
