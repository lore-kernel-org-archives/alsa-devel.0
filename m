From: Laurent Georget <lgeorget2@club-internet.fr>
Subject: help for a levelmeter
Date: Tue, 15 Oct 2002 23:15:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DAC8580.7010004@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

  Hello,

I 'd like to make a levelmeter program which would display sound card
input/output
while the audio device is opened by another program. I tried to use copy
plugin  , but now (since 0.9.0rc3 ) the "snd_pcm_copy_open" give a "implicit
declaration of function"
message . (Anyway, i don't know if using this plugin was correct for
that purpose)

So, would you know a way to read audio data going to (or coming from)
the device , when it is opened by another program ?

Thanks for any help!

Laurent



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?http://www.viaverio.com/
consolidator/osdn.cfm
