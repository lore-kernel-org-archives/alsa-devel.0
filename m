From: ljp <ljp@llornkcor.com>
Subject: dev advise needed
Date: 13 Feb 2003 10:03:44 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045155826.25120.103.camel@shippin>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

I am working on adding native alsa support to the Helix project, and am
running into issues I think are with threading between the two.

Mainly, variable values are returning as 0 when they shouldn't be.
such as 

function(int &bleh) {
bleh = 1;
}

when function() returns, bleh == 0 in the calling function, I have used
valgrind to show me that it is trying to access unaccessable variables.

Now, both helix and alsa are threaded. and helix works fine with the oss
implementation.
Helix locks and unlocks when needed.

I havent done a all that much of threaded programming, any suggestions
on what I should look into? or hints at solving this?

thx,
ljp


-- 
My cat's a debugger....

Potter, Lorn, "ljp"
core developer / Web Administrator
Project OPIE- the Open Palmtop Integrated Environment
http://opie.handhelds.org | http://www.opie.info (german) |
http://www.opie.us
IRC: irc.freenode.net #opie #opie.de

llornkcor@handhelds.org
llornkcor@helixcommunity.org



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
