From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1 multichannel support
Date: Wed, 19 Jan 2005 13:24:31 -0500
Message-ID: <1106159071.3086.19.camel@krustophenia.net>
References: <200501191820.SAA13235@orthoset.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200501191820.SAA13235@orthoset.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: William <walsac3@orthoset.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-01-19 at 18:20 +0000, William wrote:
> Lee Revell wrote:
> >
> > Ok, found the bug.  snd_emu10k1_voice_alloc now takes the number of
> > voices as the third parameter, previously it took 1 or 0 depending on
> > whether 1 or 2 voices were needed.
> > 
> > Does this fix the problem?
> 
> Actually I'm getting lots of these messages every time I play any
> MIDI files on the emu10k1 wavetable synth:
> 
> Jan 19 18:11:00 linux kernel: first==last, number 1, next free 36!
> Jan 19 18:11:03 linux last message repeated 37 times
> Jan 19 18:11:41 linux kernel: first==last, number 1, next free 8!
> Jan 19 18:12:12 linux last message repeated 450 times
> Jan 19 18:13:08 linux last message repeated 847 times
> 
> The comments in your patch say this could be a "BUG (or not enough voices)!"

Yes, that's certainly a bug.  I have hit this occasionally using aplay
while JACK is running but I can't reliably reproduce it.  The wavetable
synth allocates and frees voices much faster.

I will take a look.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
