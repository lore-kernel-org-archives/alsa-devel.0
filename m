From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [RFC] alsa-kernel, make control.c suspend aware
Date: Thu, 2 Mar 2006 23:07:20 +0100
Message-ID: <20060302230720.669b348f.pochini@shiny.it>
References: <20060302001859.58bd93af.pochini@shiny.it>
	<s5hmzg9865c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzg9865c.wl%tiwai@suse.de>
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

On Thu, 02 Mar 2006 11:58:39 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 2 Mar 2006 00:18:59 +0100,
> Giuliano Pochini wrote:
> > 
> > First attempt to add code that prevents someone to access the hardware via
> > control interface when the card is suspended.
> > 
> > I put the code in snd_ctl_elem_read_user() instead of snd_ctl_elem_read()
> > because /pci/hda/hda_codec.c:snd_hda_resume_ctls() calls the latter from the
> > resume callback. I had no time to check other things, consider it mostly
> > untested.
> 
> Looks fine.  We need also power_lock() around ioctls, too?

My driver doesn't use the ioctl interface, but if we want to make ti work
always, I think so.

->put() and ->get() are called directly only from
core/control.c:snd_ctl_elem_read() and core/control.c:snd_ctl_elem_write().
If we put snd_power_wait() in snd_ctl_elem_read/write() all their current
and future callers are protected, but /hda/hda_codec.c deadlocks in the
resume function (it's the only one). Otherwise, we can put snd_power_wait()
in snd_ctl_elem_read/write_user() and in _snd_ioctl32_ctl_elem_value().
Which choice ?  Do we duplicate power_wait or do we change hda_intel ?


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
