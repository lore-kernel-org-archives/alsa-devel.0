From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: [RFC] echoaudio, suspend/resume
Date: Mon, 27 Feb 2006 15:13:52 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0602271445330.1121@denise.shiny.it>
References: <20060225174117.1979de90.pochini@shiny.it> <s5hhd6lt4iu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhd6lt4iu.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



On Mon, 27 Feb 2006, Takashi Iwai wrote:

> At Sat, 25 Feb 2006 17:41:17 +0100,
> Giuliano Pochini wrote:
> >
> > The following patch is not to be merged yet. It adds suspend/resume support
> > to the echoaudio driver. It's ready for testing if someone wants to give it
> > a try. Maybe some detail is missing, but it should work on all cards.
> >
> > The problem is that the DSP "dies" if the driver tries to send it a command
> > (for example, set the output volume) after is has been shut down and a
> > reboot is required to resurrect it. ALSA doesn't automatically prevent the
> > user from accessing the card when it's suspended. Is there a simple way to
> > to it ?
>
> In which timing does it occur?

echo -n 3 >/sys/.../power/state
	--> power down ok

amixer cset xyz
	--> DSP dead


> If it occurs before calling resume callback (not meaning before
> completing resume callack), we should handle it better in the sound
> core to prevent it.

The resume callback has to reinit the card from scratch. It involves
loading 2 to 5 firmare images which takes several ms. I didn't check
after which phase the DSP begins behaving nicely when it receives an
unexpected command.
Of cource I can put an "if (suspended) return -EBUSY;" in each .put()
and trigger function, but if the middle layer already provides some sort
of global switch it's better IMHO. Other proposals are welcome.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
