From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Bug in setting channels,
 related to recent ELD/EDID changes?
Date: Thu, 23 Dec 2010 07:48:02 +0200
Message-ID: <4D12E292.9050204@iki.fi>
References: <AANLkTikneYHc9NmrRW41=xRBW_PVgc0jqdcOaTgHcC-t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
	[83.102.40.133]) by alsa0.perex.cz (Postfix) with ESMTP id 0300924825
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 06:48:06 +0100 (CET)
In-Reply-To: <AANLkTikneYHc9NmrRW41=xRBW_PVgc0jqdcOaTgHcC-t@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: mailing@alsa-project.org, alsa-dev <alsa-devel@alsa-project.org>, list@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 23.12.2010 04:22, VDR User wrote:
> Hi.  After updating my stable kernel from 2.6.35.7 to 2.6.36.2, I get
> a problem when tuning HDTV channels that use surround sound.  The
> error I get is as follows:
> 
> audio_alsa_out: Cannot set number of channels to 6 (err=-22:Invalid argument)
> audio_out: open failed!
> 
> With the following xine error:
> ---------------------- (ERROR) ----------------------
> The audio device is unavailable. Please verify if another program
> already uses it.
> 
> ['Audio device unavailable' '']
> ------------------ (END OF ERROR) -------------------

What are the contents of /proc/asound/NVidia/eld* and
/proc/asound/NVidia/codec* ?

> This problem did not exist in 2.6.35.7 alsa drivers (using
> snd-hda-intel).  I have noticed that there has been recent changes
> associated with ELD/EDID that sets limitations on channels.  First of
> all I think this is a horrible idea since many devices don't even
> contain correct EDID.  It's simply too unreliable to use.

Well, I haven't yet seen any EDID which contained incorrect audio
information. Also, in case we find no information in the ELD, all
channels and formats are allowed.

> Secondly,
> could the above problem be related to those changes?

It could.

> If anyone knows a fix for this or can point me in the right direction
> (aside of going back to 2.6.35.7), PLEASE fill me in.
> 
> Here are some system specs:
> debian testing
> kernel snd-hda-intel driver used for hdmi audio on nvidia gt240 video card
> hdmi going to 7.1 surround sound receiver & setup
> 
> Any help is greatly appreciated!
> 
> Best regards,
> Derek


-- 
Anssi Hannula
