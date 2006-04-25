From: Matthias Koenig <list@phasorlab.de>
Subject: Re: [PATCH] Support for ESI Miditerminal 4140
Date: Tue, 25 Apr 2006 17:33:55 +0200
Message-ID: <87mze9mzz0.fsf@zebra.localdomain>
References: <87wtdeevlh.fsf@zebra.localdomain> <s5hbquq266i.wl%tiwai@suse.de>
	<87wtde56js.fsf@zebra.localdomain> <s5h3bg20y35.wl%tiwai@suse.de>
	<874q0hvohs.fsf@zebra.localdomain> <s5hslo1zu6e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hslo1zu6e.wl%tiwai@suse.de> (Takashi Iwai's message of "Tue,
	25 Apr 2006 15:00:41 +0200")
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:
> The mutex belongs to the rawmidi device, so open/close is mutual as
> long as the same rawmidi device is used no matter which substream is
> used.  It doesn't care open/close of another rawmidi device, though.

Ah, thanks! This is the informationen I needed.

>> Hmm, then why should I hold an additional mutex?
>
> Well, I just thought of something as a replacement of mts->lock, but
> regarding open/close, yes, you can get rid of an extra mutex.
>
> You might still need a spinlock somewhere, but definitely not together
> with mdelay().

Yes, I decoupled now delay stuff from the spinlock sections and placed
the spinlocks just near the HW access.

New patch for next turn will follow.

Matthias


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
