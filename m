From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: busy-wait questions
Date: Fri, 07 May 2004 10:40:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040507104053.pochini@shiny.it>
References: <s5hy8o818tl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8o818tl.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 04-May-2004 Takashi Iwai wrote:
>> After a lot of cleanups and coding style changes, my driver still has some
>> things that must be fixed properly. Busy-waits are one of those.
>>
>> The most used busy-waits have a timeout of 10ms and 100ms and they are
>> called with a spinlock_irq held or from the irq handler. With my card
>> the longest wait I measured was 190us, so I guess it's ok.
>>
>> But two functions, read_dsp() and write_dsp() have a timeout of 10s. They
>> are used exclusively for loading the DSP firmware and the ASICs. They are
>> very fast on my card, but other cards (the driver supports 8 cards) may be
>> slower. I was thinking about calling the scheduler in case of a long wait,
>> but two cards need to reload the ASICs in order to switch between S/PDIF and
>> ADAT and one card also has to reload the ASICs when the sample rate crosses
>> the 50KHz boundary. Since those operations are protected by a spinlock, it's
>> not a great idea to call the scheduler. Any hint ?  Perhaps we could just
>> live with it, since the reload is not required very often...
>
> the question is whether you really need spinlock to protect the
> context with such a delay.  if the interrupt handler doesn't touch
> with this data concurrently, you can protect it with mutex and do
> schedule().

This is the core of the problem indeed. The SendVector() function
waits for the busy bit to be 0 before writing the command. It
must be protected with a spinlock because it's called almost
everything and also by the irq hadler to send the DSP_VC_ACK_INT
vector command.

r/w_dsp() communicate in a slight different way (not vector thing),
but I don't know if the DSP likes to receive two different commands
at the same time. I have to ask Echoaudio about this issue.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
