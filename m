From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Help wanted: emachines em350 internal mic
Date: Tue, 07 Dec 2010 16:11:59 +1300
Message-ID: <4CFDA5FF.6060403@audioscience.com>
References: <AANLkTi=T_5nGv85YE8DcDvyF_HFouh7a-6tOmk58+8EO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 25EA110394A
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 04:12:05 +0100 (CET)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LD100BVKFK15Q10@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 07 Dec 2010 16:12:02 +1300 (NZDT)
In-reply-to: <AANLkTi=T_5nGv85YE8DcDvyF_HFouh7a-6tOmk58+8EO@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks Raymond,

On 03/12/10 15:33, Raymond Yau wrote:
>>> Greetings,
> 
> 
>>> There is only a single mic on this netbook. However, the alsa device
>>> shows up as stereo, and the right channel carries an inverted copy of
>>> the left channel.
> 
> http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=59c774ed5ee00e9623a204c3234191d6a6d8cf7a

Commitlog was "Add route_policy copy to HDA-Intel.conf for capture
Since some digital mics have the phase-inversion problem in one channel,
adding both channels for mono stream results in the noise. Use
route_policy copy to avoid that situation."

As far as I can guess, the commit helps when an application asks to
record mono from the stereo device, by copying L rather than summing L+R

My machine already has this, however it doesn't really fix the root of
the problem.

Because the internal mic appears as a stereo device, rather than a mono,
applications can open it as stereo.

Only later when the resulting signal L+R is sent to a mono output does
the signal "disappear".

So I'm back to wondering how to force an app (primarily PulseAudio) to
see the mic as mono?

(I think the external jack is also only mono, at least when used as a
mic input?)

>>> So when the two channels are summed to make a mono (e.g. for
>>> telephony, or playback on mono internal speaker) it appears that there
>>> is no signal.
> 
>>> Is there a way to "cure" this problem in the driver?  I can think of
>>> * Force internal mic capture to be mono (left only)
>>> * Copy left to right capture

Even in stereo mode!

>>> * Invert right capture
>>> but don't know how easy any are to implement.


-- 
Eliot Blennerhassett
AudioScience Inc.
