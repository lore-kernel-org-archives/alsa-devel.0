From: "Martijn Sipkema" <m.j.w.sipkema@student.tudelft.nl>
Subject: Re: unitor8/amt8 driver for alsa 0.9.0rc1
Date: Wed, 1 May 2002 14:02:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <006901c1f110$84014110$0400a8c0@martijn>
References: <Pine.LNX.4.40.0205011238180.988-100000@dunk.hq.fett.net>
Reply-To: "Martijn Sipkema" <m.j.w.sipkema@student.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Manush Dodunekov <manush@stendahls.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > This is nice. What documentation did you use for writing the driver?
> 
> http://www.math.tu-berlin.de/~sbartels/unitor/unitor8_doc.txt
> 
> It's in German. I have a translation of it I made using some online
> translation thingy a while ago, but I still find the German version a bit
> more readable (and my German really sucks).

I have that document also. Emagic would not give me any AMT
documentation, that's why I aksed.

> > Also, using a kernel driver does not allow using many different serial
> > hardware, right?
> 
> I don't see why not. As long as it doesn't limit itself to a maximum of
> one instance at a time.

How does this work then? Can a file be opened from kernel space? Or
is there a kernel module with an standard interface for serial devices?
This would be needed in order to be able to use other than standard
pc serial hardware such as usb serial convertors and professional multi
port serial adapters, right? I was under the impression you were accessing
the serial hardware directly.




_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
