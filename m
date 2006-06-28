From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Control TLV extension - final proposal
Date: Wed, 28 Jun 2006 15:19:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606281501380.9302@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0606281350300.9302@tm8103.perex-int.cz>
	<s5hlkrhsbw4.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606281430310.9302@tm8103.perex-int.cz>
	<s5hirmlsagj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF8FF271
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jun 2006 15:19:26 +0200 (MEST)
In-Reply-To: <s5hirmlsagj.wl%tiwai@suse.de>
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

> > Yes, but that's the way how user control elements works. 
> 
> No, the question is how to pass the TLV list.  Using the same ioctl
> for completely different purposes is confusing.

Note that writting new TLV value / contents might make perfect sense, so 
it's not completely wrong.

> > The similar 
> > situation is for the element value where no "back to user space callback" 
> > exists so the written values cannot be verified.
> 
> Sorry what do you mean?  The elements without tlv write support?
> In that case, you can know the TLV-WRITE ioctl is invalid for that
> element beforehand.

No, I mean standard snd_ctl_elem_write() ioctl. There is no way to verify 
if passed value is ok (no communication with the user space - the creator 
task might not even exist, simply blind memcpy).

> > If you want the "correct" behaviour, an another layer must be designed 
> > and we may call these elements as user-defined version 2.
> 
> Urgh, it's a bad strategy to assume the next version before implementing 
> the first version.

Nope in my eyes, this implementation is far easier. Why bother with much 
difficult stuff like the value update request queueing now?

> > Also, an app which manages the user TLV value can mark the access only 
> > for read (although writting will be also possible).
> 
> This sounds like a good workaround although still inconsistency remains 
> (the access is allowed even though the flag bits not set). Also, if we 
> do in this way, it should be a job of alsa-lib rather than apps.

Yes, alsa-lib might do a better abstraction like "set_init_tlv_value".

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
