From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: multiple devices per card?
Date: Fri, 4 Oct 2002 14:37:11 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021004213711.48471.qmail@web11503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This card can open / close N audio streams independently. Each audio stream can
be matched to a different port (e.g. mike in, line in) or the same, with
different formats if necessary.

Following your earlier message, I'd guess that a) is the solution. Then, only
one mixer is enough to handle all the devices.

Any other idea?

Thanks,
Guilhem.

> >I am unsure what makes the most sense for multiple pcm channels on the same
> >card:
> > a) N devices, 1 pcm channel each
> > b) 1 device, N pcm channels each
> >
> >In the same vein, is the mixer always one per card?
> 
> there is no way to tell without knowing more about the hardware. for
> the hammerfall series, for example, case (a) makes very little sense,
> since there is no way to independently start and stop the N
> devices. but there is hardware for which it might make sense.
> 
> some cards have no mixer. its not impossible a card that might have
> two (e.g. a digital and an analog mixer).
> 
> --p


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
