From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: format problem
Date: Mon, 18 Mar 2002 09:19:50 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203180919150.498-100000@pnote.perex-int.cz>
References: <02031510095602.00888@mdube.usine.8D.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <02031510095602.00888@mdube.usine.8D.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Mathieu Dube <mdube@8d.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 15 Mar 2002, Mathieu Dube wrote:

> Hi,
>          Im using the alsa API and I call snd_pcm_plugin_params with the 
> pp.format.format at SND_PCM_SFMT_U16_LE.
>          But when I call snd_pcm_plugin_setup and snd_pcm_get_format_name on 
> setup.format.format it outputs:
> --> Signed 16-bit Little Endian
> 
>          Why is that??
> 
> btw, I check for return values and all seems well.

Please, use latest 0.9 API. 0.5 API is outdated.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
