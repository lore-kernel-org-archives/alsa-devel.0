From: Manush Dodunekov <manush@stendahls.net>
Subject: Re: unitor8/amt8 driver for alsa 0.9.0rc1
Date: Wed, 1 May 2002 14:25:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.40.0205011416020.3813-100000@dunk.hq.fett.net>
References: <006901c1f110$84014110$0400a8c0@martijn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <006901c1f110$84014110$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 1 May 2002, Martijn Sipkema wrote:

> > > This is nice. What documentation did you use for writing the driver?
> >
> > http://www.math.tu-berlin.de/~sbartels/unitor/unitor8_doc.txt
> >
> > It's in German. I have a translation of it I made using some online
> > translation thingy a while ago, but I still find the German version a bit
> > more readable (and my German really sucks).
>
> I have that document also. Emagic would not give me any AMT
> documentation, that's why I aksed.

Did they actually say 'no', or just didn't answer?


> > > Also, using a kernel driver does not allow using many different serial
> > > hardware, right?
> >
> > I don't see why not. As long as it doesn't limit itself to a maximum of
> > one instance at a time.
>
> How does this work then? Can a file be opened from kernel space? Or is
> there a kernel module with an standard interface for serial devices?
> This would be needed in order to be able to use other than standard pc
> serial hardware such as usb serial convertors and professional multi
> port serial adapters, right?

The best way would be to simply use /dev/ttyS* from userspace. This
eliminates any dependencies on the underlying serial driver. I think.


> I was under the impression you were accessing the serial hardware
> directly.

Yes I am, but only the port in question. The other ports can still be
accessed in whatever way you like. It's still an ugly approach though.

-- 
Manush
