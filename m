From: Denis Sbragion <d.sbragion@infotecna.it>
Subject: Re: M-Audio Revolution 7.1 card hangups
Date: Thu, 11 Sep 2003 08:41:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.1.20030911084044.03a04088@pop3.infotecna.lcl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello Takashi,

At 19.59 10/09/2003 +0200, you wrote:
...
> > 2) I use 'alsamixer'.  Works fine.  One problem:  When I set the
> > conversion rate to the SPDIF clock (it has another name IEC...) IT
> > LOCKS AND STAYS THERE.  No amount of diddling in 'alsamixer' yields
> > anything.  To get around this I revert back to an older setting (it is
> > a long process) saved with 'alsactl' after a reboot.  While I have
> > learned my lesson (DON'T DO THAT!), the behavior is not too good.
>
>ok, that's easy.  please apply the patch attached.
...

is this problem somewhat related to the SPDIF problem I found with my 
TerraTec EWX 24/96? I haven't been able to solve it, but, to tell the true, 
I haven't tried really hard. Just digged a little in the source code. 
Actually I'm still running with 0.9.4 plus the cs8427 module from 0.9.3.

Bye,
--
	Denis Sbragion
	InfoTecna
	Tel: +39 0362 805396, Fax: +39 0362 805404
	URL: http://www.infotecna.it



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
