From: Matthias Koenig <list@phasorlab.de>
Subject: Re: tip for MOTU  MIDI users  - 64bit lockups workaround/fix
Date: Tue, 25 Apr 2006 11:27:56 +0200
Message-ID: <874q0i6m3n.fsf@zebra.localdomain>
References: <1145953559.9892.7.camel@daw.littlewolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1145953559.9892.7.camel@daw.littlewolf> (Allan Klinbail's
	message of "Tue, 25 Apr 2006 18:25:59 +1000")
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Allan Klinbail <allan_k@dodo.com.au>
Cc: alsa-user@lists.sourceforge.net, Alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Allan Klinbail <allan_k@dodo.com.au> writes:

> I don't know why this works but I thought I better share it. 
> Up until today I haven't been able to get my MOTU MTP-AV to work
> correctly in 64-bit linux. The entire PC would lock up as soon as it was
> accessed... .

Is this the mtpav driver?
Maybe this should be filed as bug report?

> In the driver options instead of pointing it to IRQ 5, as that is how my
> motherboard is set, I pointed it to IRQ 3.This was done out of confusion
> between DMA and IRQ number, not deliberately.  Ironically, it now works.
>
> I haven't completely tested the timing but the  MIDI messages are being
> sent to the right port at what seems to be the right time.. 

Transmitting MIDI likely does not depend on interrupts.
The question is if you can receive MIDI messages from external devices?

Regards,
Matthias


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
