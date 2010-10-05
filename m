From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: asihpi: Control naming
Date: Tue, 05 Oct 2010 18:10:27 +1300
Message-ID: <4CAAB343.9040603@audioscience.com>
References: <4CA4078E.6010601@audioscience.com> <s5h62xng4wm.wl%tiwai@suse.de>
	<4CA4F1D8.50800@audioscience.com> <s5haamz9che.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id BE784103815
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 07:10:34 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0L9S00IJ3X1F9O00@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 05 Oct 2010 18:10:28 +1300 (NZDT)
In-reply-to: <s5haamz9che.wl%tiwai@suse.de>
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
Cc: Eliot Blennerhassett <linux@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/10/10 09:56, Takashi Iwai wrote:

> So, you have matrix volumes.  We had discussions how to implement
> the matrix volumes, and there is actually an infrastructure to
> handle multi-dimension volume arrays.  But, no driver is using the
> feature, IIRC...


Further on the subject of playback vs capture vs other...
Of course we do have controls that are obviously "Playback" or "Capture",
however we also have controls that connect PCM out to PCM in i.e. both
Playback and Capture are involved,

"PCM0 to PCM1 Playback Capture Volume"  .. nooo!
"PCM0 to PCM1 Loop Volume"  ???

and others that connect linein to lineout ie. neither Capture or
Playback involved.

"LineIn2 to LineOut3 Volume"
maybe "LineIn2 to LineOut3 Loop Volume" ?

> 
>> Also, on the input multiplexer (route?), the options are
...
>> I.e. the names match, rather than using indices in one place, and
>> distinct names in another
> 
> One (known) remaining problem is the matching between an enum item
> string to a control (or mixer) with an index number.  

Exactly!

> For example,
> some HD-audio codecs have multiple mics, and a similar problem appears
> there.
> 
> 
> Takashi


-- 
Eliot Blennerhassett
AudioScience Inc.
