From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RME DSP / Multiface documentation? (hdsp.c)
Date: Tue, 12 Nov 2002 10:32:31 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18Bcys-0006kp-00@usw-sf-list1.sourceforge.net>
References: <3DD112F4.B4A84A07@users.sourceforge.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 12 Nov 2002 16:40:52 +0200."
             <3DD112F4.B4A84A07@users.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "M. Nentwig" <nentwig@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I would like to help with the Hammerfall DSP driver.
>Is there any additional technical information? Could someone be so kind
>and forward it to me? The driver is easily readable, but it wouldn't
>hurt if I had the original documents still.

there are no documents. i have source code for a different OS from rme
under an NDA. sorry, i am not permitted to release them to you.

anyway, what is it that you want to help with? what needs work or
fixing or improving?

>Two more things:
>- The driver uses inlined functions quite extensively. But I think, that
>gcc does not inline functions, at least not with -O2 optimization, which
>was default (I tried -finline-functions, hdsp.o was different
>afterwards).

this has nothing to do with the driver itself, but with the
compilation environment, which is in turn a function of whether ALSA
is being built as part of the kernel or as a set of standalone
modules. please don't waste your time with this sort of stuff.

>- In snd_hdsp_interrupt: The first four lines determine, why the
>interrupt was triggered (audio, midi0, midi1). Now the MIDI code further
>down does not use that information, but the MIDI status instead. Could
>that be the cause for the audio dropouts, that happen now and then, when
>MIDI is received?

its not the cause of the dropouts, no. but you raise a good design
issue for the driver. its a bad idea to be handling both audio and
MIDI in the same thread. we should really use a bottom-half or a
tasklet to take care of the MIDI I/O. this would allow the interrupt
to complete much more rapidly.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
