From: John Anderson <panic-alsa@semiosix.com>
Subject: Re: Problems with USB driver and Swissonic USB Studio
Date: 19 Jul 2002 14:08:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1027080536.1767.32.camel@groovious>
References: <1027074021.1203.15.camel@groovious>
	<s5hofd4qad8.wl@alsa2.suse.de> <1027076078.1745.20.camel@groovious>
	<s5hit3cq7zi.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hit3cq7zi.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2002-07-19 at 13:20, Takashi Iwai wrote:
> hmm, do you see any kernel messages from alsa drivers?
> (you might need to compile it via --with-debug=full option.)
> if there is a message regarding unknown ioctl, then the alsa-library
> doesn't match with the alsa driver.  something wrong happened during
> alsa-lib installation, such as wrong path, etc.

I did the configure dance for the drivers, with the debug switch.
Recompiled, installed, and did rmmod -r. The '-r' was the obvious bit I
forgot last time. Duh.

It works now. Thanks for your help.

bye
John
 
-- 

Freelance DataDreamer http://www.semiosix.com
Good Things require a precise lack of control



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
