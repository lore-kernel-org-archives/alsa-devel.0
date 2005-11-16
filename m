From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Dmix and non SND_PCM_TYPE_HW slaves
Date: Wed, 16 Nov 2005 16:14:31 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0511161614090.9655@tm8103.perex-int.cz>
References: <OFB5C60420.D5C0FB76-ON652570BA.00273D48-652570BA.00273D59@flextronicssoftware.com>
 <Pine.LNX.4.61.0511150835390.9148@tm8103.perex-int.cz> <s5hek5ixlat.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0511161523230.9655@tm8103.perex-int.cz> <s5h64qshcjq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h64qshcjq.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: sameer.kittur@flextronicssoftware.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 16 Nov 2005, Takashi Iwai wrote:

> At Wed, 16 Nov 2005 15:24:26 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > On Tue, 15 Nov 2005, Takashi Iwai wrote:
> > 
> > > At Tue, 15 Nov 2005 08:39:06 +0100 (CET),
> > > Jaroslav wrote:
> > > > 
> > > > On Tue, 15 Nov 2005 sameer.kittur@flextronicssoftware.com wrote:
> > > > 
> > > > > Hi all,
> > > > > 
> > > > >     Is there a reason why Dmix cannot use a non SND_PCM_TYPE_HW slave? Is
> > > > > there no way to re-direct the Dmix output to another plugin or an
> > > > > external I/O or a filter plugin?
> > > > 
> > > > It's impossible without massive changes to the dmix code and structure. 
> > > > Dmix uses too much driver specific things like the PCM timer, passing PCM 
> > > > device file-descriptor among applications etc. Also, the latency can be 
> > > > much worse when the dmix plugin will use only SHM ring buffer or so.
> > > 
> > > Actually, it's difficult to apply the current dmix model to a
> > > (user-space) driver without DMA like bluez.  We need to gather the
> > > data from all clients and send only once to the hardware in such a
> > > case.  So, the solution with a sound server looks most appropriate.
> > 
> > It's not so difficult, but extra double buffering will be added between 
> > producer and consumer, so the latency increases min. twice.
> 
> Hmm, but still this doesn't work well.  Remember that the data chunk
> once tranferred cannot be modified any longer.  Hence, to get a low
> latency, the buffer must be sent just before the active update.
> In the best case, we may have only 2 periods in practice.
> 
> This would work if a server process runs in a high task priority, but
> not for the models with parallel accessses like dmix.

I meant a daemon with RT priority which will "emulate" DMA.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
