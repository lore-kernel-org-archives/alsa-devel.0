From: rich@tirebiter.dyndns.org (Rich Tollerton)
Subject: Best way to implement a driver-level equalizer?
Date: Sun, 1 Jun 2003 13:19:25 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030601181925.GA9171@tirebiter.dyndns.org>
Reply-To: rtollert@tranquility.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, I'd like to try my hand at implementing a good equalizer at either
the alsalib or alsadriver level, so that all my programs (not just xmms)
are properly equalized.  By 'good' I mean: 16+ bands, ~10hz transition
widths, 32-bit internal precision or better, like shibatch's equalizer
(http://shibatch.sourceforge.net/) which is used to good effect in
foobar2000 on windows.

There are several ways to go about this, and I'm not really sure of the
best one. I hope some of you have some thoughts you could contribute on
the matter.

1) Implement the equ as an as10k1 dsp program and reload it whenever
I want to tweak the equalizer. This is probably the only way to
implement the equalizer so that it utilizes my sblive's hardware mixing
capabilities. However it obviously won't work once I get a better
sound card, the filter size I can implement is quite limited
(1k data size so 200 taps at most is feasible - that's far, far
too little for transition widths on the order of 10hz), there's 
not enough internal precision to reasonably attempt an IIR filter,
and no released method for actually LOADING an as10k1-compiled .bin
file currently exists.

2) Implement the equ as a LADSPA plugin, and use a 'ladspa' plugin type
in .asoundrc to load it.  This is by far the most flexible of these
solutions. As I understand the alsalib architecture though, the plugin
would be applied to the data in userspace, so I'm concerned about
latency issues.  Additionally I've spend a few hours getting the
.asoundrc ladspa plugin to work at all, with no success; it appears to
be unmaintained since 2001. I'm not sure how to get this working with
OSS programs.

3) Implement the equ in kernel mode right before the sound data is
passed to the card. This is, of course, an ungodly hack, as I don't
see an existing interface to do this sort of thing. The equalizer
would need to either be linked in statically to snd-pcm, or an
infrastructure would be created to allow other modules to insert
themselves into the processing chain (thus making it less of a hack). 
I'm leaning towards the former. :)


Ideally I could write this so that only the post-mixed sound is
equalized, but if the hardware mixer output isn't exposed to us then
that's not really possible (unless I use dmix, which I don't want to
do). If I keep the CPU usage down then I don't think this is an issue.

Any comments gladly welcome.

-- 
Rich Tollerton <rtollert@tranquility.net>


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
