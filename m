From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: bt-sco: enable OF support
Date: Sun, 11 Aug 2013 12:05:40 +0100
Message-ID: <20130811110540.GW6427@sirena.org.uk>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
 <20130717094718.GE22506@sirena.org.uk>
 <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
 <20130806170430.GL6427@sirena.org.uk>
 <CAGsJ_4xhkdNTKr6KBPMMPVfi7+NP+WHq2+_V545An6J+c6E7ug@mail.gmail.com>
 <20130807144628.GC6427@sirena.org.uk>
 <CAGsJ_4y1JoPtXinAvaohDQF_4+DizNYh1jy+iYymypgeZfapKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3587182675921333318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D532A2616B9
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 13:05:43 +0200 (CEST)
In-Reply-To: <CAGsJ_4y1JoPtXinAvaohDQF_4+DizNYh1jy+iYymypgeZfapKA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Workgroup.Linux@csr.com" <Workgroup.Linux@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============3587182675921333318==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NGFy4aho5lLhScak"
Content-Disposition: inline


--NGFy4aho5lLhScak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2013 at 04:41:57PM +0800, Barry Song wrote:

> it is fine. but it seems we are not easy to achieve this goal as we
> actually want to do that at uart or tty core instead of specific uart
> driver instance.

Yes, this is one of the problems with DT - it forces things to be solved
in a full and complete fashion since it defines ABI.

--NGFy4aho5lLhScak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSB3ABAAoJELSic+t+oim9mOMP/ApAsGeWvHU4FP+wkMPiiCa0
1/QXOmn78DVYSDzjdFWm5gmDbMvDUFUlNwFZyNhMdFRpbo0Y49km+Tiw1gr5ugJs
PVjmB/AR6/fTJK6EiceJ4eWsAGNdZgYMJL8cFQqO6uFkGC1R4IlJWnboX0wchV1R
F6zZ9HPUd4m7ddxrKZLdtONYfEFAf1rn3M6AaE9xxN5ZDRY1assZ3ns5+zN6wED8
N8KyflqMFqWKidJp2+ahCIK9wbs0o1+OXCI+C6ORZknuEi3V5zVl6w+LpzZvtnIs
0uc4jV0YNaYBJXdOpOMDIiTzVmR/WuCOGGFz0i6/z1iXp5/XXaeDmdELWkJiYHDq
dJIKMCe3uNb2IUD+vuw/x0DrPs1EslW04EB1xj49kEf55rNVzbB8DkFaC3xwoLIj
m5oJE1OlTGYW46EoBcT+Mf8lFYnCLDGf1z60M6ScTRH20smYmjgcpQXZMfZDdwyr
TsmlzBrvfAtuGZahHiFbfy8oV8RGbmLyPstqEWCQKOb5+Q0TbhYw8RPfPuFT1LcN
8DAJQC54NJqCUeQ7qodNdOUdPBff/yZF12+1/ayBYiPYxzYRFmQbuJdrF5bvwykA
s8UQn2OjG1S6cMocdX3H2ITqJTkNwKiR0iWYfjgzib8LaeVqKbkwUko2Ww7WXKkY
MAniRHttpeBaOV0cMqGU
=b/mw
-----END PGP SIGNATURE-----

--NGFy4aho5lLhScak--

--===============3587182675921333318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3587182675921333318==--
