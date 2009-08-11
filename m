From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Tue, 11 Aug 2009 16:13:50 +0530
Message-ID: <98769532B4BB14429434178695419EAE5F9793FA@bgsmsx501.gar.corp.intel.com>
References: <20090707114227.GD14393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5BC0AF65@bgsmsx501.gar.corp.intel.com>
	<20090708094619.GA7420@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F2A3EBB@bgsmsx501.gar.corp.intel.com>
	<20090717101804.GD3439@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F76A259@bgsmsx501.gar.corp.intel.com>
	<20090801094626.GA7979@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F76AC7D@bgsmsx501.gar.corp.intel.com>
	<20090803101243.GA5959@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F937C6A@bgsmsx501.gar.corp.intel.com>
	<20090810163408.GA31393@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 40ED924B64
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 12:44:29 +0200 (CEST)
In-Reply-To: <20090810163408.GA31393@rakim.wolfsonmicro.main>
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

Hi Mark,

Yes it appears in sys/class/input. Thanks a lot for educating me on that...

Can you help me know which component/config file is responsible for creation of nodes in /dev/input? What am I missing here?

Thanks,
Harsha.

>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>Sent: Monday, August 10, 2009 10:04 PM
>To: Harsha, Priya
>Cc: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] [PATCH] [RFC 8/13] Intel SST sound card driver
>
>On Mon, Aug 10, 2009 at 09:53:18PM +0530, Harsha, Priya wrote:
>
>[Reflowed to 80 columns.]
>
>> I put debug print statements in jack.c and input.c (drivers/input) and
>> found everything to be returning successfully but under /dev/inputs I
>> don't see anything like Headphone neither any node created as Alsa...
>> how and where I need to make sure that the jack nodes are created to be
>> accessed by everyone.
>
>Have you checked /sys/class/input?  Creation of device nodes under /dev
>is the responsibility of user space, to check that the kernel part of
>things is working you need to check /sys.
