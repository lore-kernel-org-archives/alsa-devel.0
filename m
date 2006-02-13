From: Luca Piccioni <luca.piccioni@gmail.com>
Subject: Re: IEC958 plugin and Rate plugin programming
Date: Mon, 13 Feb 2006 16:13:58 +0100
Message-ID: <43F0A236.8050604@gmail.com>
References: <43EDAE9C.7060808@gmail.com> <20060213081740.GB8896@ifiu25.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060213081740.GB8896@ifiu25.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Clemens Ladisch wrote:

> What is the actual problem?

Well... no sound! I've used "aplay" to test the S/PDIF output. The
soundcard seems to
work well, because the ampli recognize PCM / Digital, so I suppose the
connection between
PC and ampli is correct.

So first I tried "aplay -Dhw:0,4" test.wav", but no sound. Then I've
tried also "iec958" and "spdif",
but nothing is outputted!
Application work without reporting any error (only a warning if I'm
not using a 48 kHz PCM, eliminable
using "plug:iec958" as device).

For the moment I haven't tried to use "iec958:0" as device because I
don't have the amplifier to test
audio. Any suggestion to know if any PCM data is outputted to a
particoular device?

My soundcard is a Realtek ALC850 (reported by alsamixer), and I'm
using the intel8x0 ALSA module. I'm
also programming a multimedia application, so I've tried to use the
snd_pcm_iec958_open... I thought this
was the solution! :-/ As I've understood, this plug (iec958) it's used
automatically when I setup i linear
PCM to the spdif device? While I have to create this plug
(programming) whenever the soundcard can't
do this task?

About mixers (sorry for the stupid question, but for me it's quite
new!): what mixers I should enable
to output to digital?

Thanks for all your help!

Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD8KI2KK3BAIBUkxERAuPzAKCu2d6+IeR04Nvl3hLeux9ukMWaqACg6vdD
ymBaYb01GB1kCtLhX8BtFpo=
=+bvZ
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
