From: Eliot Blennerhassett <linux@blennerhassett.gen.nz>
Subject: Hg repo usage notes.
Date: Fri, 12 May 2006 13:07:40 +1200
Message-ID: <200605121307.41000.linux@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mta01.xtra.co.nz (mta01.xtra.co.nz [210.54.141.254])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E2723162
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2006 03:11:12 +0200 (MEST)
Received: from [192.168.1.1] (really [222.154.85.13]) by fep02.xtra.co.nz
          with ESMTP
          id <20060512010744.OZTX15142.fep02.xtra.co.nz@[192.168.1.1]>
          for <alsa-devel@alsa-project.org>;
          Fri, 12 May 2006 13:07:44 +1200
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hi all,

I have been trying to get my head around how to use Hg repo e.g. get latest 
code, fix something, make a patch etc.  Perhaps something like the following 
would be useful on the download page?  I'm a total newbie to Hg, so please 
step in and set me right about the correct/desirable/easier ways to do this.

# Get a copy of the repository
cd alsa-hg

hg clone http://hg-mirror.alsa-project.org/alsa-driver alsa-driver
hg clone http://hg-mirror.alsa-project.org/alsa-kernel alsa-kernel

# Get latest
hg pull -u

# Create a working copy
hg clone alsa-driver alsa-driver-fixbug1
cd alsa-driver-fixbug1
./cvscompile
do { code; test;} until finished;
hg commit -m"Fixed the foo in bar"

# What to do about sending the changes back ?
hg outgoing ../alsa-driver
hg outgoing -p ../alsa-driver > foobar.patch
#OR bundle (which is preferred)
hg bundle foobar.hg ../alsa-driver
#OR
hg export (?what?) > foobar.patch

# email foobar.[hg,patch] to alsa-devel?

# Other notes
add to .hg/hgrc to avoid having to spec the path for hg 
[incoming,outgoing,bundle]:

default-push= /path/to/alsa-driver 

cheers
--
Eliot


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
