From: Edouard Gomez <ed.gomez@free.fr>
Subject: Re: Cannot mmap /dev/dsp error in alsa 0.9.7 and 0.9.8
Date: Sun, 16 Nov 2003 12:39:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031116113954.GA882@edgomez.dyndns.org>
References: <20031115013137.GF832@leeloo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20031115013137.GF832@leeloo>
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

Edouard Gomez (ed.gomez@free.fr) wrote:
> Symptoms:
> - OSS device mapping fails with a EACCES errno. See attachment for
>   triggering the bug.
> - mplayer AV sync is too fast by ~20% (men sound like ladies ;-) when
>   using the alsa9 output, but syncs well when using the compat oss layer

Another symptom:
- I cannot play various audio streams simultaneously anymore since 0.9.7

I forgot to mention the ac97 codec used:
0-0/0: Realtek ALC650 rev 2

It's the audio chip on an asus A7V8X mobo.

I diffed 0.9.7 against  0.9.6 and i can see a fair  amount of changes to
both the via module and the  alc650 ac97 codec. The DXS changes seem not
to cause my problems (tried every dxs_support options).

Where can  i start looking at ?  All advises are welcome  (a patch would
be even better ;-)

-- 
Edouard Gomez


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
