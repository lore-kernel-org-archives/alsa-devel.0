From: Martijn Sipkema <msipkema@sipkema-digital.com>
Subject: audiowerk2
Date: Wed, 10 Jul 2002 15:39:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207101339.PAA08764@www.bluedns.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > I have an AudiowerksII from Emagic. I was wondering what steps I could
> > take to get this supported by Alsa. I have some programming experience
> > but have never worked on device drivers before. I have contacted
> Emagic. 
> > What Next? 

Have Emagic supplied you with the specifications? You can download the specs
on the SAA7146 from Philips. The Audiowerk2 is very much like the Audiowerk8,
with some differences on the I/O and it also doesn\\\\\\\'t have the variable
sample
rate.

There is an Audiowerk8 driver for Linux at 
http://www.landamore.com/audiowerk.html . It is based on a GPL (example)
driver
from Emagic.

If you did not receive any specs from Emagic, ask again. The documentation
I have does not say anything about the Audiowerk2 and allthough it is very
similar to the Audiowerk8 it will be different in setting the sample rate
and use of the I2S (different time slot list) interface.

> if you got a hardware spec, then take a look at the sources already 
> existing.  there are likely drivers with the similar chip design. 
> then copy it, and modify it. 

The SAA7146 has 2 input and 2 output DMA channels that can use non-contiguous
(it has a MMU) buffers with \\\\\\\'any\\\\\\\' number of periods per buffer.

> also, it would be better to ask Emagic whether the spec can be put on 
> a public place, so that other developers can be involved with the 
> development.

I doubt they will do this. I can put the documentation that I have on my
website next week.

> AFAIK the card is pretty much unique.... 
> The main logic chip is a 
> PHILIPS 
> SAA 7146A HZ
> CA1950.0
> ktD9917V2

It is used in some video boards (, that probably don\\\\\\\'t use the audio
part
of the chip).

I am (slowly) working on a Audiowerk8 driver and when it is usable I\\\\\\\'ll
put
that on my website also.

--martijn





Powered by ASHosting


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Two, two, TWO treats in one.
http://thinkgeek.com/sf
