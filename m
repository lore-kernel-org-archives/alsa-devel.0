From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Broken pipe mystery
Date: Mon, 10 Feb 2003 08:47:42 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0302100841060.27762-100000@mailserver.intern.bfad.de>
References: <06b501c2cf79$d6683060$0100a8c0@Pblaptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <06b501c2cf79$d6683060$0100a8c0@Pblaptop>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pete Barnard <petebarnard@tiscali.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > What sampling frequency do you use (kHz) ?
> 
> 16kHz is the sampling frequency.

Please note what period and boundary size are you using. 16000*60*60*24 =
1382400000, this should be still OK, unless you are counting bytes, not frames.
I suspect some problems when 32 bit counter wraps around (changes from positive
to negative), but this should probably take longer in your case.

Anyway if it always takes the same time you should be able to calculate what
your magic number is. If not, then something else.

Best regards,
--
Tomek



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
