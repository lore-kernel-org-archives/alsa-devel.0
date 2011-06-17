From: =?iso-8859-1?Q?Lambrecht_J=FCrgen?= <J.Lambrecht@TELEVIC.com>
Subject: unsigned int 'return -1' in /sound/soc/codecs/tlv320aic23.c
Date: Fri, 17 Jun 2011 14:13:04 +0200
Message-ID: <4DFB44D0.4080306@televic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I see this error in /sound/soc/codecs/tlv320aic23.c:

static inline unsigned int tlv320aic23_read_reg_cache(struct snd_soc_codec
               ^^^^^^^^
                               *codec, unsigned int reg)
{
     u16 *cache =3D codec->reg_cache;
     if (reg >=3D ARRAY_SIZE(tlv320aic23_reg))
         return -1;
                ^^
     return cache[reg];
}

Maybe better return 0?
Best read the codec datasheet to find a safe or non-existing value?
And also a "printk(KERN_ERR " then?
Actually, better just remove the check, because if you want to write a =

codec register, you must know what you are doing?

I am busy with the codec driver for mc13783.
Currently, the mc13783 (from Sascha Hauer) code does not check 'reg'.

(I want to supply a patch finally, but as newbie: from which GIT?, =

because mine is a merge of 2 branches of the Pengutronix GIT)

Regards,
J=FCrgen

-- =

J=FCrgen Lambrecht
R&D Associate
Tel: +32 (0)51 303045    Fax: +32 (0)51 310670
http://www.televic-rail.com
Televic Rail NV - Leo Bekaertlaan 1 - 8870 Izegem - Belgium
Company number 0825.539.581 - RPR Kortrijk
