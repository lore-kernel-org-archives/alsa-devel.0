From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Fri, 02 Nov 2012 12:29:40 +0100
Message-ID: <874nl89ra3.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5hmx0ja08z.wl%tiwai@suse.de> <874nmried6.fsf@dex.adm.naquadah.org>
 <s5hfw6bpen9.wl%tiwai@suse.de> <87vcf7gyl5.fsf@dex.adm.naquadah.org>
 <s5h6277pdfi.wl%tiwai@suse.de> <87r4pvgxvx.fsf@dex.adm.naquadah.org>
 <87r4pepcgo.fsf@dex.adm.naquadah.org> <s5h1uh9jfxq.wl%tiwai@suse.de>
 <87zk3xku73.fsf@dex.adm.naquadah.org> <s5hwqz1i0y0.wl%tiwai@suse.de>
 <87fw5pktos.fsf@dex.adm.naquadah.org> <s5hr4p9hzw0.wl%tiwai@suse.de>
 <87ehl96ifc.fsf@dex.adm.naquadah.org> <s5h7gr1gc7o.wl%tiwai@suse.de>
 <87ehl86h4l.fsf@dex.adm.naquadah.org> <s5hvcek7oh7.wl%tiwai@suse.de>
 <87zk3wity4.fsf@dex.adm.naquadah.org> <5073C20C.2080603@canonical.com>
 <87fw4t9ccn.fsf@dex.adm.naquadah.org> <s5hvcdos7qn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3041671087111389501=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id E36CC265005
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 12:29:43 +0100 (CET)
In-Reply-To: <s5hvcdos7qn.wl%tiwai@suse.de> (Takashi Iwai's message of "Fri,
 02 Nov 2012 09:56:48 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

--===============3041671087111389501==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02 2012, Takashi Iwai wrote:

>> I just did that using the hda-analyzer tool. I changed 0x14 to uses 0x0c
>> as a source, and it's indeed much better. The noise disappear when
>> neither master or speaker is muted, and actually the music playback
>> sounds better and without the little background noise I still hear on
>> low volume level.
>
> Good to hear.  What's the remaining issue?

Well, it's still not perfect, and as I wrote, if any of "master" or
"speaker" is muted, the noise kicks back in instantly. :(

> The current parser prefers the line-out as the primary output over the
> headphone.  Then it tries to assign from the smaller NID, so 0x0c is
> assigned to the line-out (which is the speaker in your case), then
> 0x0d is to the headphone.

Ok, thanks for the explanation.

>> I'm still trying to find a way to fix the noise when speaker or master
>> are muted. No chance so far. :(
>
> Do you mean that the noise is there with rerouting like the above, or
> you are asking for a patch to achieve the rerouting?

If "master" or "speaker" is muted, the noise kicks back in, whatever the
routing is.


At this point, I wonder if it wouldn't be simpler to just boot the
machine under Windows and dump the HDA state to see how the Windows
driver set up all the routing. Do you think this kind of approach would
work, and in that case, is there a tool do achieve that?


=2D-=20
Julien Danjou
# Free Software hacker & freelance
# http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk66kAAoJEGEbqVCLeKXCK6gP/3LZqoL7hi/BouWv+m5oQt27
+JsTdITCYEny1/gEtjBvO2pdaNy1iQQU790HpESVUkHr4nzRzPYF/XaO+Z5pbF5V
jXL4fP3oPkm+m6tIejhbWrKsb5rm8PDPurnaSlGHfxUHfkmcNTF1N4ilgQwYeMVC
YkpmLgIdigfR/sdsFuFCCiL9yd8O1e2eTICKJ0EdjwdgdqJh0F6AjM2fh2MDZ/Fn
ZPXJDASzn51/SfJpYbfgJPjCtoJEZ55rwGku09xBOcs4zYydb0vAOL+gkohwEKCg
NvBdju44nwYmX4WxtFhpK2P7AXeOlRfIS5O9fvSBtgHpYLTtbQNwH8ftsDqkv5C7
GWlX81rkpqEEPS90hLPBT0k3OSPlvmA8Ya0NVBGZ/zsbAUK3TX1gGY+r/SatODF+
f/iS0yUMMVg9wulFgUPBGnuVK8+AstJ32ilchTC4DFbMb/n2EPy/fSWNbdNSwFIA
6xqh9HpxnadXmRR8J6rH+1LemeOaAFSy4JvoWjAO0fg7hic03Kackl0p5+ortZEh
2m7+YCxuHVpKyGjOhW5f955/i9BCYtrzgCLrh4WbQwUi9bRizo4waVeBJSm1NugG
jbH6jU9wEDoCAOGoFIA6lsH3Dkvv7OvRDR/LkMqw086hPW6REmBoRIGkkKG/mJuk
JNVgd1cqUj4D099G6uzT
=OPYY
-----END PGP SIGNATURE-----
--=-=-=--

--===============3041671087111389501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3041671087111389501==--
