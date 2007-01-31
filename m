From: Gregor Jasny <jasny@vidsoft.de>
Subject: Re: Need help with patch for #2724 (usbaudio, core)
Date: Wed, 31 Jan 2007 14:14:35 +0100
Message-ID: <45C0963B.302@vidsoft.de>
References: <20070127132445.GA11859@vidsoft.de>	<s5hbqkgv4eu.wl%tiwai@suse.de>	<45C07BEB.1050209@vidsoft.de>
	<s5htzy7toou.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5htzy7toou.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> OK, then how about the one below?

Still oopsing.

ALSA sound/core/pcm_native.c:2067: SUCCESS -> Leaves 
snd_pcm_hw_constraints_complete with no error.

After that I get the following debug output:

hw_rule_rate: (0,16000)
   --> (0, 16000) (changed = 0)
hw_rule_channels: (1,1)
   --> (1, 1) (changed = 0)
hw_rule_format: 4:0
   --> 4:0 (changed = 0)

general protection fault: 0000 [#8]
[OOPS]

Please attach patches for me as seperate file. Need to hand-apply it 
otherwise.

Thanks,
Gregor

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
