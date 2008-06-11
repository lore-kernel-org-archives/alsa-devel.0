From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Impact of SW on USB Audio?
Date: Wed, 11 Jun 2008 23:27:51 +0200
Message-ID: <48504357.7080601@insite.cz>
References: <4847F425.7040402@insite.cz> <s5htzfz2972.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 3472324906
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 23:27:57 +0200 (CEST)
In-Reply-To: <s5htzfz2972.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Takashi Iwai napsal(a):
> At Thu, 05 Jun 2008 16:11:49 +0200,
> Pavel Hofman wrote:
>> Hi,
>>
>> Please excuse my non-devel question but the most knowledgeable people
>> read this mailing list.
>>
>> Can user-space software (regular players) directly influence quality of
>> USB adaptive audio output? IOW, how sensitive is adaptive USB to the
>> rhythm of the data infeed to the USB controller?
>>
>> I understand for standard PCI soundcards it is all only about timely
>> delivery of enough data to DMA memory,the card takes care of the rest
>> itself. Do USB controllers shield applications from the rest in the same
>> manner?
>>
>> The adaptive mode is sensitive to jitter of the data stream from the USB 
>> controller to the receiver. Can SW players influence the jitter, e.g. by 
>> moving the wav files from HDD to RAM disk etc.?  I assume a lightly 
>> loaded system with no major data delays.
>>
>> Thanks a lot for any insight, I could not google-out any relevant
>> information.
> 
> The usb-audio uses isochronous transport, i.e. you'll send packets of
> data at a certain period.  But, it's a driver implementation issue and
> from the user-space POV, there is no big difference.  The URB-complete
> callback corresponds to the DMA IRQ of PCI devices.
> 
> (Of course, if you want a very short period in a real-time manner, the
> transfer efficiency matters largely, though.  But it's a different
> story than the load you described above.)

Takashi,

Thanks a lot for your reply which has narrowed down the area I will have 
to look at detail.

Regards,

Pavel.
