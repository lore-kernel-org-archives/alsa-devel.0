From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3] ASoC: davinci-evm: Add AM43xx-EPOS-EVM
	audio support
Date: Mon, 10 Mar 2014 13:31:15 +0200
Message-ID: <531DA283.1020402@ti.com>
References: <5315DF41.1090302@metafoo.de>
 <1393947831-26116-1-git-send-email-jsarha@ti.com>
 <20140305014259.GR13126@sirena.org.uk> <5319BF67.3060403@ti.com>
 <20140309081102.GL28112@sirena.org.uk> <531D98D4.7080806@ti.com>
 <20140310110926.GX28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 53F46265731
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 12:31:19 +0100 (CET)
In-Reply-To: <20140310110926.GX28112@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>
Cc: liam.r.girdwood@linux.intel.com, detheridge@ti.com, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On 03/10/2014 01:09 PM, Mark Brown wrote:
> On Mon, Mar 10, 2014 at 12:49:56PM +0200, Jyri Sarha wrote:
>> On 03/09/2014 10:11 AM, Mark Brown wrote:
> =

>>> No, it shouldn't do any inversion.  If inversion is required one of the
>>> drivers is buggy, they are CODEC bit master and CPU bit master so for a
>>> CPU driver the sense should be inverted when parsing.
> =

>> Yes, that is the problem. The same code in simple-card parses the
>> codec node and cpu-dai node and they produce the same
>> SND_SOC_DAIFMT_C??_C?? flags for both codec and cpu-dai drivers.
> =

> Sorry, thinko above - the master flags are specified in terms of the
> CODEC.  Anything interpreting them that isn't a CODEC needs to be
> inverting the sense.

Exactly, CBM_CFM means that the codec is the master of both clocks. Codec is
configured as master and the cpu side is configured as slave.

But the issue is that with simple card (when you want to have the codec as
master for both clocks):

simple-audio-card,codec {
	sound-dai =3D <&aic3106>;
	bitclock-master;
	frame-master;
};

simple-audio-card,cpu {
	sound-dai =3D <&mcasp1 0>;
};


The codec will get CBM_CFM, however the cpu_dai will end up having CBS_CFS
(since *-master is not specified in the dts).

So when the simple card parses the master/slave configuration it has to inv=
ert
the cpu_dai settings it got back from snd_soc_of_parse_daifmt() to get it r=
ight.

Since:

simple-audio-card,codec {
	sound-dai =3D <&aic3106>;
};

simple-audio-card,cpu {
	sound-dai =3D <&mcasp1 0>;
	bitclock-master;
	frame-master;
};


Will end up as: codec is CBS_CFS and cpu_dai as CBM_CFM which means that bo=
th
cpu and codec is supposed to be slave...

-- =

P=E9ter
