From: Andreas Kilgus <kilgus@fuenfsieben.de>
Subject: Re: current cvs: problems with ice1712?
Date: Fri, 18 Oct 2002 21:25:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210182125.53739.kilgus@fuenfsieben.de>
References: <Pine.LNX.4.33.0210152220170.703-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0210152220170.703-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela schrieb:

> On Tue, 15 Oct 2002, Fernando Pablo Lopez-Lezcano wrote:
>
> > Looks like ice1712 is currently broken :-(
>
> Everything seems broken ;-( Try CVS again. Thanks.

My EWX24/96 produces sound (I'm using alsa-0.9.0.cvs20020903, 
distributed with SuSE 8.1) - but I can't manage MusE to use this card 
successfully as Alsa-Hardware, it keeps complaining "Sample format non 
available", though /etc/asound.conf contains

pcm.ice1712 {
        type plughw
        card 0
}

ctl.ice1712 {
        type plughw
        card 0
}

If I force MusE to use my Onboard-Soundchip (SIS7012, i810-Driver), 
everything works.

1.
Which place is the right one to look at - is this a problem of MusE or 
something possibly caused by a partly broken driver (or a configuration 
issue)?

2.
If the latter is the case - is it possible to integrate the source for 
the ICE1712 driver from CVS in the sources delivered with SuSE? I don't 
want to go into a fight to get Alsa compiled/running again, I just 
liked to see, if a newer driver would solve this problem...

Andi


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
