From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 latency / capture period
Date: Thu, 17 Jun 2004 14:37:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D1E4E7.8000704@joe-job.com>
References: <200406170906.i5H9604W013076@www1.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200406170906.i5H9604W013076@www1.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
Cc: pzad@pobox.sk
List-Id: alsa-devel@alsa-project.org

Peter Zubaj wrote:

>Hi,
>
>I don't well understand ALSA concepts, but I think, that minimum
>period size for emu10k1 is 384.
>  
>
True, it is actually 512 not 384.  This still results in input to output 
latency that  is 5-10x worse
than using ASIO drivers on Windows.

>Emu10k1 has actually 3 capture devices.
>0 - standard capture, stereo 16 bit / 8000 - 48000 Hz
>1 - mic capture - (implemented, not very used under ALSA) mono 16 bit
>/ 8000 Hz
>2 - fx capture - (implemented, not very used under ALSA) 1 - 32
>channels  16 bit / 48000 Hz
>
>All have same minimal period size, but 2 has 32 channels and then I
>think it is better for low latency and multichannel recording.
>  
>
Yes, the kX ASIO drivers on Windows work this way, by mapping directly 
onto the (16 for
SBLive, 32 for Audigy) FXBus channels.  You cannot directly capture line 
or mic in, you have
to connect it to an FXBus channel and then the signal is available on 
the corresponding ASIO
device.  I would imagine that to provide low latency in an ALSA driver 
it would work the same
way.

I am starting to reach the conclusion that this will require major 
changes to the guts of the emu10k1
ALSA driver.  I would love it if some ALSA developer would correct me 
but so far my inquirues
have met with deafening silence.

To reiterate the situation:  currently the ASIO drivers for this card 
provide an order of magnitude
better latency than the ALSA driver.  I am constantly hearing claims 
that ALSA is superior to ASIO,
but no one can tell me why the ALSA drivers for this *very* common 
device provide 5-10x worse latency
than the ASIO drivers.

As I see it, this is a glaring deficiency.

Lee

>Peter Zubaj
>====================== REKLAMA ========================
>Spolocnost SUN Microsystems uviedla na trh novy server Sun Fire V20z
>zalozeny procesoroch AMD Opteron.
>Viac informacii najdete na : http://www.somi.sk/sun/v20z.php
>=======================================================
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
>Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
>Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
>REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
