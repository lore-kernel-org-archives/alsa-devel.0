From: Jaroslav Kysela <perex@suse.cz>
Subject: maximum PCM DMA buffer sizes for PCI hw
Date: Fri, 6 Oct 2006 10:16:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610061002220.8573@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E3F2D197
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 10:16:21 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	BB0D599564 for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 10:16:21 +0200 (MEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	64E71E9481 for <alsa-devel@alsa-project.org>;
	Fri,  6 Oct 2006 10:16:21 +0200 (CEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	while working on ALSA bug#2481 I figured that we do not allow to 
setup large DMA buffers for hardware which is capable using that. I do not 
think that it's right behaviour. Actually, I set the maximum buffer size 
to 1024MB for hda_intel driver and here is list of PCI drivers and current 
allowed DMA sizes. If you know (and test) that some hardware can have 
larger DMA buffer (512MB - 1024MB), please, let me know. I will increase 
the limits. Also, I might be wrong, so post any corrections here, too. 
Thanks. At least, ymfpci and ice1724 drivers are first candidates for 
1024MB limit for me.

ad1889	- 256KB	- might be increased
als300	- 64KB	- hw limit
als4000	- 64KB	- hw limit
atiixp	- 256KB	- might be increased
atiixp_modem - 256KB - OK
azt3328 - 64KB	- hw limit
bt87x   - ~1000MB - hw limit, OK
cmipci  - 128KB - hw limit (?)
cs4281	- 512KB - probably OK
ens1370	- 128KB	- might be increased (?)
ens1371	- 128KB - might be increased (?)
es1938  - 32KB	- hw limit
fm801	- 128KB - might be increased (?)
intel8x0 - 128KB&64KB - might be increased (?)
intel8x0m - 64KB - might be increased, but probably OK
maestro3 - 512KB - probably OK
rme32	- 128KB	 - hw limit
rme96	- 64KB	 - hw limit
ali5451	- 256KB	 - probably OK
au88x0  - 64KB	 - might be increased (?)
ca0106  - ~512KB - probably OK
cs46xx  - 256KB	 - probably OK
cs5535audio - 128KB - might be increased (?)
echoaudio - 256KB - might be increased (?)
emu10k1 - 128KB&64KB - might be increased (?)
emu10k1x - 32KB   - hw limit
hda_intel - was 128KB, 1024KB now - OK
ice1712 - 256KB   - hw limit
ice1724 - 256KB	  - SHOULD be increased
korg1212 - ? (lazy to count) - hw limit
mixart  - 32KB	- hw limit (?)
nm256	- 256KB	  - might be increased (?)
pcxhr	- 32KB	- hw limit (?)
riptide - 64KB	- hw limit (?)
hdsp	- ?	- hw limit
hdspm	- ?	- hw limit
rme9652	- ?	- hw limit
trident	- 256KB&128KB - hw limit (?)
ymfpci	- 256KB	- SHOULD be increased
vx	- 128KB	- might be increased (?)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
