From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Sat, 16 Oct 2010 18:30:31 +0200
Message-ID: <201010161830.31603.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010161225.39002.julian@jusst.de>
	<1287237520.2113.11.camel@laptop-alex>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id DFB1C2417D
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Oct 2010 18:30:33 +0200 (CEST)
In-Reply-To: <1287237520.2113.11.camel@laptop-alex>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Lee <lee188@singnet.com.sg>
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Hi Alex,

Am Samstag, 16. Oktober 2010, 15:58:40 schrieb Alex Lee:
> On Sat, 2010-10-16 at 12:25 +0200, Julian Scheel wrote:
> > Thanks, I implemented them the way same you did. So for get_min/max/cur I
> > always return 48kHz and set_cur simply does nothing.
> > Now playback in general works again. But still the rate feedback seems to
> > have no impact on the data-rate. Also the frequency value shown in
> > proc-interface is unchanged. When rate feedback works, it would probably
> > be slightly different than 48.000kHz?!
>
> OK, you are getting close :-)

I hope so (c:
 
> One debug technique we have been using is to do a USB wire dump, using
> something like wireshark.  This way you can see exactly what goes on
> between the PC host and the device.

Yes, using wireshark is a good idea indeed. And it immediately turns out what 
the problem is.
The device sends ISOCHRONOUS out packets on the feedback endpoint (5, 
respectively 0x85) - but when I try to send 4 byte, the URB length is always 
0. If I only send 3 or less bytes the packets look fine.
I thought it might be a bug regarding max packet size in the at91lib and 
raised it to 5, but still only 3 bytes can be send. Any clues what might cause 
such an error?

> The other technique is to build a special debug kernel to have copious
> debug messages.
> 
> You might want to double check on the EP limitations.  Is the feedback
> EP capable of ISO transfer?  Are you able to use 4 bytes as the max EP
> size?  Is the EP double buffered (required for ISO transfers)?  With the
> wireshark dump you will be able to see exactly what is transferred as
> the feedback rate.

Yep, using endpoint 5, which is able to do ISO and has dual bank. It allows up 
to 512byte packet size.

> Also, the Max EP size of the ISO OUT data EP should only be one sample
> frame (ie 4 bytes in your case - 16 bits x stereo) bigger than the
> "correct" frame size, ie 192 bytes ====> 196 bytes.

Ok, changed that.

> I looked through your updated USB descriptors and they appear to be
> correct.

Fine, thanks (c:

Regards,
Julian
