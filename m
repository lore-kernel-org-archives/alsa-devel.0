From: "Marc Brooker" <marcbrooker@gmail.com>
Subject: Sample Rate Conversion Quality in ALSA
Date: Mon, 21 Aug 2006 12:16:04 +0200
Message-ID: <b5ee41f40608210316t562c803eye73701c75904627@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I am new to the ALSA development, and would be interested in
contributing in future.

After installing the latest Ubuntu on my home machine, I noticed that
dmix is enabled by default. This is a very good move in my opinion, as
it makes Linux sound much more transparent to the end user. However, I
was concerned with the quality of the mixing algorithm and sample rate
conversion used by dmix.

The conclusions I came to after reading the source were the following
(please correct me if I am wrong).

1) The algorithm used by dmix looks to be fairly good. While my x86
assembler is rusty (I read the version in pcm_dmix_i386.h) it seems to
keep 24 bits of significant audio data and is unlikely to cause any
major sound quality problems.

2) The sample rate conversion algorithm (linear) is very poor. I did
some loopback measurements with both real sample material and
synthetic waveforms and it seems to add several percent harmonic
distortion in some cases.

The rate module (pcm_rate.c) from alsa-plugins adresses problem
effectively by using high quality SRC from libsamplerate. The only
problem here is that it is fairly tricky to enable (it requires adding
defaults.pcm.rate_converter "samplerate" to .asoundrc) and it isn't
distributed by default in Ubuntu or Debian unstable (I don't know
about other distributions). While this is a distribution issue and not
an ALSA bug, users are likely to blame it on ALSA.

Is any consideration being given to the quality of SRC in ALSA? I
understand that the tradeoff between quality and performance is an
important one. In my mind, however, it would make sense to make it
easier for the end user to enable higher quality SRC on fast machines.
The low quality (but fast) SRC algorithm currently used will degrade
sound quality for some users and is likely to reflect badly on the
sound experience in Linux.

I would be happy to take part in the improvement of the current
situation but would be interesting in hearing developers opinions
before writing a patch.

Cheers

Marc Brooker

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
