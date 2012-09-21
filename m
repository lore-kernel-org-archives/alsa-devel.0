From: Julien Danjou <julien@danjou.info>
Subject: Re: Constant noise on HDA ALC275
Date: Fri, 21 Sep 2012 15:14:35 +0200
Message-ID: <87pq5fiklg.fsf@dex.adm.naquadah.org>
References: <87obl7bg02.fsf@dex.adm.naquadah.org>
 <s5h4nmrbln3.wl%tiwai@suse.de> <87wqznim1k.fsf@dex.adm.naquadah.org>
 <s5hzk4ja5hz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3855321938500147077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.naquadah.org (prometheus.naquadah.org [212.85.154.174])
 by alsa0.perex.cz (Postfix) with ESMTP id B6788265D12
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 15:15:12 +0200 (CEST)
In-Reply-To: <s5hzk4ja5hz.wl%tiwai@suse.de> (Takashi Iwai's message of "Fri,
 21 Sep 2012 15:07:52 +0200")
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============3855321938500147077==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21 2012, Takashi Iwai wrote:

> But my question was: if you plug to an external mic jack and leave the
> headphone jack, the speaker noise is still there, right?

Oh. If I understand correctly you're talking about 2 jacks, but there's
only one jack on this laptop, doing both mic and speaker.

> Turning EAPD on/off on node 0x14 makes difference?

Yes, turning it off makes the noise disappear. But I can't hear
anything, e.g. playing music makes no sound unless I turn it back on. :)

(note that this may be obvious to you, but I don't understand what's
EAPD on 0x14 so I'm just explaining what I hear ;-)

=2D-=20
Julien Danjou
// Free Software hacker & freelance
// http://julien.danjou.info

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQXGg7AAoJEGEbqVCLeKXCvhQQAJEpQj6vXOMOPzngJnLYX2k1
IqqEA7YT/j5VKy93MnQpUkO4TFppQExls484Nf/i920pw9NTSD7gNHlHCYYiWRrp
jxML4IBkfs4OhG4yIVTcCuulEgEMjb1vTJ3CAiK/JGNM8RQWTDZg+HqM0wCkTSCU
C0hmO8MQDv93Vmx2EbCPaiGjevtmBWQs2h9f20lqVSjxeu/4qiIHLCvbu7pHc3sL
x6nEBKcr589RE82srIwybr3xtyGafzqXcmk7LMFsnYnDN9mJ28Ysmu/2GOMxMx5D
iwPbDw4B9XDIMXZfE2/r9iG15DUhwf1HyqlougekdO5GC9+yEQeilxqY20vzIgaP
SvWlBjlP4BrhdBA2r9EhKvmHTyI3n7hAVeTSp/0f3pOZo/ooAsUmhKUHbCD+IMat
bRAMYUpXcZROCH1LOCw4Wq0h9xLpuoNFcxvI0B5CEez5sotFtZICV2hf0aevMhJO
jpa3OaMX8zFY3O6ifPqEjGnKT4VN6BJgPbtRwfQz3OXXwPGMG6n6iZ1+Hm/emaTe
PRqZA0bkArZppRmK7AIrEwKRTqKSi+o0mdSLtVLrHlzfzDIjT+E3VS9eYc2aBOP/
XcKPpOmXIeIYzB30Ir4GBeasRKkdp3W1Bcixl3bwvcKmw9s34gRMdyE0QWMzxKTC
aEPt4sWblaR9KI0B6ZCZ
=CIdI
-----END PGP SIGNATURE-----
--=-=-=--

--===============3855321938500147077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3855321938500147077==--
