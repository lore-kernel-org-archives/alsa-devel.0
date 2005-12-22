From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Setting up Alsa by hand on an embedded system
Date: Thu, 22 Dec 2005 10:05:16 +0100
Message-ID: <1135242316.43aa6c4cac014@webmail.uni-halle.de>
References: <b15982770512211736m71edba7eyc4885b0c3cd6bd93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <b15982770512211736m71edba7eyc4885b0c3cd6bd93@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Smoot <davidsmoot@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Smoot wrote:
> I need to add the ability to record and playback audio on the embedded linux
> platform my company uses.  Being embedded, I do not have a full Linux
> distribution.  I have to set up ALSA by hand.  I can't simply untar the alsa
> package and do ./configure followed by make.

Have a look into alsa-lib's Makefile.am files to see what gets installed.

> ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default

I guess the configuration files in /use/share/alsa/ are missing.


HTH
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
