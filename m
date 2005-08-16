From: Guilherme Fonseca <gfonsecabr@gmail.com>
Subject: Re: No sound with snd_atiixp driver
Date: Tue, 16 Aug 2005 18:08:06 -0400
Message-ID: <81d03f6f05081615081056511a@mail.gmail.com>
References: <81d03f6f05081306427c167f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <81d03f6f05081306427c167f1@mail.gmail.com>
Content-Disposition: inline
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

Problem solved! Everything works fine after I turned on External
Amplifier on KMix.

Guilherme

On 8/13/05, Guilherme Fonseca <gfonsecabr@gmail.com> wrote:
> I recently bought an HP L2000 laptop (Turion processor). I installed
> Fedora Core 4 (x64 version) and I can't get sound to work. The sound
> card is detected to use the snd_atiixp driver, but no sound plays. The
> information I get from lspci is:
>=20
> 0:14.5 Multimedia audio controller: ATI Technologies Inc: Unknown
> device 4370 (rev 02)
>        Subsystem: Hewlett-Packard Company: Unknown device 3091
>        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 10
>        Memory at c0003400 (32-bit, non-prefetchable) [size=3D256]
>        Capabilities: [40] Message Signalled Interrupts: 64bit-
> Queue=3D0/0 Enable-
>=20
> I think all the modules are loaded correctly:
>=20
> [root@localhost fonseca]# /sbin/lsmod |grep snd
> snd_atiixp             27105  1
> snd_ac97_codec         98437  1 snd_atiixp
> snd_seq_dummy           4677  0
> snd_seq_oss            45477  0
> snd_seq_midi_event     11713  1 snd_seq_oss
> snd_seq                79769  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_ev=
ent
> snd_seq_device         11217  3 snd_seq_dummy,snd_seq_oss,snd_seq
> snd_pcm_oss            63089  0
> snd_mixer_oss          20673  1 snd_pcm_oss
> snd_pcm               122957  3 snd_atiixp,snd_ac97_codec,snd_pcm_oss
> snd_timer              38217  2 snd_seq,snd_pcm
> snd                    69697  11
> snd_atiixp,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,=
snd_mixer_oss,snd_pcm,snd_timer
> soundcore              13409  1 snd
> snd_page_alloc         12105  2 snd_atiixp,snd_pcm
>=20
> Anybody has any ideas? If you need more information, I'll be glad to prov=
ide.
>=20
> Thank you very much,
> Guilherme
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
