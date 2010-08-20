From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] Add support for tlv320aic3007
	to	tlv320aic3x codec.
Date: Fri, 20 Aug 2010 16:02:11 +0100
Message-ID: <20100820150211.GB21965@sirena.org.uk>
References: <1282279673-27319-1-git-send-email-rchung42@gmail.com>
	<20100820110840.GF13668@rakim.wolfsonmicro.main>
	<AANLkTi=O=6WSje5dxytsO+EG6T2ksnyqw42PvZs12Kav@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F8F21038E3
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 17:02:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=O=6WSje5dxytsO+EG6T2ksnyqw42PvZs12Kav@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randolph Chung <rchung42@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 20, 2010 at 10:58:20PM +0800, Randolph Chung wrote:
> > The more idiomatic way to write this stuff is:

> > ? ? ? ?{ "tlv320aic3007", AIC3X_MODEL_3007 }

> > and then look at the id field in the probe() function. ?Could you send a
> > followup patch doing that, please?

> The second field in that struct is normally the i2c address, so this
> seems a bit confusing...

Are you sure about that?  The definition of that struct is:

struct i2c_device_id {
	char name[I2C_NAME_SIZE];
	kernel_ulong_t driver_data	/* Data private to the driver */
			__attribute__((aligned(sizeof(kernel_ulong_t))));
};
