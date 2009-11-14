From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Revised Patches for Samsung SoC PCM Controller
	driver
Date: Sat, 14 Nov 2009 12:35:50 +0000
Message-ID: <CDC939BA-3F2C-46AE-AFC6-3CB38801D42E@opensource.wolfsonmicro.com>
References: <1257914690-4357-1-git-send-email-jassi.brar@samsung.com>
	<1b68c6790911140421l1950a02fy8faeff898d2a7f00@mail.gmail.com>
	(sfid-20091114_122144_500187_FE3997C9)
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7AD424379
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2009 13:35:42 +0100 (CET)
In-Reply-To: <1b68c6790911140421l1950a02fy8faeff898d2a7f00@mail.gmail.com>
	(sfid-20091114_122144_500187_FE3997C9)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 14 Nov 2009, at 12:21, jassi brar <jassisinghbrar@gmail.com> wrote:

> At the risk of being taken as impatient, i would like to bring up this
> patch series
> to the notice of everyone. Thanks.

Please don't top post. In general if you're nagging people it's best  
to leave at least a week or two unless you have reason to expect a  
faster response or things are particulalrly urgent (critical bug fixes  
for example).

As I have already said this is fine from an ASoC point of view but  
since it also has arch/arm parts it also needs Ben to review it. Since  
Ben does most this work in his spare time you're probably best making  
sure there's been at least one weekend free for him.

> On Wed, Nov 11, 2009 at 1:44 PM, Jassi Brar <jassi.brar@samsung.com>  
> wrote:
>> Hello,
>>
>>  (I have made a few modifications suggested for previous set of  
>> patches)
>>
>> Samsung SoCs S3C2450, S3C64XX and later versions have got PCM  
>> controllers
>> which drive what the ALSA stack terms DSP_A/DSP_B formats.
>>
>> Since the S3C ALSA platform driver was named s3c24xx-pcm, which cause
>> direct namespace clash with the new PCM controller drivers, it has  
>> been
>> renamed along with some of its local symbols.
>>
>> First two of the following series of patches does that and later ones
>> make ground for and add the PCM controller driver.
>>
>> regards.
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
