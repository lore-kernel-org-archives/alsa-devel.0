From: p z oooo <pzad@pobox.sk>
Subject: RE: emu10k1 polishing?
Date: Wed, 11 Feb 2004 07:56:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402110656.i1B6uqQI022408@www7.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: kouhia@nic.funet.fi
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>What exactly happens when I record at sample rate 44100 Hz?
>Does emu10k1 chip run at sample rate 44100 Hz as well?
>(It is claimed that emu10k1 runs only at rate 48000 Hz.)

>If emu10k1 runs at 48000 Hz, at what rate A/D converter runs?
>If emu10k1 runs at 48000 Hz and Alsa at rate 44100 Hz, where the
>sample rate conversion happens?

What I know:
emu10k1 runs at 48000 Hz,
A/D converter runs at 48000 Hz
Sample rate conversion happens in hardware(in emu10k1).
emu10k1 has many parts - wavetable synth, DSP, SRC, ...

>2. Alsamixer shows obscure names
You could rename it in alsa-driver/alsa-kernel/pci/emu10k1/emufx.c
and send patch here.

Peter Zubaj


=0A____________________________________=0Ahttp://www.logofun.pobox.sk - uro=
bte radost svojmu telefonu=0A


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
