From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: how does alsa keep passing data into driver?
Date: Sun, 16 Oct 2005 16:26:12 +0100
Message-ID: <43527114.2040601@superbug.co.uk>
References: <bf04f99c0510131947m1a5e0a68n631b761818887222@mail.gmail.com>	 <XFMail.20051014093633.pochini@shiny.it> <bf04f99c0510160700y490bc9b6q8db1bd77957de4c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <bf04f99c0510160700y490bc9b6q8db1bd77957de4c2@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tehn Yit Chin <tehn.yit.chin@gmail.com>
Cc: Giuliano Pochini <pochini@shiny.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tehn Yit Chin wrote:
> On 10/14/05, Giuliano Pochini <pochini@shiny.it> wrote:
> 
>>
>>On 14-Oct-2005 Tehn Yit Chin wrote:
>>
>>
>>>I am trying to understand how the ALSA pass PCM data to the driver. I
>>
>>have
>>
>>>understand that when the driver starts up, a start trigger event is
>>
>>created
>>
>>>and some PCM data is passed in. After that, how does the subsequent PCM
>>
>>data
>>
>>>get pass into the driver?
>>
>>The ALSA middle layer passes PCM data to the driver only if the driver
>>attaches a function to the .copy() callback. Otherwise (and this is the
>>most common case) the ALSA ml copies data to/from the buffer on its own.
> 
> 
> 
> So when would it appropriate to attached a function to the .copy callback?
> Are you able to give me a clue which function actual performs the copying in
> the ALSA middle layer?
> 
> Thanks for you reponse thus far.
> 

Most sound cards use DMA to transfer sound samples from memory to the 
sound card hardware. The trigger(start) function initiates these DMA 
transfers, and the sound card controls the DMA. The sound card will just 
continue to repeat DMA transfers until told to trigger(stop). Each time 
a DMA transaction completes, an interrupt is generated. Each DMA 
transaction normally transfers one period of samples at a time from the 
ring buffer, so the interrupt routine calls period_elapsed to tell the 
rest of alsa that some samples have been transfered to the sound card. 
Inside period_elapsed, the hardware pointer in updated, so that alsa 
knows the current state of the sample ring buffer. If the sound 
application uses a callback method, this callback is then scheduled, and 
the sound application can then transfer another period of samples to the 
ring buffer.

If your sound card cannot do DMA transfers, you still need to ensure 
that the sound card can still generate interrupts. So the period_elapsed 
function is still called for each samples period. You then need to 
ensure that during the period_elapsed call, new samples are written to 
the sound card hardware. To do this, you implement the .copy function, 
and period_elapsed will call that to transfer the samples to the sound 
card on each interrupt.

If your sound card cannot generate interrupts for each samples period, 
you basically cannot use it with Linux.

I hope this helps

James


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
