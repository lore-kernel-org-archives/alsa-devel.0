From: Johannes Berg <johannes@sipsolutions.net>
Subject: lockdep warning on 2.6.29-rc1 with pulseaudio
Date: Tue, 13 Jan 2009 18:02:01 +0100
Message-ID: <1231866121.3847.6.camel@johannes>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3338970215158567465=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id D24B224348
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 18:02:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============3338970215158567465==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M2aiWDW31KMjGcNlcjm2"


--=-M2aiWDW31KMjGcNlcjm2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Sorry if you've seen this already, I couldn't find it on gmane.

soemthing is doing mutex_lock(&pcm->open_mutex); but this lock depends
on &chip->open_mutex which in turn depends on &codec->spdif_mutex (seems
a little odd) and that already depends on mmap_sem, through
might_fault()?

[   49.742444] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   49.742449] [ INFO: possible circular locking dependency detected ]
[   49.742453] 2.6.29-rc1-wl-11361-g269245b-dirty #15
[   49.742455] -------------------------------------------------------
[   49.742458] pulseaudio/3550 is trying to acquire lock:
[   49.742461]  (&pcm->open_mutex){--..}, at: [<ffffffffa059f86e>] snd_pcm_=
release+0x3e/0xb0 [snd_pcm]
[   49.742479]=20
[   49.742479] but task is already holding lock:
[   49.742482]  (&mm->mmap_sem){----}, at: [<ffffffff802c4a42>] sys_munmap+=
0x42/0x80
[   49.742493]=20
[   49.742493] which lock already depends on the new lock.
[   49.742494]=20
[   49.742497]=20
[   49.742497] the existing dependency chain (in reverse order) is:
[   49.742500]=20
[   49.742501] -> #3 (&mm->mmap_sem){----}:
[   49.742507]        [<ffffffff80273427>] check_prev_add+0x3b7/0x770
[   49.742513]        [<ffffffff80273de6>] validate_chain+0x606/0x6c0
[   49.742518]        [<ffffffff802742df>] __lock_acquire+0x43f/0xa10
[   49.742522]        [<ffffffff80274941>] lock_acquire+0x91/0xc0
[   49.742526]        [<ffffffff802bc39f>] might_fault+0x7f/0xb0
[   49.742532]        [<ffffffffa07fb15d>] snd_hda_mixer_amp_tlv+0x6d/0xf0 =
[snd_hda_codec]
[   49.742544]        [<ffffffffa0b20bb0>] alc_cap_vol_tlv+0x70/0xa0 [snd_h=
da_codec_realtek]
[   49.742557]        [<ffffffffa03a30be>] snd_ctl_tlv_ioctl+0x14e/0x1d0 [s=
nd]
[   49.742571]        [<ffffffffa03a527b>] snd_ctl_ioctl+0x26b/0x540 [snd]
[   49.742581]        [<ffffffff802e82d1>] vfs_ioctl+0x31/0xa0
[   49.742587]        [<ffffffff802e8699>] do_vfs_ioctl+0x89/0x350
[   49.742592]        [<ffffffff802e89aa>] sys_ioctl+0x4a/0x80
[   49.742597]        [<ffffffff8020bd1b>] system_call_fastpath+0x16/0x1b
[   49.742603]        [<ffffffffffffffff>] 0xffffffffffffffff
[   49.742608]=20
[   49.742609] -> #2 (&codec->spdif_mutex){--..}:
[   49.742615]        [<ffffffff80273427>] check_prev_add+0x3b7/0x770
[   49.742619]        [<ffffffff80273de6>] validate_chain+0x606/0x6c0
[   49.742623]        [<ffffffff802742df>] __lock_acquire+0x43f/0xa10
[   49.742628]        [<ffffffff80274941>] lock_acquire+0x91/0xc0
[   49.742632]        [<ffffffff805ac5fc>] mutex_lock_nested+0xec/0x380
[   49.742639]        [<ffffffffa07f8d54>] snd_hda_multi_out_analog_open+0x=
84/0x130 [snd_hda_codec]
[   49.742649]        [<ffffffffa0b1ac60>] alc880_playback_pcm_open+0x20/0x=
30 [snd_hda_codec_realtek]
[   49.742659]        [<ffffffffa0897f39>] azx_pcm_open+0x209/0x280 [snd_hd=
a_intel]
[   49.742667]        [<ffffffffa05a01b8>] snd_pcm_open_substream+0x58/0xa0=
 [snd_pcm]
