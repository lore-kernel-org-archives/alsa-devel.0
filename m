From: Shawn Smout <olorin_the_great@yahoo.com>
Subject: Update/fix: Alsa-driver gawk/POSIX bug
Date: Sun, 28 Sep 2003 13:38:50 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030928203850.9086.qmail@web40903.mail.yahoo.com>
References: <20030928195534.95497.qmail@web40911.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030928195534.95497.qmail@web40911.mail.yahoo.com>
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

Apologies for not including this at first.  The proper
fix is not to delete the { }, although this originally
worked in my case.  The { } should actually be escaped
as follows:

if (match($0, "\{.*\}"))

This works regardless of whether gawk is operating in
POSIX mode.

The reason for this is that gawk by default decides
based on context whether { } are metacharacters.  In
this context it determined that they were not, and so
the { } matched literal braces.  In POSIX mode, since
{ } are metacharacters sometimes, they are always
metacharacters; thus to match literal braces they must
be escaped.

--- Shawn Smout <olorin_the_great@yahoo.com> wrote:
> I have discovered a bug in
> alsa-driver-0.9.7/utils/convert_isapnp_ids line 84. 
> Ordinarilly in GNU gawk, the line
> 
> if (match($0, "{.*}"))
> 
> works fine.  However, if the environment
> POSIXLY_CORRECT is set (it is on my system, since I
> like things to be standards-compliant, although it
> probably is not on most Linux systems), gawk has an
> error on this line and compiling the drivers fails. 
> It gives this error message when making
> alsa-drivers:
> 
> awk:
>
/usr/src/alsa-driver-0.9.7/utils/convert_isapnp_ids:89:
> (FILENAME=- FNR=27056) fatal: Invalid preceding
> regular expression: /{.*}/
> 
> I don't know much about awk; I have used some
> regexes
> though, and since I hadn't yet figured out why I was
> getting this error message, I tried simply removing
> the {}.  The driver compiled correctly and works
> correctly.
> 
> This problem is not, as far as I can tell, listed in
> gawk's documentation as something that changes when
> gawk runs in POSIX compatibilty mode.  However, I
> tried compiling the unmodified source without
> POSIXLY_CORRECT set, which worked.  I then
> immediately
> did 'make clean ; setenv POSIXLY_CORRECT ; make'
> (csh)
> and the problem occurred again, so I am quite
> certain
> the bug is entirely because of POSIXLY_CORRECT being
> set.
> 
> On a side note, since gawk doesn't even document
> this
> discrepancy between POSIX and normal modes (though
> it
> does have a long list of differences from POSIX,
> which
> doesn't include this one), I also intend to file a
> gawk bug, so that we can actually know when gawk is
> going to break instead of spending a half hour
> trying
> to get drivers to compile when the problem is just a
> single environment variable.
> 
> __________________________________
> Do you Yahoo!?
> The New Yahoo! Shopping - with improved product
> search
> http://shopping.yahoo.com
> 
> 
>
-------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel


__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
