From: Manuel Jander <mjander@embedded.cl>
Subject: Scatter Gather and odd period sizes.
Date: Sun, 16 Mar 2003 03:10:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E742357.5050107@embedded.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hello,

I'm writing Scatter Gather support for the Aureal Vortex,
and the problem is that i get period sizes that dont match
the page size. That is not so bad, but the page count doesnt
match the period count either.

How are the pages mapped on the buffer ?? I dont see any chance
that could work. Why arent the page count at least equal to the
period count ?

I tried several combinations to map the SG pages, but i cant find any
that works OK.

Best Regards

Manuel Jander.





-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
