From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: documentation
Date: Wed, 24 Apr 2002 12:32:26 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020424193226.2349.qmail@web11503.mail.yahoo.com>
References: <s5h8z7dghjn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z7dghjn.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > What is required from my part to support memory mapping from the driver
> > to the application? Would this be supported through the OSS compatibility
> > layer, too?
> 
> hmm...  mmap without dma?
> how do you transfer the data on buffer to hardware?

The card doesn't support DMA, yet. Data is transferred to/from the buffer by
the driver copying 32-bit chunks. Those buffers were allocated by the MMAP,
today through the V4Lv2 API (this is an audio+video card).

> the copy and silence ops are called when write() is called (more
> exactly on alsa it's ioctl) - the thread writing to the device does
> actually work like DMA.  on mmap mode, there is no such one.  so you
> need an extra thread (or if it's not too heavy then tasklet might be
> available) anyway.

Having checked the brief documentation you referred to
(http://www.alsa-project.org/alsa-doc/alsa-lib/), I guess using the direct
audio buffer to communicate with the device means DMA+MMAP. I would like to do
the same thing, but have the driver actually copy data to/from the device. What
do you call "mmap mode" above?

Is there any other documentation more specific to driver development?

Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Games - play chess, backgammon, pool and more
http://games.yahoo.com/
