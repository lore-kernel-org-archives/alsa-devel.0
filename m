From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ymfpci: A few questions
Date: Fri, 8 Feb 2002 08:47:30 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202080844500.514-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <02020720240003.02172@sequel.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Donald M Burns <donald@sequel.demon.co.uk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 7 Feb 2002, Donald M Burns wrote:

>
> Hi,
>
> I have a Yamaha YMF724 based soundcard and I had
> a bit of trouble getting midi going.
>
> I started with the RH7.1 OSS/Free driver and it would
> crash the machine if anything was sent to the soundcard
> from my keyboard. I discovered from playing with the source
> that there is no call to the midi interupt handler when
> the ymfpci driver received an INT#A interupt on the
> pci bus. So I think never mind - there is always ALSA.
>
> I've had a look over the ALSA code and it does
> support legacy ISA interupts for the midi. Unfourtunately,
> as explained in the Yamaha documetation, the ISA interupts
> can only work if they are routed to an ISA bridge:- typically
> the chip must be on a motherboard for the ISA interupts to work.
> As my YMF724 is on a sound card then the midi interface
> must generate PCI INT#A.
>
> So the questions..
>
> Do the interupts work properly for midi?
>
> Who is the maintainer/developer of the YMC PCI driver?

I'm. We follow the description in the datasheet. Note that by default
the IRQ is not used, but you can try it by defining the 'snd_mpu_irq'
module option.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
