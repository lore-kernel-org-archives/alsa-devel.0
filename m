From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: ALSA / emu10k1 / SPDIF / surround?
Date: Tue, 30 Aug 2005 20:26:14 -0400
Message-ID: <1125447974.19563.34.camel@mindpipe>
References: <1124755115.5763.3.camel@hostmaster.org>
	 <1125166820.22285.68.camel@hostmaster.org>
	 <1125168446.25011.68.camel@mindpipe>
	 <1125173150.22285.103.camel@hostmaster.org>
	 <1125174445.25011.76.camel@mindpipe>
	 <1125177706.22285.144.camel@hostmaster.org>
	 <1125178767.25011.86.camel@mindpipe>
	 <1125181627.22285.155.camel@hostmaster.org>
	 <1125183623.25011.102.camel@mindpipe>
	 <1125195487.2684.8.camel@hostmaster.org>
	 <1125196132.25011.111.camel@mindpipe>  <s5hbr3h3xxy.wl%tiwai@suse.de>
	 <1125325907.4598.23.camel@mindpipe>
	 <1125342246.21560.2.camel@hostmaster.org>
	 <1125345314.4598.58.camel@mindpipe>
	 <1125356738.21560.27.camel@hostmaster.org>
	 <1125356936.4598.83.camel@mindpipe>
	 <1125446643.1785.15.camel@hostmaster.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1125446643.1785.15.camel@hostmaster.org>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-08-31 at 02:04 +0200, Thomas Zehetbauer wrote:
> On Mon, 2005-08-29 at 19:08 -0400, Lee Revell wrote:
> > I guess you already looked at Documentation/SB-Live-mixer.txt?
> 
> Sure I have, but I don't think this documentation is correct:
> 
> "Wave (Surround|Center|LFE) Playback Volume" apparently do some kind of
> stereo upmixing. I guess that is why I have seen these controls going to
> zero when using 6 channel output.

Actually the docs are correct:

name='Wave Playback Volume',index=0

This control is used to attenuate samples for left and right PCM FX-bus
accumulators. ALSA uses accumulators 0 and 1 for left and right PCM samples.
The result samples are forwarded to the front DAC PCM slots of the AC97 codec.

name='Wave Surround Playback Volume',index=0

This control is used to attenuate samples for left and right PCM FX-bus
accumulators. ALSA uses accumulators 0 and 1 for left and right PCM samples.
The result samples are forwarded to the rear I2S DACs. These DACs operates
separately (they are not inside the AC97 codec). 

name='Wave Center Playback Volume',index=0

This control is used to attenuate samples for left and right PCM FX-bus
accumulators. ALSA uses accumulators 0 and 1 for left and right PCM samples.
The result is mixed to mono signal (single channel) and forwarded to
the ??rear?? right DAC PCM slot of the AC97 codec.

name='Wave LFE Playback Volume',index=0

This control is used to attenuate samples for left and right PCM FX-bus
accumulators. ALSA uses accumulators 0 and 1 for left and right PCM.
The result is mixed to mono signal (single channel) and forwarded to
the ??rear?? left DAC PCM slot of the AC97 codec.

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
