From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Possible solution for the alsa-oss fopen problem.
Date: Wed, 09 Jun 2004 12:56:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C6FAD4.7090509@superbug.demon.co.uk>
References: <40C6F035.4000406@superbug.demon.co.uk> <Pine.LNX.4.58.0406091332500.1767@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-37.mail.demon.net (anchor-post-36.mail.demon.net [194.217.242.86])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 949B01E0
	for <alsa-devel@alsa-project.org>; Wed,  9 Jun 2004 13:55:55 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.58.0406091332500.1767@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 9 Jun 2004, James Courtier-Dutton wrote:
> 
> 
>>I have found out that the artsdsp /dev/oss redirector supports fopen and
>>friends. I looked at the artsdsp, (find it inside arts-1.2.2.tar.bz2) It
>>uses a function called fopencookie()
> 
> 
> Does it work for sox and teamspeak?
> 
> 						Jaroslav
> 

I don't use KDE, so I can't really test it.
I just heard someone say on irc "It works on artsdsp, but not aoss"
I can't remember which app "It" was.

Has anyone created a test app that uses fopen and friends so that 
testing these features would be easier?

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
