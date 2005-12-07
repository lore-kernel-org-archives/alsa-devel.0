From: =?ISO-8859-2?Q?Piotr_Tajdu=B6?= <aegis@op.pl>
Subject: Re: Equalizer for emu10k1
Date: Wed, 07 Dec 2005 21:26:49 +0100
Message-ID: <43974589.1070502@op.pl>
References: <43909E54.20503@op.pl> <s5h3bl7mkj3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp8.poczta.onet.pl (smtp8.poczta.onet.pl [213.180.130.48])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8D22515E
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2005 21:22:25 +0100 (MET)
In-Reply-To: <s5h3bl7mkj3.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Any example to load this with ld10k1?

I have inserted this between tone and vol_master:

#Tone
$LO10K1 -n --ctrl c-bass0,bass1,bass2,bass3,bass4:Tone\ Control\ -\ Bass,=
t-Tone\ Control\ -\ Bass:2,v-Tone\ Control\ -\ Bass:1,c-treble0,treble1,t=
reble2,treble3,treble4:Tone\ Control\ -\ Treble,t-Tone\ Control\ -\ Trebl=
e:3,v-Tone\ Control\ -\ Treble:1,c-toneonoff:Tone\ Control\ -\ Switch,t-T=
one\ Control\ -\ Switch:4 --patch_name Tone\ Controls -a tone.emu10k1
#Input
$LO10K1 --conadd "POUT(PCM Multi Volume)=3DPIN(Tone Controls)"
$LO10K1 --conadd "POUT(Stereo To 51)>PIN(Tone Controls)"

#Equalizer
$LO10K1 -n --patch_name EQ10 -a eq10.emu10k1
#Input
$LO10K1 --conadd "POUT(Tone Controls)>PIN(EQ10)"

#Master
$LO10K1 -n --ctrl c-VolM:Master\ Playback\ Volume,t-Master\ Playback\ Vol=
ume:1 --patch_name Master\ Volume -a vol_master.emu10k1
#Inputs
$LO10K1 --conadd "POUT(EQ10)>PIN(Master Volume)"

Here is init script for audigy:
http://gadrael.w.interia.pl/init_audigy_eq10

>Also, could you make a patch for inclusion to alsa-tools/ld10k1 CVS
>tree?  Such a thing is nice to share in the public tree.
> =20
>
Here is a patch:
http://gadrael.w.interia.pl/eq10.patch


Piotr Tajdu=B6




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
