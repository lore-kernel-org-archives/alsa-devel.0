From: Frans Ketelaars <ketelaars@wanadoo.nl>
Subject: Re: SB Live! 24-bit
Date: Fri, 10 Dec 2004 21:32:44 +0100
Message-ID: <200412102132.44782.ketelaars@wanadoo.nl>
References: <ea647236041210115033a6dcdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <ea647236041210115033a6dcdf@mail.gmail.com>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 10 December 2004 20:50, Tony Senerchia wrote:
> Hi,
>
> I heard something about using this card (SB Live! 24-bit) with the
> audigyls driver cause it uses a P17.
>
> I also read somewhere else that there was a .diff file to pacth the
> alsa-kernel, but I only found a .diff for audigy-value.
>
> I wanted to know if this card is supported now, and if so what it
> takes to get it working and when I can expect a driver to be included
> in alsa.
>
> I compiled alsa-1.0.7 (from 11/11/2004), and though it now gives me
> the option to use the card, the card is still an "unknown device:
> 0007" to the computer and I always get an error that no device was
> found (thus no dsp). I'm using a 2.6.7 kernel in slackware
> ("current").
>
> Thanks for all your help!!!
>
> Tony Senerchia

Found this:

<quote>-------------------------------------------------------
Re: [Alsa-user] SoundBlaster Live! 24-bit SB4010
From: 
James Courtier-Dutton <James@superbug.co.uk>
To: 
John Bailo <jabailo@earthlink.net>
CC: 
Alsa-user@lists.sourceforge.net

Date: 
12/04/04 20:20

John Bailo wrote:
> It looks like there are new sound blaster drivers ready for Creative 
Labs -- 
> none of the entries in the list are red any more.
> 
> 
http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Creative_Labs#matrix
> 
> Questions:
> 
> (1) My card is a Sound Blaster Live! 24-bit (SB4010) which is not 
represented 
> in the list.   I think someone mentioned that it does not use the 
emu10k1 but 
> the audiglys driver.   Is that the right driver for the SB4010 ?
> 

See http://alsa.opensrc.org/index.php?page=audigyls for details.

Summary: alsa does not currently support the SB0410, but alsa drivers 
are available if you are willing to compile your own kernel and 
alsa-drivers.
</quote>-----------------------------------------------------------

HTH,

    -Frans



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
