From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: alsa-conf will not compile.
Date: Tue, 25 Jun 2002 12:16:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D185123.7060808@superbug.demon.co.uk>
References: <3D17B909.20006@superbug.demon.co.uk> <3D180822.2080008@renta.net>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050503020608060705060807"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Mark Constable <markc@renta.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050503020608060705060807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mark Constable wrote:

> James Courtier-Dutton wrote:
>
>> Has anyone managed to get "alsa-conf" to compile ?
>
>
> Yes, just now after seeing your message. I was missing
> /usr/inlcude/slang.h but once I installed the package
> with that header it went thru Ok.
>
>> I use the current CVS, but it will not compile.
>
>
> You neglected to paste some info about why you compile
> did not work. We need to see the errors.
>
> > Is "alsa-conf" of any use any more ?
>
> I would imagine it would not be in CVS if it was no
> longer of any use.
>
> --markc
>
Ok, I attach the console output while running cvscompile.
It looks like bad syntax to me, because it does not like the friend 
statement.

I am using GCC 3.04 and G++ 3.04

Cheers
James


--------------050503020608060705060807
Content-Type: application/gzip;
 name="fail.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fail.txt.gz"

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
OF37jbL+IPlG2f8AA0M6U30mAAA=
--------------050503020608060705060807--




-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
