From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1: rear mono played on all exept rear
Date: Wed, 16 Feb 2005 16:23:45 -0500
Message-ID: <1108589025.29298.26.camel@krustophenia.net>
References: <42132C58.3050006@glocalnet.net>
	 <1108584134.29298.19.camel@krustophenia.net>
	 <Pine.LNX.4.58.0502162154430.12988@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.58.0502162154430.12988@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Mikael Magnusson <mikaelmagnusson@glocalnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-02-16 at 21:55 +0100, Jaroslav Kysela wrote:
> On Wed, 16 Feb 2005, Lee Revell wrote:
> 
> > The current config relies on the 3rd and 4th FX sends being set to FX 2
> > and 3.  It seems better to state this explicitly.
> 
> The driver does this...
> 

Right, I see.  It seems a bit odd that front/rear and center/lfe are
handled differently.  The kX driver uses sends 1 and 2 for
front/rear/center+lfe and sets sends 3 and 4 the same for all channels.
There are probably advantages to both approaches.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
