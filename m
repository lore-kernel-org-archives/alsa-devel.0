From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Wed, 02 Apr 2003 18:36:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E8B119E.40600@libero.it>
References: <Pine.LNX.4.44.0304021635500.3649-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0304021635500.3649-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela ha scritto:
> 
> I feel we are still thinking in a different way. The separating of
> volatile data is only access and memory optimization. The code in the
> control interface uses still linear lookups. Note that there is no
> restriction to use this "multi" element for matrix only. Then address in

I realized that.

> matrix is always mapped to linear one. If you want a gap inside matrix,
> then set the INACTIVE flag to the access field (volatile data). It's quite

It's not inactive, it does not exists.

> complicated to describe such incomplete matrixes in a generic way. Note

? Why complicated?

What about snd_ctl_add_index(ctl, index) (then you can use data tables, 
loops, wrappers, etc.)

> that the whole matrix is still represented as one multi element inside the
> kernel space (except that volatile data are separate for each value inside
> matrix).

This is true only for non sparse matrix.

Ortogonally to that, IMO the increasing numbers of controls in modern 
professional hardware justify the choice of hash table access to 
controls (try to imagine a 26 channel hardware level meter that need to 
be polled 50 times per second).

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
