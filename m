From: Gerd Knorr <kraxel@suse.de>
Subject: Re: Problem with Avermedia 771
Date: Tue, 19 Oct 2004 18:13:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041019161340.GA12001@bytesex>
References: <416ED29A.7060200@qanu.de> <20041015101119.GH3866@bytesex> <Pine.LNX.4.58.0410151254140.20968@pnote.perex-int.cz> <20041018130114.GA5476@bytesex> <s5h3c0cjd24.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h3c0cjd24.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Gerd Knorr <kraxel@suse.de>, Jaroslav Kysela <perex@suse.cz>, Holger Waechtler <holger@qanu.de>, dvb list <linux-dvb@linuxtv.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >   (1) The ones where you can get audio data out of PCI function .1

> >   (4) Cards where PCI function .1 is simply unused, i.e. you get either
> >       nothing or just noise if you try to record audio from there.

> > I think the alsa driver should only try to use cards which fall into
> > group (1), not everything but (2).  Problem with that is that it simply
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > isn't known for most cards whenever they are in group (1) or (4).
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> I see the device list in drivers/media/video/bttv-cards.c as mentioned
> in Gerd's original post.  Which ones can be as the white list entries
> for ALSA?

Well, the problem is that no such list exists right now, I didn't keep
track of whenever Function .1 can do audio or not in bttvs card database
because bttv doesn't care, it does video only ...

So we'll have to build a whitelist from scratch from user feedback, and
maybe add a insmod option so you can ask the driver to grab the device
even if not whitelisted for easy use.

I know it works with my wintv (0070:13eb), but thats it :-/

  Gerd



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
