From: Nicolas Pitre <nico@cam.org>
Subject: Re: ALSA Driver for ARM
Date: Wed, 30 Mar 2005 11:50:02 -0500 (EST)
Message-ID: <Pine.LNX.4.62.0503301148130.13768@localhost.localdomain>
References: <42480A24.5070602@fetron.de>
 <Pine.LNX.4.62.0503291639330.13768@localhost.localdomain>
 <424A3E5E.8050600@fetron.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <424A3E5E.8050600@fetron.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: K.Fetscher@t-online.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 30 Mar 2005 K.Fetscher@t-online.de wrote:

> Nicolas Pitre schrieb:
> 
> > > I want to programm an driver for the Cirrus CS42516 and the ARM9 CPU
> > > EP93xx
> > > also from Cirrus.
> > >    
> > 
> > What kernel version are you using?
> > 
> >  
> I am using kernel 2.6.11.3-ep93xx

If it's 2.6.11 or above then the problem is most likely to be in your 
own code.  Prior kernel versions had problems with the mapping of DMA 
memory.


Nicolas


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
