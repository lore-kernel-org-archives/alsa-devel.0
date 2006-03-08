From: "Thibault LE MEUR" <Thibault.LeMeur@supelec.fr>
Subject: RE : [RFC][PATCH] snd-usb-audio and audiophile usb analog capture
Date: Wed, 8 Mar 2006 14:21:10 +0100
Message-ID: <067c01c642b3$2dcb3870$a578e4a0@supelec.fr>
References: <s5h1wxdrvke.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1wxdrvke.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> Could you include it in the patch as a document put in 
> Documentation directory?  Also don't forget to update 
> ALSA-Configuration.txt when an option is added/modified.

I will update the docs then.

> The patch itself is small and clean enough to include.
> 
> But I still think it'd be better to split it off to another 
> module so that more intuitive options could be used rather 
> than a magical number.

Yeah, you're right but I'm not sure I would be able to do this alone and
maintain a new driver.
I have to think about it but in the meantime I think that the current patch
(when modified) could to the trick.

> About the patch:  Could you fix the following?
> > +static int device_setup = 0x00; /* device specific setup 
> You don't need zero-initialization here.  A static variable 
> is guaranteed to be zero-initialized.

Ok, I'll remove the zero-initialization.

> Also, try not to exeed 80 columns in general :)

Don't you have a 40 inches LCD screen? ;-)
I'll fix that as well.

> > +int audiophile_skip_setting_quirk(int iface, int altno);
> 
> Please make it a static function.
Ok.

> Put continue to the next line.
> Put return to the next line (in other places, too).
Ok.

I'll send back the new patch when ready (should be done by the end of the
week).

Regards,
Thibault.




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
