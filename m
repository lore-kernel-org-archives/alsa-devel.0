From: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Wed, 23 Aug 2017 18:35:24 -0400
Message-ID: <20170823223524.GW17193@bill-the-cat>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
 <20170823092828.7ijy7rthvqkzcgtz@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gkEBo/XPSfx+3zOU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170823092828.7ijy7rthvqkzcgtz@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--gkEBo/XPSfx+3zOU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[stupid google spam filtered _this_ as spam, I don't know why]

On Wed, Aug 23, 2017 at 10:28:28AM +0100, Mark Brown wrote:
> On Tue, Aug 22, 2017 at 09:51:46PM -0400, Tom Rini wrote:
>=20
> > Not all devices with ACPI and this combination of sound devices will
> > have the required information provided via ACPI.  Reintroduce the I2C
> > device ID to restore sound functionality on on the Chromebook 'Samus'
> > model.
>=20
> >  	{ "rt5677", RT5677 },
> >  	{ "rt5676", RT5676 },
> > +	{ "RT5677CE:00", RT5677 },
> >  	{ }
> >  };
>=20
> You're going to have to provide a clearer changelog here, that's
> obviously an ACPI ID...

After looking at 89128534f925 (which introduced the above line, and thus
support for the Chromebook), I think that 36afb0ab648 and 55e59aa0525a
are wrong and should be reverted.  It seems like they're an attempt to
make 89128534f925 be done 'properly' but it also seems like the
Chromebook is the only platform in question that triggers that code and
it results in a NULL pointer dereference, so it's a regression on the
only platform that makes use of the code paths in question.  I'd also be
happy to try a patch on top of master to see if that resolves things.
The oops in question looks like:
BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
IP: rt5677_i2c_probe+0x4a/0x730 [snd_soc_rt5677]
PGD 0=20
P4D 0=20

Oops: 0000 [#1] SMP
Modules linked in: snd_soc_rt5677(+) btusb(+) btrtl iwlwifi(+) snd_soc_rl62=
31 btbcm snd_
CPU: 1 PID: 403 Comm: systemd-udevd Not tainted 4.12.0-rc1ph+ #119
Hardware name: GOOGLE Samus, BIOS          04/02/2015
task: ffff947de8ca1cc0 task.stack: ffffaf5641fe0000
RIP: 0010:rt5677_i2c_probe+0x4a/0x730 [snd_soc_rt5677]
RSP: 0000:ffffaf5641fe3b30 EFLAGS: 00010246
RAX: ffff947de8e02618 RBX: ffff947de8e02618 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000286 RDI: ffff947dec7ece98
RBP: ffffaf5641fe3b68 R08: ffff947dfec9bda0 R09: ffff947de8e02600
R10: ffff947dfec9bd20 R11: ffffd7ef91a12180 R12: ffff947dec7ecc20
R13: ffff947dec7ecc00 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f9bd7fdb8c0(0000) GS:ffff947dfec80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000018 CR3: 000000046872b000 CR4: 00000000003406e0
Call Trace:
 ? acpi_dev_pm_attach+0xa4/0xe0
 ? rt5677_to_irq+0xe0/0xe0 [snd_soc_rt5677]
 i2c_device_probe+0x17c/0x230
 driver_probe_device+0x2a1/0x460
 __driver_attach+0xd8/0xe0
 ? driver_probe_device+0x460/0x460
 bus_for_each_dev+0x58/0x90
 driver_attach+0x19/0x20
 bus_add_driver+0x40/0x270
 driver_register+0x5b/0xe0
 i2c_register_driver+0x3b/0x80
 ? 0xffffffffc072b000
 rt5677_i2c_driver_init+0x17/0x1000 [snd_soc_rt5677]
 do_one_initcall+0x4c/0x1a0
 ? kmem_cache_alloc+0xf7/0x150
 do_init_module+0x56/0x1e8
 load_module+0x1f54/0x2710
 ? symbol_put_addr+0x30/0x30
 SyS_finit_module+0x96/0xd0
 do_syscall_64+0x4e/0xb0
 entry_SYSCALL64_slow_path+0x25/0x25

--=20
Tom

--gkEBo/XPSfx+3zOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZngMrAAoJEIf59jXTHXZSGM8P/2N8zdel8jK6zzkkAqAYGKmM
mSqz+ruzoQr0ZG5cdZ8P34ILv8eA4JHuR8I3VWBfdczAjhdRMkkqd3BoKiHwcL1b
3jSBDATQoXh1IC94Vxee0uO88qinDrQiEdMR21R60NLqqaNcnDtBRCmSGtHaik5u
97BR/UuXh7IVaGHSb8jBYocLsuBLczhpcqQR6KY3n/VPMeCtO5BaOPSQRFMbYCEq
eoqVgO5W0eHb99uI/Pag+ohF5vkyYC57tqv8bd8mE2PtuQO19BzHv/u3xCdd5lNU
fdeUfPdth9ttZBb8NVLS4k0UIG/bJKWVFh5BIkxHUcafRU1RW4niIVojDUPXnnc4
SJgIWEegfbIOxDSRbi7txGjv8/hjinMwH2XZQqBcZt6V7TW73l1JtgBUPkLJh3Hz
EzCvScU6jN0CvEIZGCAve3RdrtfjJsTbwIk3p6ZBTEbsrnRcsCALwG3Qj1JsNbxi
ddl/VRpKnltZLlsEUxLbNCYgj9g7LyibEdZz2IgRNyAMf87lUOqIk4E6kmaE3Hvf
0bl/TXRIO+4d6mvKXHHPXhUhRqs6VMc3g8lsi4Zjx42lzo9LNSTaY+vpKteHa/Ia
IhvDcuHs1ywRCr4B9pwATuqi//kSJ44RG7rOqAI9HF1er17JCzuio+dsnqpA6/8H
qWG6Z4eIyxiJBDMygPH8
=gK6A
-----END PGP SIGNATURE-----

--gkEBo/XPSfx+3zOU--
