From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Wine failures with Alsa 1.0.0rc1
Date: Thu, 4 Dec 2003 06:49:31 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGIECOECAB.mknecht@controlnet.com>
References: <s5hoeuoafc7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoeuoafc7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
> it's a very old symbol used only in ALSA 0.5.x.
> most likely the detection code in wine is broken, typically checking
> only SND_MINOR_VERSION and not checking SND_MAJOR_VERSION.
> if so, the wine driver believes that it's a 0.5.x, since the minor
> version is 0 now.
>
>
> Takashi

Thanks Takashi. I'm running Codeweavers Crossover Office, so I'll pass this
on to them first. Possibly I'll also try Transgaming's version of Wine which
is likely newer and more up to date.

- Mark




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
