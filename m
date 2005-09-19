From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: Best default values for "External Amplifier" and "Audigy Analog/Digital Output Jack"
Date: Mon, 19 Sep 2005 14:49:42 +0200
Message-ID: <85hdchfcih.fsf@Orfeo.duckcorp.org>
References: <432D290E.4010506@yahoo.co.uk> <432D5312.1000506@superbug.co.uk>
	<432E6D40.7080904@yahoo.co.uk> <8564sxh10w.fsf@Orfeo.duckcorp.org>
	<m264sxutnl.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m264sxutnl.fsf@vador.mandriva.com> (Thierry Vignaud's message of
	"Mon, 19 Sep 2005 14:30:22 +0200")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: Thomas Hood <jdthood@yahoo.co.uk>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thierry Vignaud <tvignaud@mandriva.com> writes:

> Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:
>
>> AFAIK, the behaviour of the switch is consistent accross all the
>> audigy cards. If you're using Digital Speakers connected to the
>> digital output of the card, you have to set it. Otherwise, don't set
>> it. It's setup dependant. IMHO you can't do anything about that. [
>> IIRC, even the OSS driver has this 'problem'. ]
>
> some drivers have a sense mixer element.
>
> cannot more drivers be patched in order to have such a behavior (if
> possible)?

At least, on the audigy player/gamer, the connector used for the digital out is
also used for analog out (see
http://fr.europe.creative.com/support/downloads/download2.asp?manualID=807&Product_ID=237&regionID=3&Product_Name=Audigy+Gamer)
. Thus detecting if there's a cable connected or not to set the 'Audigy
Analog/Digital Output Jack' switch won't work.


Regards,
Arnaud



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
