From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: ATI IXP hardware mixing
Date: Fri, 15 Sep 2006 09:28:33 +0200
Message-ID: <1158305313.19232.270994168@webmail.messagingengine.com>
References: <eeboe2$4r0$1@sea.gmane.org> <1158245895.7948.69.camel@mindpipe>
	<eebrns$i2v$1@sea.gmane.org> <1158247753.7948.77.camel@mindpipe>
	<eebtj7$qrn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <eebtj7$qrn$1@sea.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Zephiris <zephiris@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Zephiris wrote:
> I'm trying to get the ATI IXP driver to use hardware mixing.
> [...] all I want is to know is what to change in the source that needs
> to support it, since several glances through the source and brief API
> docs, as well as mailing lists, etc, don't reveal effectively nothing
> supporting hardware mixing at all.

It's documented in the description of snd_pcm_new() in the section
"Constructors":
| The fourth and fifth arguments are the number of substreams for
| playback and capture, respectively. [...]
| If a chip supports multiple playbacks or captures, you can specify
| more numbers, but they must be handled properly in open/close, etc.
| callbacks. When you need to know which substream you are referring to,
| then it can be obtained from struct snd_pcm_substream data passed to
| each callback as follows:
| 
|   struct snd_pcm_substream *substream;
|   int index = substream->number;

Then you have to use that index to access the corresponding DMA engine
of the hardware.


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
