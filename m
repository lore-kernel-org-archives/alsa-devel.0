From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: ham radio OSS duplex realtime mmap program.
Date: Fri, 26 Sep 2003 14:52:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F744495.1000304@superbug.demon.co.uk>
References: <200309261147.h8QBlUCK011127@oud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309261147.h8QBlUCK011127@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: =?ISO-8859-1?Q?=22Dr=2E_med=2E_G=FCnther_Montag=22?= <Safari.Doktor@addcom.de>, alsa-devel@lists.sourceforge.net, hfterm-hackers@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>Hello
>>I work at "hfkernel" by Tom Sailer, a program for pactor/rtty (soundcard =
>>ham=20
>>radio digimodes). It seems complicated, because it uses realtime scheduli=
>>ng,=20
>>select(), mmap(), and runs in 3 threads.=20
>>It was made in 1996 for OSS; I am trying to get it running with ALSA.=20
> 
> 
> JACK already does this kind of stuff. You'd save yourself major
> headaches by starting off doing it as a JACK client. Alternatively,
> use the JACK source as a guide, although its very complex because it
> is intended to handle many channels in a very robust way, with
> complete xrun detection.
> 
> http://jackit.sf.net/
> 
> another alternative source of ideas would be ecasound's own ALSA code.
> 
> --p
> 
I agree with Paul, that JACK would be a good place to work from, because 
it already deals with all the complicated realtime full duplex details, 
and leaves a relatively simple interface for the user application.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
