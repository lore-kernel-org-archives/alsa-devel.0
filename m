From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Re: Pc Speaker
Date: Thu, 22 May 2008 21:31:55 +0930
Message-ID: <483560B3.70204@internode.on.net>
References: <20080513110322.030a5386.zoup@zoup.org>	<48296CFF.5000207@keyaccess.nl>	<20080513151425.448369e8.zoup@zoup.org>
	<4829781E.6040909@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <4829781E.6040909@keyaccess.nl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote, on 2008-05-13 20:44:
> On 13-05-08 12:44, Armin ranjbar wrote:
> 
>>> Device Drivers ->
>>>   Input device support ->
>>>     Miscelaneous devices
>>>
>>> With current mainline, it's:
>>>
>>> General setup ->
>>>   Configure standard kernel features (for small systems)
>>>      Enable PC-Speaker support
>> Thank you very much for your reply , 
>>
>> but i have to say that i have this options activated , still no pc
>> speaker .
> 
> Rechecked. Yes, you need this option, you need the ALSA one disabled (not
> modular, disabled) and then the PC speaker driver option appears in its
> input menu where you want to enable it. Paths as given in last reply.
> 
> Yes, that would seem to be amazingly clumsily done. Perhaps there was a
> reason (adding alsa-devel).
> 
> Rene.

Thanks for the clues. I attempted to compile a recent snapshot of 
alsa-driver from 
ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/alsa-driver-hg20080516.tar.bz2

under Debian unstable, by overwriting the unpacked Debian source tarball.

The catch is that the Debian build information set up by

dpkg-reconfigure alsa-source
(which is stored in /etc/alsa/alsa-source.conf)

is out of sync with the Mercurial snapshot and by compiling "all" ALSA 
drivers, I get the ALSA pcspkr driver installed, which causes some problems.

I'd probably need to hack /etc/alsa/alsa-source.conf based on the 
drivers supported by the Mercurial snapshot *minus* pcspkr to build an 
alsa-driver .deb based on the Mercurial snapshot.

Arthur.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
