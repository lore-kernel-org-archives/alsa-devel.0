From: torben hohn <torbenh@gmx.de>
Subject: Re: Re: [Alsa-user] Re: Broken emu10k/SB Live driver?
Date: 11 Oct 2002 11:53:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17zuaD-0001KG-00@usw-sf-list1.sourceforge.net>
References: <Pine.LNX.4.33.0210102112340.701-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0210102112340.701-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Martin Soto <soto@informatik.uni-kl.de>, alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> 
> > Does emu10k1 work at a user settable sample rate? 44100 Hz? 32000Hz?
> > 
> > MS Windows driver has a good sounding reverb. Could this reverb dsp
> > code be extracted from the MS Windows driver and used "as is" in Alsa?
> 
> It's not so easy and I'm sure that we'll violate some patent doing things 
> in this way.

There is a reverb in the oss driver from http://opensource.creative.com
it comes as source (i gues it is the same as the windows reverb)

so if we provide a method for the user to load patches into the dsp we
are fine.
i will query Martin Soto on his status.

(hi martin can you send me your patchloader code ?)




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
