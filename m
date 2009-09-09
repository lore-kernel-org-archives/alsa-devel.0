From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: control names
Date: Wed, 9 Sep 2009 17:37:47 +0530
Message-ID: <98769532B4BB14429434178695419EAE66201FB8@bgsmsx501.gar.corp.intel.com>
References: <20090708094619.GA7420@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F2A3EBB@bgsmsx501.gar.corp.intel.com>
	<20090717101804.GD3439@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F76A259@bgsmsx501.gar.corp.intel.com>
	<20090801094626.GA7979@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F76AC7D@bgsmsx501.gar.corp.intel.com>
	<20090803101243.GA5959@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F937C6A@bgsmsx501.gar.corp.intel.com>
	<20090810163408.GA31393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F9793FA@bgsmsx501.gar.corp.intel.com>
	<20090811104733.GA8221@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D1F924408
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 14:07:51 +0200 (CEST)
In-Reply-To: <20090811104733.GA8221@rakim.wolfsonmicro.main>
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am using a control name as "PCM Capture Switch". But the alsa mixer does not display the mute option for me to mute/unmute the capture path.

Same thing for playback works i.e, "PCM Playback Switch" displays a mute button in alsamixer for me to change....

Any clue as to in what I can get a capture mute/unmute configurable?

Thanks,
Harsha.

>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>Sent: Tuesday, August 11, 2009 4:18 PM
>To: Harsha, Priya
>Cc: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] [PATCH] [RFC 8/13] Intel SST sound card driver
>
>On Tue, Aug 11, 2009 at 04:13:50PM +0530, Harsha, Priya wrote:
>
>> Can you help me know which component/config file is responsible for
>> creation of nodes in /dev/input? What am I missing here?
>
>Normally this is done by either udev or static configuration.
