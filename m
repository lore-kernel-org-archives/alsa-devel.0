From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: buffer_size and period_size
Date: Mon, 27 Jan 2003 09:48:15 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGCEGKBDAB.mknecht@controlnet.com>
References: <E18dD2R-00085w-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18dD2R-00085w-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul,
   So with -p 64 -n 2 settings, what number of bytes of audio data is
transferred across the PCI bus between each interrupt?

   I guess I had mistakenly thought -p was setting the number of bytes. I no
longer think that is true.

   Also, does the number of bytes transferred change based on how many
channels are enabled? Or does my RME always transfer 26 channels of data
even if I am not using some channels?

   I am assuming that a card like the RME is a bus master, moves so many
bytes, and then interrupts to tell the system that the bytes are there. Is
this basically the case?

Thanks,
Mark

> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Paul Davis
> Sent: Monday, January 27, 2003 9:32 AM
> To: Jozef Kosoru
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] buffer_size and period_size
>
>
> >I would like to fully understand the exact meaning of buffer_size and
> >period_size and how can I compute the final latency in the full duplex
> >processing from these variables.
>
> period_size = frames between interrupts from the hardware
> buffer size = total frames for the hardware buffer
>
> max output latency = buffer_size
> min output latency = buffer_size - period_size
>
> max input latency = period_size + interrupt overhead
> min input latency = 1 frame + interrupt overhead
>
> the latency numbers assume:
>
>     a) the buffer is generally full
>     b) you process data 1 period at a time
>     c) your s/w keeps up with the h/w
>     d) its an average, computed across a period's worth of data
>
> --p
>
>
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
