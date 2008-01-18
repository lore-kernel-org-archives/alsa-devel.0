From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Thu, 17 Jan 2008 18:50:28 -0800
Message-ID: <1200624628.5011.130.camel@razman.gruemaster.com>
References: <BAY109-W142AC68EEEFBE84915C87CA9410@phx.gbl>
	<1200623185.2028.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DA4924790
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 03:50:31 +0100 (CET)
In-Reply-To: <1200623185.2028.42.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiang zhe <zhe.jiang@intel.com>
Cc: Claudio Matsuoka <cmatsuoka@gmail.com>, ALSA Developers <alsa-devel@alsa-project.org>, De Fuuss <fuuss@hotmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-01-18 at 10:26 +0800, Jiang zhe wrote:

> On Thu, 2008-01-17 at 19:31 +0000, De Fuuss wrote:
> > Hi,
> > 
> > Indeed it works. As you mght have noticed I'm new to ALSA ;-) and I
> hadn't noticed that some of the channels could be muted. I thought
> they were muted only when at 0%. I also get
> "hda_codec_setup_stream:NID=" lines in dmesg now. I'm really sorry
> about that, it's really a beginner's mistake.
> > 
> > At least one good thing came out of it: I can confirm that hda_intel
> works with model=6stack-hp on the XPC Shuttle SG33G5M . I will
> continue to carry out tests to see if there are any issues with Mic,
> line out, spdifs etc..
> > 
> Since there are only five jacks on the back panel, 
> It's better to implement a 5stack-hp model for it.
> I will do it.
> 
> Best regards!
> 

In looking at the system, while I only see 5 analog plugs on the back on
the motherboard, I do see an spdif port on the back of the chassis.  I
would recommend just leaving it as a 6 stack config, unless there is a
definitive difference that your code would make.  Keep it simple.


-- 
Tobin Davis  


 Debian - All the power, without the silly hat.
