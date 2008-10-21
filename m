From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: View alsa-lib plugins setup for any app?
Date: Wed, 22 Oct 2008 09:55:01 +1300
Message-ID: <200810220955.01218.linux@audioscience.com>
References: <48FD3070.7080406@audioscience.com> <s5h1vyaa22e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 60FA5243E5
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 22:51:27 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K9300AMEWL7CT40@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 22 Oct 2008 09:51:07 +1300 (NZDT)
In-reply-to: <s5h1vyaa22e.wl%tiwai@suse.de>
Content-disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 21 October 2008 19:34:49 Takashi Iwai wrote:
> Sorry, I don't understand well your question.  Do you want to see the
> alsa-plugin chain of a running application from the outside, 

Yes. Basically see something that looks like the result of "aplay -v", but for 
a running app from the outside.  

E.g. to see if the app is using dmix, plughw etc, what parameters the app sees 
vs how the card is accessed.

Best if this info was available like the proc files for the driver, but if it 
required running the app in a special context (debugger-like or LD_PRELOAD) 
that would probably still be useful.

The app should not have to be recompiled.


> or do you 
> ask an API to show the alsa-plugin chains, 

no. Now I see that you are thinking of snd_pcm_*_dump() family.

> or a way to show hw_params/sw_params for plugins?

I this is included in my first "yes"

regards

Eliot
