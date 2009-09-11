From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: control names
Date: Fri, 11 Sep 2009 12:34:57 +0530
Message-ID: <98769532B4BB14429434178695419EAE66286C82@bgsmsx501.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE5F76AC7D@bgsmsx501.gar.corp.intel.com>
	<20090803101243.GA5959@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F937C6A@bgsmsx501.gar.corp.intel.com>
	<20090810163408.GA31393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F9793FA@bgsmsx501.gar.corp.intel.com>
	<20090811104733.GA8221@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE66201FB8@bgsmsx501.gar.corp.intel.com>
	<alpine.LNX.2.00.0909091410480.12929@eeebox2.perex-int.cz>
	<20090909121536.GC9548@sirena.org.uk>
	<98769532B4BB14429434178695419EAE66201FCD@bgsmsx501.gar.corp.intel.com>
	<20090909123534.GA14612@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 099452456D
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 09:05:04 +0200 (CEST)
In-Reply-To: <20090909123534.GA14612@rakim.wolfsonmicro.main>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>Sent: Wednesday, September 09, 2009 6:06 PM
>To: Harsha, Priya
>Cc: Jaroslav Kysela; alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] control names
>
>On Wed, Sep 09, 2009 at 05:53:56PM +0530, Harsha, Priya wrote:
>> >-----Original Message-----
>> >From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>
>> >Also note that alsamixer uses a different display for capture switches
>> >in the UI - you won't see the same format button you'll see
>
>> You are right... I see it as above. And how do I change the mute to
>> unmute and vice versa using alsamixer?
>
>Press space.
>
>[Please fix your mailer to word wrap at 80 columns - it makes your
>mails hard to read and reply to.]
Its fixed now, but I see 2 issues:
1. the control "PCM Capture Source" comes under the playback tab
And not under capture tab
2. The mute control for "PCM Capture Switch" comes only under
Capture tab and does not come under ALL tab

Can you please help me fix these issues? Is there some problem
With my naming?

Thanks,
Harsha
