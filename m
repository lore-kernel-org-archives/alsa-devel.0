From: "Prince.John" <Prince.John@delphi.com>
Subject: Re: ALSA driver for AD1881 ?
Date: Fri, 7 Mar 2003 13:53:34 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <05256CE2.002E2534.00@notes.delphiauto.com>
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
To: mjander@embedded.cl
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi Manuel Jander,

Thank you very much for this info. On my board, the AD1881 is directly
interfaced to an AC97 codec controller. So, I think I need to initialize this
codec controller and to fill out the call backs of AC97 layer, PCM Interface and
Control Interface, specific to AD1881. Is this right?

Thanks,
Prince






"mjander " <mjander@embedded.cl> on 03/06/2003 11:30:31 PM

Please respond to mjander@embedded.cl

To:   Prince John/in2/delphiauto@Delphi_IN2
cc:

Subject:  Re: [Alsa-devel] ALSA driver for AD1881 ?



hi,

For controlling the ac97 registers, use the ac97 codec ALSA interface.
You'll have to write your own drivere for that, but you just havee to
fill out a 'write" and a "read" callback, thats it.

For feeding the AC97 codec with PCM data, i suppose that you are
using some kind of serial
port (uwire, SPI, SSI or similar) as it is done mostly on DSP
boards (i mean Digital Signal Procesors, not sound cards). I have
not checked out if there is some kind of PCM over serial driver,
but it should be quiet easy to implement, since its a matter of
writing the required callbacks only. By the way, if that serial
port has a driver you just have to pipe the data to /dev/ttySXX or
something like that.

Best Regards

Manuel Jander.


---------- Original Message ----------------------------------
From: "Prince.John" <Prince.John@delphi.com>
Date: Thu, 6 Mar 2003 18:08:25 +0530

>
>Hi,
>
>I have a Hitachi SH4 based evaluation board with an AD1881 codec
(onboard). It
>is an AC'97 compliant codec. I'm in need of an ALSA driver for
the same. Is
>there an ALSA driver already available for AD1881? If not where
should I start
>to develop a driver for it? I have gone through the Document -
Writing an ALSA
>driver by Mr. Takashi Iwai. Mine is not PCI or ISA based one. So
could anyone
>give me some info on how to start with, for such on-board codecs?
>
>Thanks in advance,
>Prince.
>
>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Etnus, makers of TotalView,
The debugger
>for complex code. Debugging C/C++ programs can leave you feeling
lost and
>disoriented. TotalView can help you find your way. Available on
major UNIX
>and Linux platforms. Try it free. www.etnus.com
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
.
__________________________________________________
Enviado via NewPlanet WebMail en embedded.cl








-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
