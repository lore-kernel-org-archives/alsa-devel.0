From: Ludovico Verducci <ludwigvan@alice.it>
Subject: Re: Enabling in-kernel synch for M-Audio boards
Date: Tue, 18 Sep 2007 10:07:05 +0200
Message-ID: <46EF8729.3080901@alice.it>
References: <46EE555B.9000700@alice.it> <20070917194403.GA3655@localhost>
	<20070918065723.GA2512@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mercurio1.dnshostplan.com (dns22.dnshostplan.com
	[151.1.210.227]) by alsa0.perex.cz (Postfix) with ESMTP id 69EAA24471
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 10:07:09 +0200 (CEST)
Received: from host9-74-static.89-82-b.business.telecomitalia.it ([82.89.74.9]
	helo=[10.10.1.203])
	by mercurio1.dnshostplan.com with esmtpa (Exim 4.68)
	(envelope-from <ludwigvan@alice.it>) id 1IXY6p-0000KL-7R
	for alsa-devel@alsa-project.org; Tue, 18 Sep 2007 10:07:03 +0200
In-Reply-To: <20070918065723.GA2512@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Rigg ha scritto:
> On Mon, Sep 17, 2007 at 08:44:03PM +0100, John Rigg wrote:
>   
>> On Mon, Sep 17, 2007 at 12:22:19PM +0200, Ludovico Verducci wrote:
>>     
>>> Hello all! 
>>>  
>>> I'm developing a complex multichannel audio distribution system where 
>>> multiple linux boxes will stream audio data over ethernet and then 
>>> should play audio at sample level resolution synchronization. The boxes 
>>> clocks are synchronized over ethernet using PTP. 
>>> I need to keep in synch the audio board's clocks and I can't use an 
>>> external wordclock nor s/pdif. 
>>>       
>> Won't this cause serious clock jitter problems? I don't see how the
>> PCI bus can deliver precise enough timing, considering how much other
>> data it has to handle.
>>     
I didn't mean to directly drive the audio board's clock over the PCI
bus. I think this is simply not feasible. But I think that using control
signals periodically exchanged over PCI between the audio board and the
kernel could be possible (if the hardware could support a similar
feature, of course) to skew the board's clock to keep it in synch with a
software reference.
As far as I know the delta family boards drivers support the
synchronization of up to 4 audio boards over PCI: at the moment I'm
reverse engineering the hardware trying to understand how this can be
accomplished.
>
> And I can't see any way that the clocks can be synced to sample
> accuracy over ethernet. That's what external word clocks are for.
> Even with a word clock I suspect that the latency of the
> ethernet connection would be too high to allow sample accurate sync
> of the audio.
>
> John
>   
The machines real time clocks are synched over ethernet using Precision
Time Protocol. This protocol can achieve below 1 microsecond
synchronization accuracy. This should be fine to sample level synch at
48 KHz.

Regards,

Ludovico
