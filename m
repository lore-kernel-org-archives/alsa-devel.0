From: James Tappin <james@tappin.me.uk>
Subject: Re: the last changes to trident driver
Date: Wed, 8 Jan 2003 18:38:24 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030108183824.06b3e7e8.james@tappin.me.uk>
References: <s5hn0md9c9s.wl@alsa2.suse.de>
	<20030107232051.2861d226.james@tappin.me.uk>
	<s5hbs2s9cns.wl@alsa2.suse.de>
	<20030108110650.1d579069.sjt@star.sr.bham.ac.uk>
	<s5h8yxvam1u.wl@alsa2.suse.de>
	<20030108125227.4ee7ff0a.sjt@star.sr.bham.ac.uk>
	<s5h4r8jaj1c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4r8jaj1c.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 08 Jan 2003 14:05:35 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 8 Jan 2003 12:52:27 +0000,
> James Tappin wrote:
> > 
> > TI> 
> > TI> hmm, unfortunately the stack wasn't parsed correctly with symbols.
> > TI> did you build the alsa drivers with debug option
> > TI> (--with-debug=full)? anyway, please rebuild the drivers with the
> > TI> attached patch (and debug option, if not yet).  i hope a fatal
> > TI> oops or hang-up can be avoided now...
> > TI> oh, also, please update the cvs tree again.  i've done some
> > TI> changes since yesterday.
> > 
> > As far as I can tell that works, i.e. the modules load, aplay plays a
> > wav file and there's nothing in /var/log/syslog -- I can't tell if any
> > sound's coming out.
> 
> thanks.  then it's better to commit it to cvs, to avoid for other
> people to get oops :)

Just a quickie to say that the updated version does indeed produce sound
as it should. I can't test anything other than PCM output as thats the
only hardware I have.

Thanks for the good work,
	James


-- 
James Tappin,             O__      "I forget the punishment for using
james@tappin.me.uk       --  \/`    Microsoft --- Something lingering
http://www.tappin.me.uk/            with data loss in it I fancy"  


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
