From: =?ISO-8859-1?Q?Martin_Kr=FCger?= <m_a_krueger@gmx.de>
Subject: Re: PATCH - MIDI on ice1724 - real-time kernel problem
 SOLVED(?)
Date: Thu, 26 Jun 2008 23:01:15 +0200
Message-ID: <4864039B.7020405@gmx.de>
References: <20080520112539.81C9D2484D@alsa0.perex.cz>	<m2bq2xtixw.fsf@vador.mandriva.com>	<483847ED.8050208@gmx.de>	<483A6D6F.1050108@insite.cz>	<483A96E8.8090507@gmx.de>	<s5hbq2tunel.wl%tiwai@suse.de>	<483AE54C.3090807@gmx.de>	<483D48DE.1010105@gmx.de>	<483E78E7.4020106@insite.cz>	<20080529140349.115520@gmx.net>	<483ED652.6020805@insite.cz>
	<484AFF77.3030901@insite.cz> <4860D57E.10509@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id B5FAA10381B
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 23:01:17 +0200 (CEST)
In-Reply-To: <4860D57E.10509@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@insite.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin Kr=FCger schrieb:
> Hi Pavel,
>
> sorry for the long break, i was really busy at studying.
>
> ---snip---
>
> Thanks a lot,
> Martin
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>   =


Hi again,

i did some other playing around this evening. (Debugging would be a word =

much too big...)

I commented out the logic stuff in the following subroutines of the =

ice1724.c:

- static int vt1724_midi_output_open(struct snd_rawmidi_substream *s)
- static int vt1724_midi_output_close(struct snd_rawmidi_substream *s)
- static void vt1724_midi_output_trigger(struct snd_rawmidi_substream =

*s, int up)
- static void vt1724_midi_output_drain(struct snd_rawmidi_substream *s)

The vt1724_enable_midi_irq(s, VT1724_IRQ_MPU_TX, 1) is killing my =

kernel, i don't know why.
On the input side everything works, so i am a bit confused. Again. ;-)

I will continue debugging, at all this seems to be a good starting point =

for me.

It would be glad, if you could help me some way.

Martin
