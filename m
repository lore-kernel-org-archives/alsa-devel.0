From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: dmix vs alsaplayer [was jackd, zynaddsubfx and
 iiwusynth]
Date: Mon, 3 Mar 2003 20:35:25 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303032034170.10282-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0303032050270.15451-100000@vaino.wakkanet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303032050270.15451-100000@vaino.wakkanet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, "linux-audio-user@music.columbia.edu" <linux-audio-user@music.columbia.edu>, "alsaplayer-devel@lists.tartarus.org" <alsaplayer-devel@lists.tartarus.org>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 3 Mar 2003, Kai Vehmanen wrote:

> Try matching the alsaplayer period_size to the one used by dmix with 
> the "-f 22052" alsaplayer option. 

alsaplayer doesn't accept resolution other than multiple of 32 bytes

> 
> PS Opening dmix in non-interleaved mode produces totally garbled output:
>    "ecasound -i foo.wav -f:16,2,44100,n -o alsa,dmix -b:4096"

Works here - using standard stereo device.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
