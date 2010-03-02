From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Subject: Re: No CD mixer on Intel G35 (Asus P5E-V(M))
Date: Tue, 2 Mar 2010 20:28:22 +0100
Message-ID: <20100302192821.GA13878@darkside.12.kls.lan>
References: <20100228193128.GA14556@darkside.12.kls.lan>
	<1267532490.12737.20.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4929562826505318313=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from piggy.rz.tu-ilmenau.de (piggy.rz.tu-ilmenau.de [141.24.4.8])
	by alsa0.perex.cz (Postfix) with ESMTP id E768810380F
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 20:28:25 +0100 (CET)
Received: from gate.12.kls.lan (vpn85.rz.tu-ilmenau.de [141.24.172.85])
	by piggy.rz.tu-ilmenau.de (8.13.7/8.13.7/Debian-2) with ESMTP id
	o22JSKjO030855
	for <alsa-devel@alsa-project.org>; Tue, 2 Mar 2010 20:28:22 +0100
Received: from darkside.12.kls.lan (root@darkside.12.kls.lan
	[IPv6:2001:6f8:90c:12:21e:8cff:fecf:cfad])
	by gate.12.kls.lan (8.14.3/8.14.3) with ESMTP id o22JSMPp022365
	for <alsa-devel@alsa-project.org>; Tue, 2 Mar 2010 20:28:22 +0100
Received: from darkside.12.kls.lan (holbe@localhost [IPv6:::1])
	by darkside.12.kls.lan (8.14.3/8.14.3) with ESMTP id o22JSM6I018513
	for <alsa-devel@alsa-project.org>; Tue, 2 Mar 2010 20:28:22 +0100
Received: (from holbe@localhost)
	by darkside.12.kls.lan (8.14.3/8.14.3) id o22JSMBl018512
	for alsa-devel@alsa-project.org; Tue, 2 Mar 2010 20:28:22 +0100
In-Reply-To: <1267532490.12737.20.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4929562826505318313==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline


--jho1yZJdad60DJr+
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02, 2010 at 01:21:30PM +0100, Paul Menzel wrote:
> I think the developers like to have the output of `alsa-info.sh` [1][2].

Thanks very much for your hints.
Output of `alsa-info.sh' is attached.

> 1. Did ALSA ever detected the CD mixer on this board?

Hmmm, I found an asound.state in a very old backup (Jun 2009) which
suggests it was once there. In the next backup (Aug 2009) it seems gone.
I'm quite sure it was the same board like now (I had no other board with
Intel HDA at this time). Unfortunately I cannot find out which kernel
did run at this time. I tried old kernels from around this time but did
not succeed. I also tried to downgrade the BIOS to the one around this
time, no success either.
Maybe somebody is able to deduce something more out of the asound.state
files.

> 2. Did you try all different model parameters [2]? If not and it does
> not work please also attach sanely named files with the output of
> `alsa-info.sh`.

Aaaah, `modprobe snd-hda-intel model=3Dasus-p5q' does the trick. CD mixer
is there, playing a CD gives sound and the rest seems to still work too.
This model gave some other new controls (Output: Channel Mode Switch:
6/8ch and Input: S/PDIF), I don't know how to test these. It did not
remove any controls.

I assume it would be safe to autodetect `P5E-V HDMI' and `P5E-VM HDMI'
to model=3Dasus-p5q.
There are two other models in the P5E-V* series: `P5E-VM DO', and
`P5E-VM SE'. I don't really know them, but according to their manual
they all seem to have the same Intel G35 chipset, the same Realtek
ALC883 codec and a CD audio in connector.

> 3. Have you tried to build the modules yourself from Git head [1]?

Nope, I didn't :)


thanks again & regards
   Mario
--=20
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--OgqxwSJOaUobr8KG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="alsa-info.txt.gz"
Content-Transfer-Encoding: base64

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
gcCOAAA=

--OgqxwSJOaUobr8KG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="asound.state.2009-06-26.gz"
Content-Transfer-Encoding: base64

H4sICCgjRUoAA2Fzb3VuZC5zdGF0ZS4yMDA5LTA2LTI2AO1ay27iMBRdD1/hXVZl4oQUuiwh
zCCVtmqZarZucKZRg4Mcpw+N+u8TQjrYeYFDXFBVbyob6pxzz/V9OEQMMdydEIYD8LfzzQ0J
o2HQhatJMlssMGFd5Lo4ioBGMZqDZ+ozrHGfstclBpPLmfPDueGW3TAmDBjcCkXkDwaaDk6A
Cfkd5vcLn4CT3qmli6voBaxWfA+5GEwnv9MHELRIdhnTBCq4DtDrPXIfwV0YxIsU1hMKYtzV
gWH+n8B08rahZ8jSG15dXTjnl6X0dkB3++wz94FHx2iMOXzrKYfQPHoBbmNKkyfM6zTQOYq6
wK+nWoEivKIIHgoiXoVszsG02pIBqpLBTr6CaaUIObOfHj2fi7GzK5l+Wz4Ed7RtzoNK/GWg
GpJgnu14zo4/jPhz3CyEQF15DBGwNYkfUDqRymL8mWy1fAjJvkClU2IbnmL2SjwFGnqVs0x9
t6GvSOdTWR0EaI0UkE6Jh1BgXdg010E6oTarvPZXo7VMqVKNC5/UBs+6Ghi2lj6rpBDRydfA
UDqbHkIDe9RYAensLKsAj03e/oZ0gpW1f9H8RdObem06GIZhxHYLPobyrnZPPpvYJcNKeTNr
oyWLKW7iQcrTbhGbT+b4Ja2fd0Z5kMybhZScc6yDTx3TYozpc+T6IrPW+tePZVbUsMb/pTO1
c/lr6tycz5xRgSbf1ib/ukienBzH/CLkjqqW/9AAq7yXXzWBPaqgPyHLmIHbMKYu1+quN+F5
SufrI+eZE3kNgCdcmv5XfAtO69hn1qCUZCmQ9OubzGiHBExR9LgxvqZ7nqd/DWVDE5UuLYQU
KH1Nw6LSh7bF5x6i0qZ8Sbmf4iPsoThgvOC9Q5vkc4+c4K1dgO2q+PZLUbO1inkLpsz5wLU9
lcLXWtW8BV9FYV8GqbREbi9CvyP5Oq4fPXLH9SANg+yVyxDjZdNLF1O6XZBtSUV0DV79Shf6
H/6SLqmhal86mlBkpPy1WB5QPqIVjbzt7g3EEab7erthWcIWwVOyvh4w+ztIOg0PuzALc7BX
oo0FSxrqKm2EZFNyNiyLPxyr2VvnrROlvwMZskF/oOR3IBWuCFP7SFx35Jt/5a+AMxjihVxZ
hlTbnWuzOzCLieiSWZM+nhZ786SZ/p7157XXZrlbB/4xK7f4B90JFT8fJAAA

