From: Brix <brix82@libero.it>
Subject: Re: SBLive midi synth + ALSA doesn't work.
Date: Wed, 3 Sep 2003 13:06:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030903130652.7d7a5cf1.brix82@libero.it>
References: <20030831180443.10bba610.brix82@libero.it>
	<s5hu17wodov.wl@alsa2.suse.de>
	<20030902230613.00cf4cd2.brix82@libero.it>
	<s5h3cfemd9p.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3cfemd9p.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 03 Sep 2003 11:28:50 +0200
Takashi Iwai <tiwai@suse.de> wrote:


> if you can see the emu10k1 clients in /proc/asound/seq/clients, it's a
> problem of pmidi.  (also, for oss seq, you can see the available
> devices in /proc/asound/seq/oss.)
> 
> is pmidi the latest one compiled with ALSA 0.9.x?
> also, if you have still old alsa-lib, update it.
> 
> Takashi

I recompiled pmidi, and now everything is going right! Wonderful!
Now i only need an ALSA-devel guide, but i think it's very hard to fin something...

Thanks,
		Marco

-- 

	Hardware is never old.
	People just choose the wrong OS.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
