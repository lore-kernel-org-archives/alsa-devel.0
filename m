From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V2 1/9] sound:asoc: Add support for spdif
	in Audio Codec
Date: Fri, 22 Jun 2012 15:14:27 +0530
Message-ID: <4FE43E7B.5030307@st.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<4293b6815ad92e19fe8791262cdec8e68f365ddb.1340273261.git.rajeev-dlh.kumar@st.com>
	<20120622092129.GH4037@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog119.obsmtp.com (eu1sys200aog119.obsmtp.com
	[207.126.144.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 41866243DC
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 11:44:33 +0200 (CEST)
In-Reply-To: <20120622092129.GH4037@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, spear-devel <spear-devel@list.st.com>, Vipin KUMAR <vipin.kumar@st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 6/22/2012 2:51 PM, Mark Brown wrote:
> On Thu, Jun 21, 2012 at 03:54:49PM +0530, Rajeev Kumar wrote:
>> From: Vipin Kumar<vipin.kumar@st.com>
>>
>> This patch adds the support for spdif in audio codec.
>
> As ever do try to provide subject lines which are appropriate for the
> subsystem you're submitting against.
>

Ok , I will take care of these stuff.

It should be
ASoc: SPEAr: SPDIF

>> +static int __init dir_modinit(void)
>> +{
>> +	return platform_driver_register(&spdif_dir_driver);
>> +}
>> +
>> +static void __exit dir_exit(void)
>> +{
>> +	platform_driver_unregister(&spdif_dir_driver);
>> +}
>> +
>> +module_init(dir_modinit);
>> +module_exit(dir_exit);
>
> module_platform_driver().

Ok

Best Regards
Rajeev
