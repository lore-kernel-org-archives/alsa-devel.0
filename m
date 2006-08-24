From: Sven Geggus <sven@geggus.net>
Subject: Re: Bug: aplay/alsa-lib problem on mips (openwrt,
	uclibc)
Date: Thu, 24 Aug 2006 15:41:22 +0000 (UTC)
Message-ID: <eckhb2$g43$1@ultimate100.geggus.net>
References: <eciaah$qi9$1@ultimate100.geggus.net>
	<1156408442.3263.269301419@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <cladisch@fastmail.net> wrote:

> I would guess that the kernel and alsa-lib have not been compiled with the
> same compiler or compiler options, i.e., some structure layouts are
> different.

I have been using the same compiler, as I don't have more than one cross
development toolkit installed.

compiler options are different, however.

Openwrt is using the following for compiling alsa-driver:
-Os -G 0 -mno-abicalls -fno-pic -finline-limit=100000 -mabi=32 -march=mips32
--Wa,-32 -Wa,-march=mips32 -Wa,-mips32 -Wa,--trap -mlong-calls -Wall
--Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
--fno-strict-aliasing -fno-common -pipe

I added the "-mlong-calls" Option myself, to get the alsa modules to insmod
correctly and to work (at least in oss compatible mode).

For compiling alsa-lib I just use what configure suggests which basically
leads to no special compiler Options at all.

Which options of the above do you suspect that I would need for alsa lib to
be able to talk to the alsa driver in a correct way?

Sven

-- 
"In the land of the brave and the free, we defend our freedom
with the GNU GPL" (Richard M. Stallman on www.gnu.org)

/me is giggls@ircnet, http://sven.gegg.us/ on the Web

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
