From: "Ivica Bukvic" <ico@fuse.net>
Subject: Update regarding CS4205 (Dell Inspiron 8200) driver problem, any help would be appreciated!
Date: Thu, 2 May 2002 22:33:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c1f24a$d9091f80$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I've been messing with the drivers and kernels and eventually installed
the latest RH 7.2.93 (Beta a.k.a. Skipjack) with 2.4.18 kernel.

Here's the scoop.

With OSS Free the thing only does non-duplex stuff.

With OSS/Commercial, it can run 2 concurrent operations (through Artsd
it can even share the mic input), but the third invoking of the dsp
input (possibly even output, not sure) simply trashes the sound and
causes white-noise like junk to be outputted.

With Alsa, everything works fine as long as there is only one stream (2
would be much greater for real-time stuff since one could be used for
mixing through artsdsp of streams, while other would be used for
real-time processing). Now, if I could get the artsd to work with alsa
drivers that would be the ultimate thing. Right now, artsd works fine
with audio output, but in terms of input it simply is silent, no matter
which input I choose.

I've also discovered that Kmix and aumix give different set of audio
settings than alsamixer, and while you can select microphone as the
recordable source in the alsamixer, you can't in the other two (aumix
and kmix), and maybe this is the reason why no input ever gets through
the artsd.

So, my question is, how do I make artsd aware of the alsa's input
settings, as well as aumix and kmix. I also noticed that artsd does not
offer alsa driver as one of the audio settings options. Now, this may be
just the RH quirk, but if not, can I somehow recompile it or do
something with the artsd so that I can become aware of the Alsa's
settings?

I know there are other options out there (i.e. Jack), but the apps I am
currently using are not jack-ified and therefore I can't use them for
those purposes.

I also tried LD_PRELOAD hack with the libaoss, but that one reports
errors when run with the app I am using (RTcmix, which is OSS only at
this time).

Finally, I tried starting artsd with -a alsa flag, but that gave me:
Unable to select 'alsa' style audio I/O

I would greatly appreciate your help on this issue. Thank you!
Sincerely,

Ico



_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
