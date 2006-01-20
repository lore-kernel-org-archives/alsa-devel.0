From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Building ALSA utils for a minimal cross compiled
	environment
Date: Fri, 20 Jan 2006 20:18:35 +0000
Message-ID: <1137788315.11084.1.camel@localhost.localdomain>
References: <1137711700.9365.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 7D2E1174
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 21:18:42 +0100 (MET)
In-Reply-To: <1137711700.9365.13.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: linuxsh-dev@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-01-19 at 23:01 +0000, Adrian McMenamin wrote:
> Any advice on this? I have compiled a patched alsa-lib (for SH4 on the
> Dreamcast) but the readme with the alsa utils suggests it might be
> pretty difficult to build it in my situation (I am writing an ALSA
> driver for the Dreamcast).
> 
> Thanks
> 
> Adrian
> 

For the record this seems to work...

./configure --host=sh4-linux
CC=/home/adrian/buildroot/build_sh4/staging_dir/bin/sh4-linux-gcc
--with-alsa-prefix=/home/adrian/alsa-lib-1.0.10/src/.libs/
--with-alsa-inc-prefix=/home/adrian/alsa-lib-1.0.10/include
--disable-alsamixer

(I need to disable the alsamixer because I don't have a curses library
built for the target as yet)





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
