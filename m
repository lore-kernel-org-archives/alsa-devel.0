From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: PCM API enhancement - more bitmasks to support more formats
Date: Thu, 27 Jun 2002 00:08:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020626220831.GA19429@idefix.fvdpol.home.nl>
References: <Pine.LNX.4.33.0206260405590.28197-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail2.home.nl (mail2.home.nl [213.51.129.226])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA22070
	for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2002 00:08:51 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0206260405590.28197-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi Jaroslav,

you might be interested in next site:
http://www.tsp.ece.mcgill.ca/Docs/AudioFormats/WAVE/WAVE.html

it contains Microsoft's Riff Wave specs. Noticable the 'Multi-channel / high bit resolution formats ,
2001-06-18' might be interesting for you. It contains also some sample data in various formats

Enjoy,
Frank.


On Wed, Jun 26, 2002 at 04:09:11AM +0200, Jaroslav Kysela wrote:
> Hi,
> 
> 	I've modified and clean up Takashi's patch to add support for more 
> formats. It keeps binary compatibility (important for the kernel inclusion)
> and adds some space for future expansion now. The code is in CVS.
> 	Does somebody have an URL to 24-bit WAV files? I'd like to add
> support for this format to aplay/arecord. Thanks.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project  http://www.alsa-project.org
> SuSE Linux    http://www.suse.com
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: Jabber Inc.
> Don't miss the IM event of the season | Special offer for OSDN members! 
> JabConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?


-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabberConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
