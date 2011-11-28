From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/7] ASoC: AD193X: Make enum items const
	char * const
Date: Mon, 28 Nov 2011 20:01:38 +0100
Message-ID: <4ED3DA92.6050704@metafoo.de>
References: <1322497692-27868-1-git-send-email-lars@metafoo.de>
	<1322497692-27868-3-git-send-email-lars@metafoo.de>
	<20111128185345.GA1586@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 89FEA103975
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 20:02:10 +0100 (CET)
In-Reply-To: <20111128185345.GA1586@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 11/28/2011 07:53 PM, Mark Brown wrote:
> On Mon, Nov 28, 2011 at 05:28:08PM +0100, Lars-Peter Clausen wrote:
> 
>> -static const char *ad193x_deemp[] = {"None", "48kHz", "44.1kHz", "32kHz"};
>> +static const char * const ad193x_deemp[] = {"None", "48kHz", "44.1kHz", "32kHz"};
> 
> Ideally this would be converted to a switch and the driver would
> automatically select the rate based on the current sample rate.

Ideally yes, but I'm not sure if this couldn't break some existing setup if it
expects to find that control.

- Lars
