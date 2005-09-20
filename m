From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Best default values for "External Amplifier" and
	"Audigy Analog/Digital Output Jack"
Date: Tue, 20 Sep 2005 09:24:14 -0400
Message-ID: <1127222656.20689.16.camel@mindpipe>
References: <432D290E.4010506@yahoo.co.uk> <432D5312.1000506@superbug.co.uk>
	 <432E6D40.7080904@yahoo.co.uk> <8564sxh10w.fsf@Orfeo.duckcorp.org>
	 <m264sxutnl.fsf@vador.mandriva.com>  <85hdchfcih.fsf@Orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <85hdchfcih.fsf@Orfeo.duckcorp.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Thierry Vignaud <tvignaud@mandriva.com>, Thomas Hood <jdthood@yahoo.co.uk>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-09-19 at 14:49 +0200, Arnaud Patard wrote:
> At least, on the audigy player/gamer, the connector used for the digital out is
> also used for analog out (see
> http://fr.europe.creative.com/support/downloads/download2.asp?manualID=807&Product_ID=237&regionID=3&Product_Name=Audigy+Gamer)
> . Thus detecting if there's a cable connected or not to set the 'Audigy
> Analog/Digital Output Jack' switch won't work.

The Windows driver probably has a timer check the SPDIF valid bits for
that channel every second and switches this setting accordingly.

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
