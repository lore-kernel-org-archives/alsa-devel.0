From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]snd-usb-usx2y
Date: Thu, 4 Dec 2003 23:02:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312042302.14540.annabellesgarden@yahoo.de>
References: <200311271544.21367.annabellesgarden@yahoo.de> <20031204193009.GA678@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031204193009.GA678@tuba.home>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 4. Dezember 2003 20:30 schrieb Martin Langer:
>
> Karsten, your us428 fix breaks us122 support.
> usX2Y_rate_set(usX2Y_stream, 44100)) isn't possible on us122.
>

usX2Y_rate_set() is being called when you start audio also.
So audio stops working on the us122 with this patch?
Would it work with 48000 instead of 44100?

Karsten



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
