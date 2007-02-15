From: Fons Adriaensen <fons@kokkinizita.net>
Subject: Re: Edirol UA-25 advanced mode and various questions
Date: Thu, 15 Feb 2007 15:38:03 +0100
Message-ID: <20070215143803.GB7181@linux-2.site>
References: <1171544079.7797.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1171544079.7797.6.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jean-Michel =?iso-8859-1?Q?Pour=E9?= <jmpoure@free.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 15, 2007 at 01:54:39PM +0100, Jean-Michel Pour=E9 wrote:

> The Edirol UA-25 has two modes : advanced and normal. Advanced mode
> supports up to 96.000 Hz in 24 bits recording. Normal mode supports only
> 16 bits/41100 Hz recording.
> =

> In normal mode, the device is compatible with Alsa USB-sound. Advanced
> mode is not recognised by default by Alsa. Is there any chance that
> Advanced mode works under Alsa? =


I'm using an UA-2 which is quite similar but without the MIDI interface.
The standard ALSA usb driver _does_ support the 'advanced' mode. You have
to restart the module (using modprobe) after each change to mode or sample
frequency. =


Contrary to what you seem to say on the Wiki, this device is full duplex
when in standard mode. Nothing special should be required. It is either
capture or playback only in advanced mode.

As far as ALSA is concerced there is one stereo input stream and/or one
stereo output. It doesn't matter to ALSA from/to which connectors the
signal is coming/going to. If you can record from line input then the
mic input should work as well. If you have analog out then the digital
out will work at the same time. =


-- =

FA

Lascia la spina, cogli la rosa.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
