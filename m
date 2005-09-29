From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: SB Live! (5.1) has gone silent again with ALSA CVS
Date: Thu, 29 Sep 2005 18:02:39 +0100 (BST)
Message-ID: <20050929170239.53292.qmail@web52902.mail.yahoo.com>
References: <s5hhdc3dg7a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhdc3dg7a.wl%tiwai@suse.de>
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

--- Takashi Iwai <tiwai@suse.de> wrote:
> > What shows /proc/asound/cards?
> >=20
> > If it's "SBLive! Platinum 5.1 [SB0060]", you hit a known bug.
> > The below is a workaround, but it's not a right fix.

$ cat /proc/asound/cards
0 [SB-Live        ]: EMU10K1 - SBLive! Platinum 5.1 [SB0060]
                     SBLive! Platinum 5.1 [SB0060] (rev.7, serial:0x80611=
102) at 0xd800, irq 19

I've always thought that this was an "SBLive! Gamer". However, the 2nd fi=
x seems to have worked.

Thanks,
Chris



	=09
___________________________________________________________=20
To help you stay safe and secure online, we've developed the all new Yaho=
o! Security Centre. http://uk.security.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
