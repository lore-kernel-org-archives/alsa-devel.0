From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_hw_params_get_*() without snd_pcm_open()
 ?
Date: Mon, 28 Apr 2003 10:12:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304281009570.1603-100000@pnote.perex-int.cz>
References: <1051483618.1262.10.camel@Jay>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1051483618.1262.10.camel@Jay>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 27 Apr 2003, Giuliano Pochini wrote:

> I need to read the properties of a pcm device, but snd_pcm_open() blocks
> or exits with an error if something is using that device. Is there any
> workaround ?

No, the characteristic of a PCM device is dynamic (might be changed during 
runtime) thus it's not useful to obtain this information in another way.
Also, I think that most of applications want to be clever than user, 
simply use device passed by user and try work with it.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
