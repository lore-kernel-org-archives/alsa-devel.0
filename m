From: Juan Pedro Paredes Caballero <juampe@iquis.com>
Subject: Re: ALSA driver - snd-bt87x and Flyvideo`98
Date: Tue, 17 Jan 2006 13:56:45 +0100
Message-ID: <dqiphh$bc7$1@sea.gmane.org>
References: <43C0F637.1020100@dabrowa.pl> <s5hoe2lh2z1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> At Sun, 08 Jan 2006 12:23:35 +0100,
> Pawe? Goleniowski wrote:
>>=20
>> Hi,
>> My TV card used to work as additional sound device with snd-bt87x. But
>> not any more.
>> Under 2.6.12 it still works - dmesg shows info that card is
>> unrecognized and gives this address to send informations:
>> Card: Flyvideo 98 (probably) LR50
>> ID: 0x1851:0x1850 (but scanpci shows that BT audio device is 0x109e
>> 0x0878)
>>=20
>> Under 2.6.15 or ALSA 1.0.11rc2 the BT audio device doesn't work any
>> more nor even gives any information in dmesg.
>=20
> Please elaborate what do you mean "doesn't work any more".
> If the loading failed, try load_all=3D1 module option.
>=20
>=20

Please see http://bugzilla.kernel.org/show_bug.cgi?id=3D5851



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=3D=
121642
