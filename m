From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: More info on hard lock-ups with MIDI on envy24,
	x86_64 machine
Date: Thu, 11 Aug 2005 10:29:49 -0400
Message-ID: <1123770589.6980.1.camel@mindpipe>
References: <200508111525.07881.daniel@64studio.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200508111525.07881.daniel@64studio.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel James <daniel@64studio.com>
Cc: alsa-devel@lists.sourceforge.net, Free Ekanayaka <free@64studio.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-08-11 at 15:25 +0100, Daniel James wrote:
> Hello again,
> 
> I swapped the M-Audio envy24 card for a SoundBlaster PCI EMU10K1 card 
> and the problem went away - MIDI worked fine. I put the envy24 card 
> back in and the problem came back. It only happens when applications 
> make a MIDI connection to the ALSA sequencer, whether the MIDI dongle 
> is attached or not. Audio-only applications don't cause the lock-ups.
> 
> Is this perhaps a bug in the envy24 driver that only affects x86_64 
> machines? Or if other people have this combination working OK, could 
> it be faulty hardware? Any clues would be appreciated.

Sounds like a driver bug to me.

I guess you have tried to trigger the crash from a console as well as X,
and there's no Oops output?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
