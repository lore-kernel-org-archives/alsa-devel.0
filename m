From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: rme9652: possible deadlock
Date: Mon, 28 Apr 2003 20:16:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304282013310.1603-100000@pnote.perex-int.cz>
References: <3EAD22C4.70309@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EAD22C4.70309@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Jeremy Hall <jhall@maoz.com>, "paul@linuxaudiosystems.com" <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Apr 2003, Abramo Bagnara wrote:

> Jaroslav Kysela ha scritto:
> >>CPU1:
> >>
> >>read_lock(link_manager);	read_lock(link_manager);
> >>spin_lock(s1);			spin_lock(s2);
> >>if (stream_in_group)		if (stream_in_group)
> >>	spin_lock(group);		spin_lock(group); /* Waiting */
> >>spin_lock(s2); /* BOOM! */
> >>
> >>I guess that 3rd version will be the one I propose ;-)
> > 
> > 
> > Yep, it is in CVS now ;-) Except I don't use trylock...
> > 
> > read_lock(link_manager);
> > spin_lock(stream);
> > ....
> > if (stream_in_group) {
> >     spin_lock(group);
> >     spin_unlock(stream);
> > }
> > ....
> > link_for_each(s) {	/* note that streams are locked in defined order now */
> >     if (stream_in_group)
> >         spin_lock(s);
> > }
> > ....
> > list_for_each(s) {
> >     if (stream_in_group)
> >         spin_unlock(s);
> > }
> > ....
> > if (stream_in_group) {
> >     spin_lock(stream);
> >     spin_unlock(group);
> > }
> > ....
> > spin_unlock(stream);
> > read_unlock(link_manager);
> 
> CPU1:				CPU2:
> read_lock(link_manager);	read_lock(link_manager);
> spin_lock(s1);			spin_lock(s2);
> spin_lock(group);		spin_lock(group); // waiting
> spin_unlock(s1);
> //inside list_for_each
> spin_lock(s1);
> spin_lock(s2); // BOOM!
> 
> I fear you cannot avoid trylock ;-)

And this scenario:

read_lock(link_manager);
spin_lock(s1);
if (stream_in_lock) {
  spin_unlock(s1);
  spin_lock(group);
}
...


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
