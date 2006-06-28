From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Control TLV extension - final proposal
Date: Wed, 28 Jun 2006 14:40:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606281430310.9302@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0606281350300.9302@tm8103.perex-int.cz>
	<s5hlkrhsbw4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5868D187
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jun 2006 14:40:43 +0200 (MEST)
In-Reply-To: <s5hlkrhsbw4.wl%tiwai@suse.de>
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

> At Wed, 28 Jun 2006 13:57:50 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > Hi,
> > 
> > 	here is the final TLV update. The patch bellow will add:
> > 
> > - TLV write support
> > - TLV callback mechanism for lowlevel drivers
> > - TLV change notification
> > - TLV ioctl support for user space control elements
> 
> This implementation seems inconsistent.
> 
> Suppose you inquire an attribute via TLV_WRITE.  From the apps POV, it
> doesn't matter whether the mixer element is user-defined or not.  When
> alsa-lib issues ioctl(TLV_WRITE) to a user-defined element, it
> replaces the TLV list with the inquiry TLV but cannot return any
> useful value.

Yes, but that's the way how user control elements works. The similar 
situation is for the element value where no "back to user space callback" 
exists so the written values cannot be verified. If you want the "correct" 
behaviour, an another layer must be designed and we may call these 
elements as user-defined version 2. Also, an app which manages the user 
TLV value can mark the access only for read (although writting will be 
also possible).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
