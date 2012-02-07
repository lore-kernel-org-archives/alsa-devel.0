From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Remove even more unused
	code
Date: Tue, 07 Feb 2012 09:00:15 +0200
Message-ID: <4F30CBFF.8060408@bitmer.com>
References: <1328556193-24593-1-git-send-email-broonie@opensource.wolfsonmicro.com>	<20120206192826.GB12326@opensource.wolfsonmicro.com>
	<CAMP44s23-cDE3dVur0zgXLF0J7fjuJmrh5jD_E4zyrySKgYzwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 66499103F45
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 07:59:36 +0100 (CET)
In-Reply-To: <CAMP44s23-cDE3dVur0zgXLF0J7fjuJmrh5jD_E4zyrySKgYzwg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 02/06/2012 10:48 PM, Felipe Contreras wrote:
> On Mon, Feb 6, 2012 at 9:28 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Mon, Feb 06, 2012 at 07:23:13PM +0000, Mark Brown wrote:
>>> Now that we're not implement GPIO or microphone support there's no users
>>> for the read() function any more.
>>
>> That's microphone detect, not plain microphone.
> 
> s/implement/implementing?
> 
You can have my ack here (I'd have acked Felipe's earlier cleanup too
but noticed them only now). Support for gpio and detection were added
almost 4 years ago according to log without seeing any users in mainline
since then.

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
