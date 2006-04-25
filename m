From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Re: [Alsa-devel] [PATCH] Add Dreamcast
	AICA	driver to alsa-driver
Date: Tue, 25 Apr 2006 20:20:12 +0100
Message-ID: <1145992812.9249.5.camel@localhost.localdomain>
References: <1145831786.9242.38.camel@localhost.localdomain>
	 <1145832383.9242.41.camel@localhost.localdomain>
	 <s5hacab44bw.wl%tiwai@suse.de>
	 <1145900695.9243.4.camel@localhost.localdomain>
	 <s5hejzm26x0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-admin@lists.sourceforge.net>
In-Reply-To: <s5hejzm26x0.wl%tiwai@suse.de>
Sender: linuxsh-dev-admin@lists.sourceforge.net
Errors-To: linuxsh-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxsh-dev>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>, Lee Revell <rlrevell@joe-job.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-04-24 at 19:57 +0200, Takashi Iwai wrote:
> At Mon, 24 Apr 2006 18:44:55 +0100,
> Adrian McMenamin wrote:
> > 
> > > 
> > > > +static int stereo_buffer_transfer(struct snd_pcm_substream
> > > > +				  *substream, int buffer_size, int period)
> > > > +{
> > > 
> > > I feel this transfer-and-wait could be done more efficiently using
> > > workq than doing it in timer callback.  The trigger(start) and
> > > aica_period_elapsed() calls queue_work() at each time.
> > > 
> > > The most work of spu_begin_dma() should be put in the workq, too.
> > > 
> > 
> > heh. If you remember, a couple of months ago I had this in a kernel
> > thread - ie much the same - and you or Lee said I should absolutely not
> > use that mechanism :)
> 
> Well, a source code tell you better than hundreds words :)
> 
> 
Unfortunately using the workqueue method bumps up the processor usage
figure up to 100% or pretty close for high demand samples.

So whilst mpg123 might drop from say 42% of CPU time to 36%, the kernel
thread uses up about 60% of processor time.

Why do you think using a workqueue/kernel thread is the right way to go?
Is it because of the global dma lock? That can be dropped, I'd much
rather have the (theoretical) occasional mess of the samples being
played rather than have a model that is so vulnerable to other demands
on the CPU.



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
