From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: weird problems with rh72 - ibm x20-cs4281
Date: Fri, 2 Aug 2002 17:44:08 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208021730470.17739-100000@aino.wakkanet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

It seems that rh72's gcc-2.96-98 does something funny when compiling
alsa-kernel/pci/cs4281.c (today's CVS-tree). Trying to install the module
results in following error messages:

--cut--
Aug  2 16:46:28 xxx kernel: ALSA ../alsa-kernel/pci/cs4281.c:675: AC'97 
read problem (ACSTS_VSTS), reg = 0x1c
Aug  2 16:46:28 xxx kernel: ALSA ../alsa-kernel/pci/cs4281.c:675: AC'97 
read problem (ACSTS_VSTS), reg = 0x0
Aug  2 16:46:28 xxx kernel: ALSA ../alsa-kernel/pci/cs4281.c:675: AC'97 
read problem (ACSTS_VSTS), reg = 0x7c
Aug  2 16:46:28 xxx kernel: ALSA ../alsa-kernel/pci/cs4281.c:675: AC'97 
read problem (ACSTS_VSTS), reg = 0x7e
[ ... ]
--cut--

With the following patch the driver loads (and works) fine:

alsa-kernel/pci/cs4281.c:snd_cs4281_ac97_read():
-        snd_cs4281_peekBA0(chip, ac97->num ? BA0_ACSDA2 : BA0_ACSDA);
+        snd_cs4281_peekBA0(chip, ((volatile ac97_t*)ac97)->num ? BA0_ACSDA2 : BA0_ACSDA);

The strange thing is that ac97->num _is_ zero, but still BA0_ACSDA2 is
selected for some odd reason! :o Oh well, maybe I'm missing something
obvious here (I haven't checked the assembler output), but at least I got
ALSA0.9.x working on this machine (ALSA 0.5.x drivers worked fine).

--
 http://www.eca.cx
 Audio software for Linux!





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
