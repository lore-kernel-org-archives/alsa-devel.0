From: "Ivica Bukvic" <ico@fuse.net>
Subject: Question regarding the alsa's audio latency benchmark
Date: Mon, 6 Oct 2003 21:47:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c38c74$f6825f20$0f02a8c0@ICO>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-audio-dev@music.columbia.edu, linux-audio-user@music.columbia.edu
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I've had an interesting discussion with a professor and a distinguished
member of the electroacoustic music community regarding audio latencies
which made me realize that I did not understand the issue in its
entirety. Hence, I looked around the net in order to educate myself.

I soon stumbled across the following site:

http://old.lwn.net/1999/0916/a/latency.html

Admittedly, it's quite old but that, if anything speaks only in Linux's
favor in terms of its pro-audio readiness. At any rate, I was checking
out the benchmark data and was wondering as to how did this
person/software app get to the 0.73ms buffer fragment that is equal to
128bytes? In other words, what sampling rate was used?

128 bytes in 44100Hz sampling rate = 3ms
128 bytes in 88200Hz sampling rate = 1.45ms
128 bytes in 176400Hz sampling rate = 0.725ms (this one being obviously
closest, but at the same time, what kind of hardware supports this
sampling rate, especially in 1999 when this test was done?)
128 bytes in 192000Hz sampling rate = 0.3ms

So what gives? It seems like it is some kind of a 176k-ish sampling rate
that, AFAIK does not exist.

Furthermore, my question is what app was used to produce those
graphs/results and whether these latency tests take into account
hardware latencies (i.e. DSP converters, PCI->CPU->PCI->output etc.), in
other words, is this latency that is achievable with the following
setup:

Input->soundcard->cpu(with some kind of DSP)->soundcard->Output

Your help on this matter is greatly appreciated!

Ivica Ico Bukvic, composer & multimedia sculptor
http://meowing.ccm.uc.edu/~ico




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
