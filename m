From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] ak4642: show error if register write fails
Date: Tue, 11 Mar 2014 11:18:30 +0000
Message-ID: <531EF106.3020809@codethink.co.uk>
References: <1394475355-7069-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140310234038.GE28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ducie-dc1.codethink.co.uk (unknown [185.25.241.215])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E1042616F3
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 12:19:02 +0100 (CET)
In-Reply-To: <20140310234038.GE28112@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On 10/03/14 23:40, Mark Brown wrote:
> On Mon, Mar 10, 2014 at 06:15:55PM +0000, Ben Dooks wrote:
>
>> +/* wrapper functions to show any errors to updating register values */
>> +
>> +static inline int ak4642_update_bits(struct snd_soc_codec *codec,
>> +				     unsigned int reg,
>> +				     unsigned int mask, unsigned int val)
>> +{
>> +	int ret = snd_soc_update_bits(codec, reg, mask, val);
>> +
>> +	if (ret < 0) {
>> +		pr_info("%s: error %d writing %04x (%08x, mask %08x)\n",
>> +			codec->name, ret, reg, mask, val);
>
> Two things here.  One is that this should be a dev_err() and the other
> is that if this is worth doing shouldn't it just be in the core - I see
> nothing driver specific here?

Sorry, didn't see a device in "struct snd_soc_codec *codec" so I went
for a printk (although it was pr_info instead of pr_err).

I did think if this should be something in the snd_soc_update_bits
and snd_soc_write() calls after sending the patch.

If you think that changing the two snd_soc calls to print errors
when anything bad happens then that would also be a good idea then
I can send a patch for that.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
