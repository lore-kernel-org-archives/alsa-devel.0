From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: 1.0.13 and indigoio
Date: Fri, 6 Oct 2006 12:19:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0610061208150.4839@denise.shiny.it>
References: <70a871c80610050536w2968cd52n32a5960899b4e90b@mail.gmail.com>
	<s5hbqororyw.wl%tiwai@suse.de>
	<70a871c80610050549i67273c2bs4eab40731685bb47@mail.gmail.com>
	<70a871c80610050550l657155d9p5b57c9f534171e82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <70a871c80610050550l657155d9p5b57c9f534171e82@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Dmitry Baikov <dsbaikov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Thu, 5 Oct 2006, Dmitry Baikov wrote:

> [ 1093.590000] ALSA > /mnt/bits/portage/tmp/portage/alsa-driver-1.0.13/work/alsa-driver-1.0.13/pci/echoaudio/../../alsa-kernel/pci/echoaudio/echoaudio_dsp.c:313: Resident loader failed to set HF5

The dsp-loader code failed loading. Unfortunately I have no idea on what 
happens and I can't debug what the DSP does. All I know is it didn't set 
that HF5 bit in a register after it apparently has received all the data.


> Forgot to add, the very first insertion works.

Uhm... I'll have a look at the code again.


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
