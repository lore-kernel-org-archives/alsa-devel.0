From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]snd-usb-usx2y 0.8.0 against alsa-kernel cvshead: OHCI doesn't crash anymore
Date: Fri, 1 Oct 2004 18:28:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410011828.32664.annabellesgarden@yahoo.de>
References: <200409302046.29798.annabellesgarden@yahoo.de> <s5h7jqa1rab.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jqa1rab.wl@alsa2.suse.de>
Content-Disposition: inline
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

Am Freitag 01 Oktober 2004 15:50 schrieb Takashi Iwai:
>
> What is the purpose of the replacement with USX2Y_STATIC?
>
Its for easier appliance of the patch, I sent a little later yesterday 
22:01:50:
"[Alsa-devel] [PATCH]hwdep addon for raw usb mmap from userspace against 
snd-usb-usx2y 0.8.0 in alsa-kernel tree"
The addon needs the functions with the USX2Y_STATIC.
So the addon patch only needs to change
	#define USX2Y_STATIC static
to
	#define USX2Y_STATIC
.
> One thing I'm not sure is that the possible race of usX2Y_urbs_start()
> and usX2Y_subs_startup_finish().  Better to use complete handler?
>
Thanks for the hint. Will look at it again.

Karsten


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
