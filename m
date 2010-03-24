From: Daniel Mack <daniel@caiaq.de>
Subject: Re: TASCAM US-1641
Date: Wed, 24 Mar 2010 23:50:20 +0100
Message-ID: <20100324225020.GO30801@buzzloop.caiaq.de>
References: <1269394483.6635.11.camel@eviltwin>
	<20100324055626.GH30801@buzzloop.caiaq.de>
	<1269468166.7429.7.camel@eviltwin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6466D243C1
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 23:50:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1269468166.7429.7.camel@eviltwin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jan Depner <eviltwin69@cableone.net>
Cc: ALSA_DEVEL <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 24, 2010 at 05:02:46PM -0500, Jan Depner wrote:
> On Wed, 2010-03-24 at 06:56 +0100, Daniel Mack wrote:
> > On Tue, Mar 23, 2010 at 08:34:43PM -0500, Jan Depner wrote:
> > I suggest adding some printk()s to the driver and see what it actually
> > does and which values it passes around. Most probably there is more
> > differences in the data format, and descriptors and/or message blocks
> > have different meanings for this hardware model.
> > 
> 
>     I did as suggested and got back reasonable appearing numbers for
> rate, use_packsize, and period_frames of 44100, 36, and 256 respectively
> but am not sure how to relate this to my interface.  Is there some
> documentation somewhere that would explain the output of lsusb -v with
> respect to variable names in us122l.c.  My problem here is that I don't
> know what would actually be reasonable for this interface nor how to
> find out.

Sorry I can't really help here. I've never dealt with any TASCAM
interface, and I don't know how close they are to any USB class
interface. Maybe Karsten can tell us more about that. 

>     Many thanks for your help with this.  Karsten had asked me to get
> back with him if I got one of these but my email to him must have gone
> to the spam filter as I haven't heard anything.

Cc'ed him on this mail :)

Daniel