[   49.742677]        [<ffffffffa05a038b>] snd_pcm_open+0x18b/0x280 [snd_pc=
m]
[   49.742687]        [<ffffffffa05a04ec>] snd_pcm_playback_open+0x2c/0x40 =
[snd_pcm]
[   49.742697]        [<ffffffffa039f7fc>] __snd_open+0x14c/0x270 [snd]
[   49.742707]        [<ffffffffa039f947>] snd_open+0x27/0x40 [snd]
[   49.742717]        [<ffffffff802dcd47>] chrdev_open+0x137/0x210
[   49.742722]        [<ffffffff802d7a5a>] __dentry_open+0x10a/0x340
[   49.742727]        [<ffffffff802d7d97>] nameidata_to_filp+0x57/0x70
[   49.742732]        [<ffffffff802e69de>] do_filp_open+0x1fe/0x970
[   49.742737]        [<ffffffff802d7868>] do_sys_open+0x78/0x110
[   49.742742]        [<ffffffff802d792b>] sys_open+0x1b/0x20
[   49.742746]        [<ffffffff8020bd1b>] system_call_fastpath+0x16/0x1b
[   49.742751]        [<ffffffffffffffff>] 0xffffffffffffffff
[   49.742756]=20
[   49.742756] -> #1 (&chip->open_mutex){--..}:
[   49.742762]        [<ffffffff80273427>] check_prev_add+0x3b7/0x770
[   49.742767]        [<ffffffff80273de6>] validate_chain+0x606/0x6c0
[   49.742771]        [<ffffffff802742df>] __lock_acquire+0x43f/0xa10
[   49.742775]        [<ffffffff80274941>] lock_acquire+0x91/0xc0
[   49.742780]        [<ffffffff805ac5fc>] mutex_lock_nested+0xec/0x380
[   49.742785]        [<ffffffffa0897d78>] azx_pcm_open+0x48/0x280 [snd_hda=
_intel]
[   49.742792]        [<ffffffffa05a01b8>] snd_pcm_open_substream+0x58/0xa0=
 [snd_pcm]
[   49.742802]        [<ffffffffa05a038b>] snd_pcm_open+0x18b/0x280 [snd_pc=
m]
[   49.742812]        [<ffffffffa05a04ec>] snd_pcm_playback_open+0x2c/0x40 =
[snd_pcm]
[   49.742822]        [<ffffffffa039f7fc>] __snd_open+0x14c/0x270 [snd]
[   49.742832]        [<ffffffffa039f947>] snd_open+0x27/0x40 [snd]
[   49.742841]        [<ffffffff802dcd47>] chrdev_open+0x137/0x210
[   49.742846]        [<ffffffff802d7a5a>] __dentry_open+0x10a/0x340
[   49.742850]        [<ffffffff802d7d97>] nameidata_to_filp+0x57/0x70
[   49.742855]        [<ffffffff802e69de>] do_filp_open+0x1fe/0x970
[   49.742860]        [<ffffffff802d7868>] do_sys_open+0x78/0x110
[   49.742864]        [<ffffffff802d792b>] sys_open+0x1b/0x20
[   49.742869]        [<ffffffff8020bd1b>] system_call_fastpath+0x16/0x1b
[   49.742874]        [<ffffffffffffffff>] 0xffffffffffffffff
[   49.742882]=20
[   49.742883] -> #0 (&pcm->open_mutex){--..}:
[   49.742889]        [<ffffffff802730c7>] check_prev_add+0x57/0x770
[   49.742893]        [<ffffffff80273de6>] validate_chain+0x606/0x6c0
[   49.742897]        [<ffffffff802742df>] __lock_acquire+0x43f/0xa10
[   49.742902]        [<ffffffff80274941>] lock_acquire+0x91/0xc0
[   49.742906]        [<ffffffff805ac5fc>] mutex_lock_nested+0xec/0x380
[   49.742911]        [<ffffffffa059f86e>] snd_pcm_release+0x3e/0xb0 [snd_p=
cm]
[   49.742921]        [<ffffffff802dae20>] __fput+0xd0/0x1e0
[   49.742926]        [<ffffffff802daf4d>] fput+0x1d/0x30
[   49.742931]        [<ffffffff802c377a>] remove_vma+0x4a/0x80
[   49.742936]        [<ffffffff802c49b2>] do_munmap+0x342/0x390
[   49.742940]        [<ffffffff802c4a50>] sys_munmap+0x50/0x80
[   49.742944]        [<ffffffff8020bd1b>] system_call_fastpath+0x16/0x1b
[   49.742949]        [<ffffffffffffffff>] 0xffffffffffffffff
[   49.742954]=20
[   49.742954] other info that might help us debug this:
[   49.742955]=20
[   49.742958] 1 lock held by pulseaudio/3550:
[   49.742961]  #0:  (&mm->mmap_sem){----}, at: [<ffffffff802c4a42>] sys_mu=
nmap+0x42/0x80
[   49.742969]=20
[   49.742970] stack backtrace:
[   49.742973] Pid: 3550, comm: pulseaudio Not tainted 2.6.29-rc1-wl-11361-=
g269245b-dirty #15
[   49.742976] Call Trace:
[   49.742981]  [<ffffffff80272b70>] print_circular_bug_tail+0xe0/0xf0
[   49.742985]  [<ffffffff802730c7>] check_prev_add+0x57/0x770
[   49.742991]  [<ffffffff8026f414>] ? get_lock_stats+0x34/0x70
[   49.742995]  [<ffffffff80273de6>] validate_chain+0x606/0x6c0
[   49.742998]  [<ffffffff802742df>] __lock_acquire+0x43f/0xa10
[   49.743002]  [<ffffffff80274941>] lock_acquire+0x91/0xc0
[   49.743012]  [<ffffffffa059f86e>] ? snd_pcm_release+0x3e/0xb0 [snd_pcm]
[   49.743017]  [<ffffffff805ac5fc>] mutex_lock_nested+0xec/0x380
[   49.743027]  [<ffffffffa059f86e>] ? snd_pcm_release+0x3e/0xb0 [snd_pcm]
[   49.743036]  [<ffffffffa059f86e>] ? snd_pcm_release+0x3e/0xb0 [snd_pcm]
[   49.743046]  [<ffffffffa059f86e>] snd_pcm_release+0x3e/0xb0 [snd_pcm]
[   49.743051]  [<ffffffff802dae20>] __fput+0xd0/0x1e0
[   49.743055]  [<ffffffff802daf4d>] fput+0x1d/0x30
[   49.743059]  [<ffffffff802c377a>] remove_vma+0x4a/0x80
[   49.743063]  [<ffffffff802c49b2>] do_munmap+0x342/0x390
[   49.743067]  [<ffffffff802c4a50>] sys_munmap+0x50/0x80
[   49.743071]  [<ffffffff8020bd1b>] system_call_fastpath+0x16/0x1b


