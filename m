From: Patrizio Bassi <patrizio.bassi@gmail.com>
Subject: Re: [BUG] alsa volume and settings not restored after suspend
Date: Sun, 25 Sep 2005 10:18:05 +0200
Message-ID: <43365D3D.6050608@gmail.com>
References: <4335909D.2070904@gmail.com> <1127593697.18892.1.camel@mindpipe>
Reply-To: patrizio.bassi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1127593697.18892.1.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Kernel," <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell ha scritto:

>On Sat, 2005-09-24 at 19:45 +0200, Patrizio Bassi wrote:
>  
>
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>As topic.
>>
>>Suspend works perfectly, but after resume, no sound from audio card.
>>    
>>
>
>I'm not surprised, suspend/resume is not implemented for that device.
>
>It looks like it would not be too hard, see es1938.c for an example.
>
>Lee
>
>
>  
>
ok, suspend/resume functions are very very simple.

the problem is i have really 0 experience in alsa devel, for example i 
don't know
the 0xa0 limit (in es1938...).

so...i'm asking for alsa devel to implement that, i'll be happy to help 
you in testing and debugging.

Thanks

Patrizio



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
