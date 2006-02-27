From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] echoaudio, suspend/resume
Date: Mon, 27 Feb 2006 22:18:31 +0100
Message-ID: <20060227221831.7c485b7c.pochini@shiny.it>
References: <20060225174117.1979de90.pochini@shiny.it>
	<s5hhd6lt4iu.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0602271445330.1121@denise.shiny.it>
	<s5h4q2kubh5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4q2kubh5.wl%tiwai@suse.de>
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
Cc: pochini@denise.shiny.it, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Feb 2006 15:23:34 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> > > In which timing does it occur?
> > 
> > echo -n 3 >/sys/.../power/state
> > 	--> power down ok
> > 
> > amixer cset xyz
> > 	--> DSP dead
> > 
> > 
> > > If it occurs before calling resume callback (not meaning before
> > > completing resume callack), we should handle it better in the sound
> > > core to prevent it.
> >
> > The resume callback has to reinit the card from scratch. It involves
> > loading 2 to 5 firmare images which takes several ms. I didn't check
> > after which phase the DSP begins behaving nicely when it receives an
> > unexpected command.
> > Of cource I can put an "if (suspended) return -EBUSY;" in each .put()
> > and trigger function, but if the middle layer already provides some sort
> > of global switch it's better IMHO. Other proposals are welcome.
>
> Hm, strange, prepare or trigger callback shouldn't be called at least
> unless snd_power_change_state(D0) is called.  The power status is
> checked in the middle layer.

Yes, PCM trigger works as desired indeed, but MIDI trigger doesn't.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
