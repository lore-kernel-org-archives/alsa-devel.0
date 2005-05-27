From: Chris Rankin <rankincj@yahoo.com>
Subject: CVS alsamixer core dumps when displaying Capture devices
Date: Fri, 27 May 2005 23:52:37 +0100 (BST)
Message-ID: <20050527225237.59613.qmail@web52903.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Hi,

The latest CVS alsamixer is aborting as soon as I press "F4":

(gdb) where
#0  0xffffe410 in ?? ()
#1  0xbffff2e0 in ?? ()
#2  0x00000006 in ?? ()
#3  0x000051b4 in ?? ()
#4  0xb7dbe221 in *__GI_raise (sig=3D6)
    at ../nptl/sysdeps/unix/sysv/linux/raise.c:64
#5  0xb7dbf979 in *__GI_abort () at ../sysdeps/generic/abort.c:88
#6  0xb7db7b16 in *__GI___assert_fail (assertion=3D0x0, file=3D0x0, line=3D=
0,=20
    function=3D0xb7f893a3 "snd_mixer_selem_get_enum_item") at assert.c:83
#7  0xb7f1c31c in snd_mixer_selem_get_enum_item (elem=3D0x0,=20
    channel=3DSND_MIXER_SCHN_FRONT_LEFT, itemp=3D0x0) at simple.c:1975
#8  0x0804bc36 in mixer_update_cbar (elem_index=3D0) at alsamixer.c:971
#9  0x0804ea47 in main (argc=3D-1, argv=3D0x0) at alsamixer.c:1099

(gdb) list
1970            assert(elem->type =3D=3D SND_MIXER_ELEM_SIMPLE);
1971            s =3D elem->private_data;
1972            if ((unsigned int) channel >=3D s->str[0].channels)
1973                    return -EINVAL;
1974            helem =3D s->ctls[CTL_ENUMLIST].elem;
1975            assert(helem);
1976            memset(&ctl, 0, sizeof(ctl));
1977            err =3D snd_hctl_elem_read(helem, &ctl);
1978            if (! err)
1979                    *itemp =3D ctl.value.enumerated.item[channel];


I have a SB-Live! soundcard in this machine.

Cheers,
Chris



=09
=09
	=09
___________________________________________________________=20
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voic=
email http://uk.messenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=3Doffad-ysdn-ostg-q22=
005
