From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: rme9652: possible deadlock
Date: Mon, 28 Apr 2003 14:47:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EAD22C4.70309@libero.it>
References: <Pine.LNX.4.44.0304281418140.1603-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0304281418140.1603-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jeremy Hall <jhall@maoz.com>, "paul@linuxaudiosystems.com" <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela ha scritto:
>>CPU1:
>>
>>read_lock(link_manager);	read_lock(link_manager);
>>spin_lock(s1);			spin_lock(s2);
>>if (stream_in_group)		if (stream_in_group)
>>	spin_lock(group);		spin_lock(group); /* Waiting */
>>spin_lock(s2); /* BOOM! */
>>
>>I guess that 3rd version will be the one I propose ;-)
> 
> 
> Yep, it is in CVS now ;-) Except I don't use trylock...
> 
> read_lock(link_manager);
> spin_lock(stream);
> ....
> if (stream_in_group) {
>     spin_lock(group);
>     spin_unlock(stream);
> }
> ....
> link_for_each(s) {	/* note that streams are locked in defined order now */
>     if (stream_in_group)
>         spin_lock(s);
> }
> ....
> list_for_each(s) {
>     if (stream_in_group)
>         spin_unlock(s);
> }
> ....
> if (stream_in_group) {
>     spin_lock(stream);
>     spin_unlock(group);
> }
> ....
> spin_unlock(stream);
> read_unlock(link_manager);

CPU1:				CPU2:
read_lock(link_manager);	read_lock(link_manager);
spin_lock(s1);			spin_lock(s2);
spin_lock(group);		spin_lock(group); // waiting
spin_unlock(s1);
//inside list_for_each
spin_lock(s1);
spin_lock(s2); // BOOM!

I fear you cannot avoid trylock ;-)

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
