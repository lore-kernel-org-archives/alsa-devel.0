From: Dan Hollis <goemon@anime.net>
Subject: Re: alsa 0.9.0rc2 trident incompatible with 2.4.19
 pcigame?
Date: Mon, 16 Sep 2002 04:27:47 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209160416300.844-100000@sasami.anime.net>
References: <s5h3csatd9d.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3csatd9d.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 16 Sep 2002, Takashi Iwai wrote:
> At Mon, 16 Sep 2002 03:33:35 -0700 (PDT),
> > 0.9.0rc2 trident driver on kernel 2.4.19 doesn't seem to have any joystick 
> > support at all.
> gameport support (not called as joystick) was already there.
> could you check whether snd_trident_gameport() is really called (by
> printk) ?

It's called, but no joystick device (char major 13) is ever registered in 
the kernel. But I even verified that gameport_register_port is called.

What's the module stack supposed to be for this to work?

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
