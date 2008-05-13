From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] Pc Speaker
Date: Tue, 13 May 2008 13:32:45 +0200
Message-ID: <48297C5D.5010507@keyaccess.nl>
References: <20080513110322.030a5386.zoup@zoup.org>	<48296CFF.5000207@keyaccess.nl>	<20080513151425.448369e8.zoup@zoup.org>	<4829781E.6040909@keyaccess.nl>
	<s5hlk2ee9gl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 2144824ADB
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:31:16 +0200 (CEST)
In-Reply-To: <s5hlk2ee9gl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>, Armin ranjbar <zoup@zoup.org>
List-Id: alsa-devel@alsa-project.org

On 13-05-08 13:20, Takashi Iwai wrote:

>> Yes, that would seem to be amazingly clumsily done. Perhaps there
>> was a reason (adding alsa-devel).
> 
> Since snd-pcsp itself provides the input pcspkr functionality, it 
> replaces the input pcspkr driver.

Ah. Yes, then it starts to make sense.

> Anyway, the problem of beep on Dell XPS is a different. The PC beep 
> isn't implemented (initialized) in the sound driver side. I have no 
> interest in fixing it as I hate PC beep feature, but am willing to 
> apply patches if provided :)

I suppose his beeper should stil beep through the input driver if he
just selects "N" for snd-pcsp?

If not, if it worked before, and if I were him, I'd be throwing up a
stink calling it a regression...

Rene.
