From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] ASoC: fsl_asrc: protect macro argument
Date: Wed, 06 Dec 2017 16:03:24 +0100
Message-ID: <a79ecfeb4b74ba18fe839d53e0f874f8@agner.ch>
References: <20170807063657.12581-1-stefan@agner.ch>
 <20170807070806.GA8208@Asurada> <b96fa8a745e7d6e9de8bb70d0f335648@agner.ch>
 <20171206141155.ytdmashkum3ujpvk@sirena.org.uk>
 <450504e854cf68efff7f212c6bd66fe2@agner.ch>
 <20171206143950.irihxu25xg7jut4e@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 45F17267953
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 16:08:12 +0100 (CET)
In-Reply-To: <20171206143950.irihxu25xg7jut4e@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, timur@tabi.org, Nicolin Chen <nicoleotsuka@gmail.com>, fabio.estevam@nxp.com
List-Id: alsa-devel@alsa-project.org

On 2017-12-06 15:39, Mark Brown wrote:
> On Wed, Dec 06, 2017 at 03:25:37PM +0100, Stefan Agner wrote:
>> On 2017-12-06 15:11, Mark Brown wrote:
> 
[...]
>> I did not meant to bug people, just wanted to make sure the patch does
>> not falls through the cracks... After all, patch as well as the Ack
>> already more than 3 months old....
> 
> You need to send patches to the relevant maintainers as covered in
> SubmittingPatches, if you don't send us patches we won't have them and
> can't apply them.

Yeah this is where it gets a bit fuzzy around the affected file, there
are maintainers mentioned in the MAINTAINER file but I just realized
today that it was typically you which merged patches for the file.

Will resend the patch and add you as recipient.

--
Stefan
