From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: [Alsa-devel] 02 micro 6933 cardbus controller creates problem
 with the hammerfall dsp driver
Date: Mon, 09 Feb 2004 00:29:44 +0100
Sender: pcmcia-cs-devel-admin@lists.sourceforge.net
Message-ID: <4026C668.7060905@undata.org>
References: <20040208191040.191bcd24@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <pcmcia-cs-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040208191040.191bcd24@laptop>
Errors-To: pcmcia-cs-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/pcmcia-cs-devel>,
	<mailto:pcmcia-cs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:pcmcia-cs-devel@lists.sourceforge.net>
List-Help: <mailto:pcmcia-cs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/pcmcia-cs-devel>,
	<mailto:pcmcia-cs-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=pcmcia-cs-devel>
To: Tim Blechmann <TimBlechmann@gmx.net>
Cc: linux-kernel@vger.kernel.org, pcmcia-cs-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tim Blechmann wrote :

> i'm experiencing problems with the O2 micro 6933 card when trying to use
> the hammerfall dsp sound device. i'm using the yenta socket driver (the
> O2 micro 6933 should be 100% compatible to the yenta socket)
> 
> i met thomas charbonnel, who maintains the alsa driver of the hdsp, and
> concerning him, it seems to be a problem of the dma mapping in the
> cardbus-pci bridge ... the alsa driver is working fine, until it starts
> dma (to output sounds) ... (thomas, please correct me if i'm saying
> something completely stupid, i'm a musician, not a kernel hacker)
> 

I believe a little more background information is needed. Tim's card is 
a busmaster carbus audio card capable of hardware routing, that is any 
audio stream arriving on the physical inputs of the card can be routed 
to any physical output without involving the computer in any way (this 
is done using an FPGA chip). The card can also do hardware peak and rms 
computation on incoming and playback streams. On Tim's machine the card 
is detected and initialized properly, and hardware routing works as 
expected until audio interrupts are enabled. Then something strange 
happens : parts of the incoming audio streams are found in the card's 
playback buffer (rms and peak values are reported for those signals), 
but the driver is not involved in this process. I got this piece of 
information from Martin Bjoernsen at RME, the company manufacturing the 
card :

"The HDSP cards use an internal double buffer per channel of 2*16 
samples. Data is transferred in blocks of 16 samples. Every 16 samples 
16 samples per channel are read and written to and from the main memory. 
In the card the same buffer is used for inputs and outputs. Playback 
data is overwritten from new recorded data. If the hardware is started 
and an output dma channel is not enabled but the input is, you will hear 
the input delayed by 32 samples or silence when there is no input signal."

The driver does enable both input and output dma channels for all 
possible streams, so my guess for now is that there is something wrong 
in the underlying subsystem.

I hope this helps track the problem down.

Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
