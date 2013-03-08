From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
Date: Fri, 8 Mar 2013 15:43:42 +0800
Message-ID: <20130308074325.GB28481@opensource.wolfsonmicro.com>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
 <20130306171333.GR17833@n2100.arm.linux.org.uk>
 <20130307023316.GA22554@opensource.wolfsonmicro.com>
 <20130307091804.GA17833@n2100.arm.linux.org.uk>
 <20130307093117.GB14315@opensource.wolfsonmicro.com>
 <20130307112006.GD17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0941164102025953049=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130307112006.GD17833@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marek.vasut@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Huang Shijie <b32955@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0941164102025953049==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2013 at 11:20:06AM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 07, 2013 at 05:31:23PM +0800, Mark Brown wrote:

> > The bit I'm missing is why this is particularly hard to change, it
> > doesn't seem like a massive refactoring and there's not many users.

> Well, it requires the thing to be reworked along with everyone who uses
> it, specifically snd_dmaengine_pcm_open() and snd_dmaengine_pcm_close().

Oh, OK.  That doesn't seem like a big deal really - it's certainly not a
throw the thing out and start over job.  It sounded like you'd identifed
some new issue you'd not mentioned rather than just the same issue, it
wasn't clear to me that it was the same issue.

> Now, I could use your excuse that you've given me in the past: "I don't
> have much of that hardware so I can't test the changes, so I'm not going
> to touch this code evar again!"  (That's basically what you said about

I'm not particularly asking you to fix this yourself except in that it
seems like it's an important issue for you.  If anything something like
this patch ought to make things marginally easier to deal with by
factoring out a very small bit of the code.

> the AC'97 struct device stuff.)  You can't have it both ways and always
> shovel what you don't like onto other people.

I'm aware of the issue, as are the people who've worked on the code.
Speaking personally I just happen to disagree with you about the urgency
here - it's not like it's the only problem we've got and the practical
effects are limited to a subset of mostly older hardware which generally
doesn't use dmaeengine in the first place.  I imagine that a similar
thing is true for everyone else.

There's plenty of other hardware that doesn't work right now, another
pressing example I can think of is devices that subdivide an audio
interface into multiple unrelated streams of audio, you aren't alone in
having hardware that needs the frameworks improving in order to achieve
basic functionality.

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROZZ6AAoJELSic+t+oim9vOcQAIlp+Rqk5+dvc3cHHu7IvU9F
8hDYSm5KM+OUIqlebNnlxxfdgMmSYQtROqEUHTnJvW4UPNT3gxYyZl7IWpWRQ/vk
6rheQcdVcDoRvSeW1th4WEi2qwBKDS4x2F/Z/A8g3F4BAOBzmf/3QcRkS692MJ7s
nIdtwxXAYlkkRb7bSDR7saBQs8B9KyiA6IMphOGNAAVbWbDTM5/xX5Erqa/uHEts
V74H0qm+ULVCbk0dIYJZobxFBGXNB756qEwWShVXs4VEQ56F6MVdFJ8k6x7PcBnT
1VK3QrZn4Yjh8PHlUSGl5TUFQWtfV1itF4Juwmv/ARrF2PQrenwhY0o8bMOn87Md
XjMmSb9srZqABfEbVER1c2PZ4eYWrmKn4IKKFLbI2yKeyUgabvt64BvOeZw3b+fg
MZl4c34xofcF8/rfwyecEMXxav1Utv2so3AbZygWrI8lijVkhDqmOCgJkWLg9wjU
fJjSD0ZxeLZNNVTXX7OFSnZEWgxm/IRWOkc4kyjggVI7jr1S/0NzT/NpsWSRlKlJ
Z8O/XXFp2ulZcAhdE4VaBVslJACbgHUZjekwCWqFNp629/ogKSpybByq1sc2rGSY
rgQXTnYZTJ60dQHwtuIJnLnJ0BZ0I/II43atQ3S4iX5/Z78/ibo4DjvuHeRKA5X5
w04oRzTIlMPXY/GeIWTU
=BsUM
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--


--===============0941164102025953049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0941164102025953049==--
