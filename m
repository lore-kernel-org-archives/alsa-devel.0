From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: emu10k1 effect processor
Date: Mon, 27 Sep 2004 13:47:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409271147.i8RBkvBX024502@www5.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
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
To: pat@dumaisnet.ca
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

>I had in mind that I could do something like this:
>snd_loadEmu10k1Effect("./vibrato.bin");

ld10k1 contains library and you can load effect to dsp with 2 function
calls + some function call calls to connect to ld10k1. But effect is
program and needs inputs and outputs, and this you need tell to ld10k1
too.

>snd_setEffectParam("vibrato",PARAM_VIBRATO_FREQ,20); // to set the
>frequency of the vibrato effect to 20hz

You can export effect parameter as controls. These controls are
acessible through standard alsa mixer api.

Peter Zubaj

=0A____________________________________=0Ahttp://www.pobox.sk/ - spolahliva=
 a bezpecna prevadzka=0A=0A=0A


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
