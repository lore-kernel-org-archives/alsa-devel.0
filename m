From: Peter Zubaj <pzad@pobox.sk>
Subject: STAC9758 questions
Date: Tue, 29 Jun 2004 12:25:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406291025.i5TAPWAQ027313@www4.pobox.sk>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

In file alsa-driver/alsa-kernel/pci/ac97_patch.c
in function
snd_ac97_stac9758_output_jack_put

there is=20
up(&ac97->mutex);
but not=20
down(&ac97->mutex);=20
is this good (why not remove up(&ac97->mutex);)????

also
in function snd_ac97_stac9758_input_jack_put id used
ac97_update_bits_page, but in function
snd_ac97_stac9758_output_jack_put is only used function
snd_ac97_update_bits to set value.
Why both functions not use function ac97_update_bits_page to set value
 ???

Peter Zubaj








=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D REKLAMA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0Ahttp://www.asap-translation.com/ - expresn=
e prekladatelske sluzby=0A        http://www.jazykovky.sk/ - vyber si svoju=
 jazykovu skolu=0A        http://www.recruiter.sk/ - internetova burza prac=
e=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
