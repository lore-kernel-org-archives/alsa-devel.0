From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] integrate snd-usb-midi into snd-usb-audio
Date: Tue, 3 Sep 2002 16:27:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020903142749.31441.qmail@web12205.mail.yahoo.com>
References: <s5hlm6tbnye.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlm6tbnye.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: tiwai@suse.de, clemens@ladisch.de
Cc: alsa-devel@lists.sourceforge.net, karsten wiese <annabellesgarden@yahoo.de>
List-Id: alsa-devel@alsa-project.org

 --- Takashi Iwai <tiwai@suse.de> schrieb: > Hi,
> 
> thanks.  the patch is applied now to cvs.
> could you check whether it works for you?
> 
> 
> Karsten, can you rewrite the patch for your tascam
> driver based on
> this new mechanism?  if any other changes are
> needed, please let us
> know.
> 
no changes needed. works well as it is now.
changed tascam driver available via email.
Tascam did not answer yet our calls to allow us the
use of their firmware.

proposal for autoloading snd-usb-midi from
snd-usb-audio if needed:

	request_module( "snd-usb-midi");

this way the tascam driver releaves the user from
taking care that snd-usb-midi is present.

Karsten

__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
