From: claus@ridi.com
Subject: Re: Hoontech Audio DSP24 Value (+bracket)
Date: 12 Feb 2002 14:49:33 UT
Message-ID: <0000723B.3C693976@oz.ridi.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset="iso-8859-1"
Content-Transfer-Encoding: 7Bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa.alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

> > Since your card was recognized as STDSP24, it means that both cards
> > have the same sub vendor/device id.  Thus it's difficult to guess
> > which chip is.  Perhaps trying to detect ak4524 at first, then one
> > can recognize it as DSP24 Value or not.
>
> I asked Hoontech about that too.

It is not possible to distinguish between a DSP24 Value and a DSP24 card in
software. Also you cannot detect the converter on the card (as it is not 
needed).

The DSP24 PCI card provides a interface that is called "H-BUS" and allows you
to connect several external boxes (ADC, DAC, Digital I/O interfaces, etc.) to
one card. Via GPIO you can (and need to) controll this interface. Up to four
external boxes with up to 4 stereo input channels on each box can be adressed
at the same time. You can patch any of these stereo inputs to the Envy24 input
by GPIO during runtime. This allows you for example to use a DS2000 (ADAT/TDIF
interface) and a ADC&DAC2000 (analog I/O) at the same time and to switch 
between the inputs when needed. An introduction to this can be found on our
website: check www.staudio.com -> Service -> Knowledge Base -> DSP24 -> H-BUS.

The DSP24 Value simulates this by connecting the ADC on the card virtually as
box number 1, input 1/2.

> The DAC & ADC volume
> don't seem to work though.

The hardware does not provide any function to change the input or output level
of the analog I/O.

Best regards,

Claus Riethmueller
RIDI multimedia
www.ridi.com
claus@ridi.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
