From: David Olofson <david@olofson.net>
Subject: Re: Echoaudio drivers
Date: Thu, 20 Feb 2003 17:03:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302201703.27819.david@olofson.net>
References: <XFMail.20030220164059.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20030220164059.pochini@shiny.it>
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

On Thursday 20 February 2003 16.40, Giuliano Pochini wrote:
[...]
> According to official docs, 20 and 24bit versions have only a
> different DAC. The driver always sends data in the same format.
> I've not looked at the sources yet.

Yes, that seems to be the case. All models use 24 bit signal paths=20
internally, and they seem to use the same multichannel DMA engine and=20
stuff as well. There's specific firmware for pretty much every model=20
in their driver, but on the host side, it seems like it's mostly=20
about configurations and feature sets.


//David Olofson - Programmer, Composer, Open Source Advocate

=2E- The Return of Audiality! --------------------------------.
| Free/Open Source Audio Engine for use in Games or Studio. |
| RT and off-line synth. Scripting. Sample accurate timing. |
`---------------------------> http://olofson.net/audiality -'
   --- http://olofson.net --- http://www.reologica.se ---



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