--OgqxwSJOaUobr8KG
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="asound.state.2009-08-21.gz"
Content-Transfer-Encoding: base64

H4sICIrdjkoAA2Fzb3VuZC5zdGF0ZS4yMDA5LTA4LTIxAO1aXXOiMBR93v6KvPFUl4BW+1gt
3XWmtJ3W7exrimHLFMGB0I/Z6X9fRKbmCzRIFqfTvDiJCufkXHJPbkgJIrg3jQgOwd+jb14c
kSQOe3DVyXuLBY5ID3keTlNgJBjNwUsSEGxQ35K3JQbTq5nzw7mlhr04iwiwqJEERX8wMExw
DGxIX2H+sAgicNw/GZjsKHoFq5HARx4G7vR3cYMILfKrXCQ5VHATorcH5D2B+zjMFgWsZxRm
uGcCy/7owKLzvqFnqdIbX19fOmdXUno7oLt7CYj3SKMjSYYpfOsuhdA+eAHusiTJ7zCv08Ck
KJoMv75uBUR4ogg+ClNahbJPwRy0JQPUJcMk/wlOKkXgpv3k4PlcXji7khm2FUNwx7nlIkgS
LyPdkJjp2Y7n9PCXkWCOmy0h0NS+hjDYmqwfUDmRqmL8mV9q+RhH+wJVToltRIrdl0QKtMyq
YHEDr2GsKOdTVR0YaI0UUE6JXSiwNjbNdVBOqM2c1/5qtJYpdapxGUS1i2edB4atpc8qKVh0
6h4YKmdTVQ1ECcTpt83a5WgcxynZMfi1Z+M9+WyeHQVWlvY0PEFLkiW4QQRZ2tOviC2I5vi1
8G87o+wk95bLChcc6wWojqm4ygwpckOWWSfb2P2ZiRrWxL9y3naufrnO7dnMORdo0tuq/K+L
/M7548gPQupRNfgvLbBadyuoTqNlRsBdnCUeta1a/4HmpJymD4gTJ976ZjQ5aWpfcROC0Zmc
DkZSQlIgxc83GW8SR8BF6dNmog3T933zq2lrBqu01OJoUPomiUWlu56Lz904pdWt4n6Kn2Mf
ZSGhBe93PSWfu3GCK3tp1Uobr/j2YpvdmhPegqkMPnAzcZXwdXKqo7qnHWO8bLqntbUf7LDo
GpzrtOaItVXg80RWe6JgQ5ZRa0c5VVHPA+IjXZxkqX3V7PB42/nl9TQ3NiHY/8vV015PonnX
s/K5G6e5cgmzPdcnSv/l/7Q2TnrtJ63V/o+XXuK0trlTkKU42dduWYMBc4nwOR9fN1h+jvIc
5GMPlrEJ+xJzMICSclmVOWAsp2jO4OiUcj9F7/3o/Sgt3jIak9FwpOUtowovBIv5UShm8qU9
7S8YlDDYcrssoPTW44zZPZhlERuSZVnuwhWrcW7gfa+pyH0Uxbk6I32bVVj8AySInMB9JgAA

--OgqxwSJOaUobr8KG--

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEVAwUBS41m1RS+e2HeSPbpAQLhnwgAnYz9vkVFPWWzNCGqa5jibqAoADk1o/OA
X57Nty/MazYz0XAEdR3LFkXKYyjAG8O0GDoyadb/DkHGKQXxwnLVBCYoU4VkF4Go
zmIYaWbFWkGDq8k5c9FaRr3ZrxIDUSkVBiePfJaFRPa15sit3A5mOn9r5S6MM1uj
tTrIynNI7X7QlROQsaaymJfvKCweAGCZf+jdqx6QlrBrjFnZJc3OkxorDrTTmO02
//sp8qPjvYLTJvsrd7qFYOO/M0taNy0Zx5E3KVtlVt2TuYv3AcXHSlDyZZoNV5zJ
8ueOoq3dHS5UD2MCQvjzUMWBFUxhpTimAY+9YkBYnnr0TbVQ+jNIaQ==
=xR0N
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--

--===============4929562826505318313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4929562826505318313==--
