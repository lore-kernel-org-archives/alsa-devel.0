From: jmal8295 <jmal8295@artax.karlin.mff.cuni.cz>
Subject: Re: via82xx.c, snd_via8233_dxs_volume_put change
Date: Fri, 14 Oct 2005 18:52:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0510141843080.17656@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.62.0510141244070.17656@artax.karlin.mff.cuni.cz>
 <s5hd5m81cci.wl%tiwai@suse.de> <Pine.LNX.4.62.0510141525580.17656@artax.karlin.mff.cuni.cz>
 <s5h7jcg19j1.wl%tiwai@suse.de> <Pine.LNX.4.62.0510141708330.17656@artax.karlin.mff.cuni.cz>
 <s5hu0fkyrv1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0fkyrv1.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 14 Oct 2005, Takashi Iwai wrote:
> jmal8295 wrote:
>>
>> OK, posting second version of patch.
>
> Thanks.  Could you give me the change log and signed-off-by line to
> commit, too?
>
Don't know, I haven't much experience with it yet ... I try:

Oct. 14, 2005	Honza Maly <hkmaly@matfyz.cz>
 	- enable separate DXS controls in case DXS volume is not needed
 	  for PCM Playback volume control emulation
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDT+JMtYQjN8jZGdQRAlbjAKCRRNNFcPTEZUSI48St1/4NRfzv2gCdE51X
gmHBJGvbGAVizBt3da4UTzE=
=1b1/
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
