From: Alex Lee <lee188@singnet.com.sg>
Subject: Re: USB asynchronous mode feedback format
Date: Sat, 16 Oct 2010 21:58:40 +0800
Message-ID: <1287237520.2113.11.camel@laptop-alex>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010151919.41810.julian@jusst.de>
	<1287193974.2133.2.camel@desktop-alex>
	<201010161225.39002.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp17.singnet.com.sg (smtp17.singnet.com.sg [165.21.6.27])
	by alsa0.perex.cz (Postfix) with ESMTP id 2075C103831
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Oct 2010 15:58:44 +0200 (CEST)
In-Reply-To: <201010161225.39002.julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-10-16 at 12:25 +0200, Julian Scheel wrote:

> Thanks, I implemented them the way same you did. So for get_min/max/cur I 
> always return 48kHz and set_cur simply does nothing.
> Now playback in general works again. But still the rate feedback seems to have 
> no impact on the data-rate. Also the frequency value shown in proc-interface 
> is unchanged. When rate feedback works, it would probably be slightly 
> different than 48.000kHz?!

Hi Julian,

OK, you are getting close :-)

One debug technique we have been using is to do a USB wire dump, using
something like wireshark.  This way you can see exactly what goes on
between the PC host and the device.

The other technique is to build a special debug kernel to have copious
debug messages.

You might want to double check on the EP limitations.  Is the feedback
EP capable of ISO transfer?  Are you able to use 4 bytes as the max EP
size?  Is the EP double buffered (required for ISO transfers)?  With the
wireshark dump you will be able to see exactly what is transferred as
the feedback rate.

Also, the Max EP size of the ISO OUT data EP should only be one sample
frame (ie 4 bytes in your case - 16 bits x stereo) bigger than the
"correct" frame size, ie 192 bytes ====> 196 bytes.

I looked through your updated USB descriptors and they appear to be
correct.

Alex
