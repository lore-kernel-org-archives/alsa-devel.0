From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: More mixer questions
Date: Sat, 01 Apr 2006 22:09:29 -0500
Message-ID: <1143947370.6601.17.camel@mindpipe>
References: <1143933507.9228.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 42250188
	for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2006 05:09:39 +0200 (MEST)
In-Reply-To: <1143933507.9228.60.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-04-02 at 00:18 +0100, Adrian McMenamin wrote:
> Sorry to hit the list with another question about the mixer/control
> stuff, but I'm pretty puzzled as to what I am getting wrong.
> 
> I am using mpg123 compiled to only hack oss, so I am reliant on oss
> emulation.
> 
> I have the control code attached below, which defines both master and
> pcm functions (mapped together as the device only plays PCM).

Where's your __devinit snd_aica_mixer() routine that actually creates
the mixer controls, with snd_ctl_new1()?

Look at snd_emu10k1_mixer in alsa-kernel/pci/emu10k1/emumixer.c for
example...

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
