From: "J. Scott Amort" <jsamort@telus.net>
Subject: 0.9.2 Unresolved symbol errors with RH
Date: 03 Apr 2003 16:00:55 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049414455.4785.14.camel@work.baobobmusic.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Just to update, as has been posted on the user list - 0.9.0rc7 and later
does not work on RH 8.1 beta or the now released 9 (I can confirm this,
and also can confirm that 0.9.0rc6 DOES work on both).  It has been
suggested that the conflict is with Redhat's kernel patches, as 0.9.2
works with the official kernel 2.4.20, and/or that it is perhaps related
to the new RedHat NPTL implementation and changes made to the alsa
driver since 0.9.0rc6 (which works with this new POSIX implementation). 
Can any developer confirm this, or perhaps narrow down where I should
start working?  I'm not a stellar programmer, but since it doesn't
appear that anyone else is taking this problem on (if anyone is, PLEASE
let me/us know!), I figure I'd take a try, otherwise I'll be stuck with
0.9.0rc6 forever!

Regards,

Scott 



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
