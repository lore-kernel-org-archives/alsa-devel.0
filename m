From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 27 Apr 2009 17:09:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904271707000.25064@eeebox2.perex-int.cz>
References: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
	<20090427092514.GB1760@sirena.org.uk>
	<9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
	<20090427135737.GA20591@sirena.org.uk>
	<9e4733910904270702w317c8c62vbee38230979ad121@mail.gmail.com>
	<20090427140554.GB20591@sirena.org.uk>
	<9e4733910904270716v289e6d5exaf6e17331786ea11@mail.gmail.com>
	<20090427142437.GF20591@sirena.org.uk>
	<9e4733910904270742l751e660bg66844b98fe261f23@mail.gmail.com>
	<s5h4owa5f1y.wl%tiwai@suse.de>
	<9e4733910904270804k6ed079d4h16b433b6f8a06fc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DB29924376
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 17:09:27 +0200 (CEST)
In-Reply-To: <9e4733910904270804k6ed079d4h16b433b6f8a06fc7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Apr 2009, Jon Smirl wrote:

> I have fixed all of the other bugs. If I take out the position
> estimation code it fails.
>
> Jaroslav hasn't commented on this yet....

Appearently, FIFO is too big. I'm working on some changes to take account 
fifo_size to the jiffies based check. Please, set fifo_size correctly in 
your driver. USB drivers with big "URB FIFOs" should be changed as well, 
too.

 						Jaroslav

> On Sun, Apr 26, 2009 at 2:31 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Sun, 26 Apr 2009, Jon Smirl wrote:
>>
>>> If I take this out I get these errors...
>>> ALSA sound/core/pcm_lib.c:264: PCM: hw_ptr skipping! [Q] (pos=11026,
>>> delta=5513, period=5513, jdelta=33/37/0)
>>
>> It means that the period DMA operation is too quick in your case and does
>> not correspond to the timing specified by rate. It might be that the FIFO on
>> path is large or rate set to the codec is not correct. What's HZ value on
>> your system and FIFO size? There is HZ/100 margin in the check now.
>
> FIFO is 512 bytes, HZ is 300.
> The rate on the codec is correct and the music sounds right.

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
