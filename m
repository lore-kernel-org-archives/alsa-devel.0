From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] Pc Speaker
Date: Tue, 13 May 2008 14:25:48 +0200
Message-ID: <482988CC.3070109@keyaccess.nl>
References: <20080513110322.030a5386.zoup@zoup.org>	<48296CFF.5000207@keyaccess.nl>	<20080513151425.448369e8.zoup@zoup.org>	<4829781E.6040909@keyaccess.nl>
	<s5hlk2ee9gl.wl%tiwai@suse.de> <48297C5D.5010507@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A13924AEE
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 14:24:18 +0200 (CEST)
In-Reply-To: <48297C5D.5010507@keyaccess.nl>
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

On 13-05-08 13:32, Rene Herman wrote:

> On 13-05-08 13:20, Takashi Iwai wrote:

>> Anyway, the problem of beep on Dell XPS is a different. The PC beep 
>> isn't implemented (initialized) in the sound driver side. I have no 
>> interest in fixing it as I hate PC beep feature, but am willing to 
>> apply patches if provided :)
> 
> I suppose his beeper should stil beep through the input driver if he
> just selects "N" for snd-pcsp?
> 
> If not, if it worked before, and if I were him, I'd be throwing up a
> stink calling it a regression...

(yes, I get it, not a regression, just jumped to the conclusion it was a 
changed situation due to the option juggling new to new kernels)

Not having the hardware, I'm not very likely to be useful but if the 
only problem is someone needing to turn available information into an 
addition to the driver, you can try me...

Rene.
