From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Mon, 10 Aug 2009 21:53:18 +0530
Message-ID: <98769532B4BB14429434178695419EAE5F937C6A@bgsmsx501.gar.corp.intel.com>
References: <20090704105743.GD10490@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5BBC230C@bgsmsx501.gar.corp.intel.com>
	<20090707114227.GD14393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5BC0AF65@bgsmsx501.gar.corp.intel.com>
	<20090708094619.GA7420@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F2A3EBB@bgsmsx501.gar.corp.intel.com>
	<20090717101804.GD3439@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F76A259@bgsmsx501.gar.corp.intel.com>
	<20090801094626.GA7979@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F76AC7D@bgsmsx501.gar.corp.intel.com>
	<20090803101243.GA5959@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 99D0F244B8
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 18:23:24 +0200 (CEST)
In-Reply-To: <20090803101243.GA5959@sirena.org.uk>
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

I tried changing the order as in other drivers and I also ensured that SND_JACK was part of the config file....jack.o was getting created.

I put debug print statements in jack.c and input.c (drivers/input) and found everything to be returning successfully but under /dev/inputs I don't see anything like Headphone neither any node created as Alsa... how and where I need to make sure that the jack nodes are created to be accessed by everyone.

Thanks,
Harsha.

>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>Sent: Monday, August 03, 2009 3:43 PM
>To: Harsha, Priya
>Cc: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] [PATCH] [RFC 8/13] Intel SST sound card driver
>
>On Mon, Aug 03, 2009 at 12:45:08PM +0530, Harsha, Priya wrote:
>
>[Please don't top quote; it's not the normal policy for Linux lists
>since it makes the discussion harder to follow.  Please also try to
>configure your mail client to wrap lines at 80 columns for similar
>reasons.]
>
>> I tried but still finding the same issue...the probe function and the
>related functions are as follows... please let me know if you see any
>issues
>
>
>> 	ret_val = snd_intelmad_pcm(card, intelmaddata);
>> 	if (ret_val) {
>> 		sst_err("snd_intelmad_pcm failed\n");
>> 		goto free_allocs;
>> 	}
>>
>> 	ret_val = snd_intelmad_mixer(intelmaddata);
>> 	if (ret_val) {
>> 		sst_err("snd_intelmad_mixer failed\n");
>> 		goto free_allocs;
>> 	}
>>
>> 	ret_val = snd_intelmad_jack(intelmaddata);
>> 	if (ret_val) {
>> 		sst_err("snd_intelmad_jack failed\n");
>> 		goto free_allocs;
>> 	}
>
>The main difference I can see see between this and other drivers I can
>see is the ordering of the jack creation - it's normally done earlier.
>I'd suggest doing a contrast and compare with them, and also examining
>what's going on in the code.