Incidentally, sound doesn't work on my macbook5,1, I get lots of
controls but no output.

johannes

--=-M2aiWDW31KMjGcNlcjm2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJbMkHAAoJEKVg1VMiehFYncoP/1K+5jDUVjl8HwR5SyTLFr66
QCHEcHE6rz9/UU/JnffPVJ9NaRZORFlagWFqPAikPAUbo11Olvi2Au/qmbWmSF3K
Pll2ArLOVToNY0PacIlwkPuso7tr0G7h2YPUP51ikUBNodNRVZ8VBubAUVvqHPge
jZKifaqX2LK8fDgFZ+BHh6JsgU7xQ06gOkc040DkylAIyqTWs2OBJgsSuGl3SsCG
3a31BxmWs/qODlhAGnyVhsWAFU5K529Iy07WOl4LScCnGbYm1SnO3upl9Xa1TORz
D7UKp0cAq2f0VCrXM8SoysamGeC/h2UMGtGevgvMtmasrY1k2M7/O8tLtKxLSxG1
d+5bNqVBBBrCqmG4/nm1JOv6aQZzBe3GqO+xkQx6eqUuQQfanij89dMFUa8cO40e
AjCarg+GMt+Lnz6L2XUt4grjH9VPjUflRu5Fq0JQvVyC+biG1U0TV9vPzKiqLboU
21BVqyVMbiupzCRNEdd+dEDvi+CYjTC8+tjRXdVrvo3DrJ2K2VeVkFItXgUhYOaq
0Q5h9WyiRtthxGOE2UhzQsh1slc8rOJhrbRmsGsnPA4Xh5RhN9d0qR+1ecv6vskt
Pe8tl9IFeGcDK/dIJ3RkdBHcsv2Aou0GAx9gcKFED6I5NyHseCdzoMdVeiPCchuQ
R/5aduVIgLRCd6FLf0Lo
=P4Pm
-----END PGP SIGNATURE-----

--=-M2aiWDW31KMjGcNlcjm2--


--===============3338970215158567465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3338970215158567465==--
