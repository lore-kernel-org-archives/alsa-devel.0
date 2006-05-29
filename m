From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: dB gain
Date: Mon, 29 May 2006 18:34:06 +0100
Message-ID: <447B308E.2050502@superbug.co.uk>
References: <4478A290.80702@superbug.co.uk>	<s5hverp7zcr.wl%tiwai@suse.de>	<447B0A19.2050408@superbug.co.uk>
	<s5hy7wkddyf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net
	[194.217.242.85])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E3356153
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 19:34:07 +0200 (MEST)
In-Reply-To: <s5hy7wkddyf.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> 
> I agree to use numid.
> My argument is that numid can belong to the common header block.
> 
> The code you find in control.c is anyway a kind of object oriented.
> It's a message to a control element.
> But in this protocol, you get numid at very last, even depending on
> the type.  Thus the code looks like
> 
> 	type = get_type();
> 	len = get_length();
> 	switch (type) {
> 	case DB_SCALE:
> 		numid = get_value();
> 		kctl = get_kcontrol(numid);
> 		kctl->info2(kctl, ptr);
> 		...
> 	}
> 
> When you add more different types,
> 
> 	type = get_type();
> 	len = get_length();
> 	switch (type) {
> 	case DB_SCALE:
> 		numid = get_value();
> 		kctl = get_kcontrol(numid);
> 		kctl->info2(kctl, ptr);
> 		...
> 	case ANOTHER_DB_SCALE:
> 		numid = get_value();
> 		kctl = get_kcontrol(numid);
> 		kctl->info2(kctl, ptr);
> 		...
> 	case YET_ANOTHER_DATA:
> 		numid = get_value();
> 		kctl = get_kcontrol(numid);
> 		kctl->info2(kctl, ptr);
> 		...
> 
> 	}
> 
> If the numid is in the common block, we can simply extract numid
> first, then evaluate the type and value later, eventually call the
> callback at the single place.
> 
> 
> Takashi

My point is that there will only be one DB_SCALE case in the request
handler in control.c in the kernel. It simply calls info2(). The driver
then returns a TLV. The returned TLV will have all the variations on
db_scales. control.c won't care what the actual TLV value means. It will
simply return it to user space, and let alsa-lib work out what it is.
Another call the snd_ctl_misc might not even need a numid. It might
instead be requesting some other information, like card name or some
other future bit of info needed. My point is this is extensible, without
breaking kernel/alsa-lib binary compatibility.

James
