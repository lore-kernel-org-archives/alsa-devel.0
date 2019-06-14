From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/3] ASoC: SOF: acpi: add module param
 to disable pm_runtime
Date: Fri, 14 Jun 2019 12:24:22 +0200
Message-ID: <3e1f9a13-02db-5524-3457-935b34db4115@linux.intel.com>
References: <20190612164726.26768-1-pierre-louis.bossart@linux.intel.com>
 <20190612164726.26768-3-pierre-louis.bossart@linux.intel.com>
 <20190613184801.GV5316@sirena.org.uk> <s5hk1dpe283.wl-tiwai@suse.de>
 <20190613191303.GX5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CC55F80794
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 12:24:28 +0200 (CEST)
In-Reply-To: <20190613191303.GX5316@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>> I can't immediately find it right now but isn't there some generic way
>>> of doing this in the runtime PM framework?  If not it seems like it'd be
>>> a good thing to add, these can't be the only devices where it'd be
>>> useful.
> 
>> Well, runtime PM can be fully controlled via sysfs, but the problem is
>> that the driver declares itself being runtime-enabled.
>> So, either we leave it default and let user-space enabling it (via
>> udev or other way), or introduce some condition in the driver side.
> 
> I thought someone had added a command line parameter to do it based on
> dev_name(), perhaps they were just talking about it or it was in some
> BSP somewhere though.

If there is a better way I am all ears. It's indeed not very elegant to 
duplicate the same parameter for two different modules and it's not an 
SOF-specific need.

The only way I am aware of is to play with 
/sys/bus/pci/devices/xyz/power/ files but it's not very useful if you 
want to disable the initial runtime pm transition which is often the 
more problematic one. Completely removing runtime_pm support from all 
drivers at compile time is also not very good either.
