From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Possible solution for the alsa-oss fopen problem.
Date: Thu, 10 Jun 2004 13:49:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C858C3.1030401@superbug.demon.co.uk>
References: <40C6F035.4000406@superbug.demon.co.uk> <20040610140943.2d11d904@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040610140943.2d11d904@mango.fruits.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Florian Schmidt wrote:
> On Wed, 09 Jun 2004 12:10:45 +0100
> James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
> 
> 
>>I have found out that the artsdsp /dev/oss redirector supports fopen and 
>>friends.
>>I looked at the artsdsp, (find it inside arts-1.2.2.tar.bz2)
>>It uses a function called fopencookie()
>>
>>Extract from /arts-1.2.2/artsc/stdioemu.c below.
>>
>>Would this be useable in the alsa-oss redirector?
> 
> 
> This fopencookie seems to be a libc thing to implement custom streams.. See
> 
> http://wwwwbs.cs.tu-berlin.de/user-taipan/kraxel/gnuinfo/libc/Streams_and_Cookies.html
> 
> Might be exctly the thing which is needed to intercept fopen() and friends AND handle the intercepted calls gracefully..
> 
> I have a question though: If this works for alsa-oss, then the libc problem with the internal symbols of open() and friends is solved. But i wonder if there are any other libs which are as "evil" in this regard as libc is. The basic problem persists: If a lib uses internal symbols for open() and friends and an app uses that lib to access /dev/dsp, etc., then we're screwed again..
> 
> On the other hand: How many libs besides libc do stuff like this? And how many apps use such a lib? I would guess: very very few.. If this is the case, i suppose it will work well (tm)
> 
> Florian Schmidt
> 

Does anyone have a small test app that uses fopen and friends, so that I 
could test them if I add fopencookie() to aoss.

Hopefully, the test app should use the fopen and friends calls in the 
same way that know "problem" apps use.

If there is not a test app out there, can someone please tell me more 
details about the problem, so that I could build a test app myself.

I need to know which fcalls lead to a failure, so that if I get those 
fcalls working, these "problem" apps will be guaranteed to work.

Cheers
James



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
