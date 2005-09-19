From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: Best default values for "External Amplifier" and "Audigy Analog/Digital Output Jack"
Date: Mon, 19 Sep 2005 11:14:55 +0200
Message-ID: <8564sxh10w.fsf@Orfeo.duckcorp.org>
References: <432D290E.4010506@yahoo.co.uk> <432D5312.1000506@superbug.co.uk>
	<432E6D40.7080904@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <432E6D40.7080904@yahoo.co.uk> (Thomas Hood's message of "Mon, 19
	Sep 2005 09:48:16 +0200")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Hood <jdthood@yahoo.co.uk>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Hood <jdthood@yahoo.co.uk> writes:

> James Courtier-Dutton wrote:
>> So, the best way to fix this problem will be to raise an ALSA bug on
>> https://bugtrack.alsa-project.org/alsa-bug/ or on the kernel bug tracker
>> with full details of the motherboard and the sound chips involved, and
>> it will eventually be fixed.
>
> OK
>
> You told me what information is needed for "External Amplifier".  This was:
>
> * The default settings, when not working:
>   + The output of "amixer"
>   + the contents /proc/asound/card0/codec97#0/ac97#0-0
>   + the contents of /proc/asound/card0/codec97#0/ac97#0-0+regs
> * The settings when working correctly:
>   + The output of "amixer"
>   + the contents /proc/asound/card0/codec97#0/ac97#0-0
>   + the contents of /proc/asound/card0/codec97#0/ac97#0-0+regs
> * The output of "lspci -vvn"
>
> What information is needed in order to deal with the
> "Audigy Analog/Digital Output Jack" case?
>
> -- 
AFAIK, the behaviour of the switch is consistent accross all the audigy
cards. If you're using Digital Speakers connected to the digital output
of the card, you have to set it. Otherwise, don't set it. It's setup
dependant. IMHO you can't do anything about that. [ IIRC, even the OSS
driver has this 'problem'. ]


Regards,
Arnaud Patard



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
