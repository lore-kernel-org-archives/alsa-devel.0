From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Control TLV extension - final proposal
Date: Wed, 28 Jun 2006 16:25:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606281620500.9302@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0606281350300.9302@tm8103.perex-int.cz>
	<s5hlkrhsbw4.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606281430310.9302@tm8103.perex-int.cz>
	<s5hirmlsagj.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606281501380.9302@tm8103.perex-int.cz>
	<s5hejx9s8fg.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606281544540.9302@tm8103.perex-int.cz>
	<s5h8xnhs78q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EAD80235
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jun 2006 16:25:17 +0200 (MEST)
In-Reply-To: <s5h8xnhs78q.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 28 Jun 2006, Takashi Iwai wrote:

> At Wed, 28 Jun 2006 15:54:07 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Wed, 28 Jun 2006, Takashi Iwai wrote:
> > 
> > > It's fine because snd_ctl_eme_read() and snd_ctl_elem_write() are
> > > really corresponding 1:1.  The write is just write, and the read is
> > > just read.
> > 
> > It might be for TLV, too. But I agree, we have basically two "write" 
> > requests:
> > 
> > 1) do a TLV command processing
> > 2) do a TLV value write operation
> > 
> > In such case, I think that we need third ioctl TLV_COMMAND? I can rename 
> > write_flag to op_flag or so and we are fine. Also creating 
> > ACCESS_TLV_COMMAND might make sense. It's ok for you?
> 
> Yeah, the separate ioctls sound reasonable.
> 
> Is TLV_WRITE applicable to normal control elements?  If it's only for
> user-space elements, we should rename it such as TLV_WRITE_USER or
> so.

We are defining an universal API and I think that value might be 
updated also for in-kernel controls. It will const us nothing from 
the implementation side (only a call specification for the tlv callback 
in the kernel).

> > The only bad thing is that the TLV write replaces the whole TLV tree for 
> > the user elements. Perhaps, a flag can be added to 'struct snd_ctl_tlv'
> > which will mean 'partial write', so we can distinguish the full / partial 
> > operations and implement only full write at the time.
> 
> I'm afraid that it would bring unnecessary complexity.
> The TLV_READ is anyway the read of the whole TLV tree.  So, TLV_WRITE
> should be same.

Yes, I meant it only as extension for future. We may use 31.bit from 
snd_ctl_tlv.length as an identifier for partial writes, but we can leave
only full write for now.

> Anyway, still I think we'd better implement and test example codes in
> alsa-lib before committing to alsa-kernel codes...

I'm adding TLV stuff to alsa-lib right now.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
