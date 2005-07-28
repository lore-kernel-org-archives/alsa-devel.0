From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Volume per voices [Feature Request]
Date: Thu, 28 Jul 2005 09:25:57 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0507280924130.9785-100000@studcom.urz.uni-halle.de>
References: <s5h7jfcuuj5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jfcuuj5.wl%tiwai@suse.de>
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
Cc: Jaroslav Kysela <perex@suse.cz>, Giuliano Pochini <pochini@shiny.it>, Dino Puller <dino@e4a.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Clemens Ladisch wrote:
> >
> > Takashi Iwai wrote:
> >
> > > but unfortunately, the situation is confusing.  Some drivers
> > > already use PCM iface for different purposes (e.g. hdsp) and some
> > > use mixer iface for exactly this purpose (e.g. emu10k1)...
> >
> > Then I'd consider these drivers buggy.
> >
> > I'll write a patch unless anybody objects ...
>
> Basically I agree with fixing this mess.
>
> The only concern is the backward compatibility.  Especially, apps
> specific to hdsp assume that the controls have PCM iface.

As long as those apps are part of the alsa-tools package, we can
change them, too.

It seems hdspmixer uses both .numid and all other fields of the
control ID to select controls.  This needs to be changed anyway ...


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
