From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: cs4248 / thinkpad 755 / 755c , patch suggestions [PATCH]]
Date: Wed, 9 Jul 2003 16:04:51 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030709210451.GH1031@dbz.icequake.net>
References: <20030709160532.GE1031@dbz.icequake.net> <Pine.LNX.4.44.0307091824050.16335-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307091824050.16335-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Hi Jaroslav,

On Wed, Jul 09, 2003 at 06:28:05PM +0200, Jaroslav Kysela wrote:
 
> Show me a wav header parser code in these drivers. I guess that you are 
> a bit confused. The standard parameters are 8000Hz, mono, 8-bit unsigned 
> (/dev/dsp) or 8000Hz, mono, 16-bit unsigned (/dev/dsp16) or 8000Hz, 
> mono, muLaw (/dev/audio) as far as I work with sound drivers since 1994.

You are correct that I was either confused, or always used 8kHz sound
files all the time.  I unloaded ALSA and loaded up the old OSS driver to
prove you wrong, and only found out that I was wrong instead. :)

Sorry for the confusion,

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
