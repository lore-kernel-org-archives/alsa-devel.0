From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: problems with intel8x0 and 1.0.0pre3
Date: Mon, 1 Dec 2003 19:44:53 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0312011939020.5723-100000@ecabase.localdomain>
References: <Pine.LNX.4.44.0311271804180.15840-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0311271804180.15840-100000@ecabase.localdomain>
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

Hello,

On Thu, 27 Nov 2003, Kai Vehmanen wrote:
> With 1.0.0pre3, for example "arecord -r 8000 - |aplay -r 8000 -" produces 
> constant xruns. A similar app that relies on poll()/select(), fails even 
> more severely. When looking at... 

this problem was fixed in 1.0.0rc1! It seems that the final commit to 
ac97_pcm.c (rev1.7) took care of the problem (the added 'rpcm->stream == 
rpcms[k].stream' check).

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
