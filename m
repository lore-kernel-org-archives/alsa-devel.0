From: Liam Girdwood <lrg@ti.com>
Subject: Re: UCM: Possible snd_use_case_get enhancements
Date: Mon, 6 Jun 2011 10:58:15 +0100
Message-ID: <4DECA4B7.90208@ti.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498E1C866@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 4514F103804
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 11:58:18 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498E1C866@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 03/06/11 22:11, Stephen Warren wrote:
> Liam,
> 
> The recent patches I posted allow querying a modifier/device's supported/
> conflicting device list from a modifier/device either within the
> currently active verb (if any) or an explicitly defined verb.
> 
> I figured a similar enhancement to snd_use_case_get might be useful; i.e.
> to allow querying within a specific verb, and also to indicate that one
> shouldn't fall back to a verb, or overall values. I'd propose something
> like this:
> 
> NAME[[=]/<modifier>|<device>[/[=]<verb>]]
> 
> The "=" would prevent fallback to a "higher" object if present. So for
> example:
> 
> Current verb, not from device or modifier, with fallback to verb and
> ValueDefaults:
> 
> PlaybackVolume
> 
> Current verb, from device/modifier with fallback to verb and
> ValueDefaults:
> 
> PlaybackVolume/Play Music
> 
> Current verb, from dev/mod without fallback to verb or ValueDefaults:
> 
> PlaybackVolume/=Play Music
> 
> Specify a verb and dev/mod, but allow fallback to verb or ValueDefaults:
> 
> PlaybackVolume/Play Music/HiFi
> 
> Specify a verb and dev/mod, but no fallback to verb or ValueDefaults:
> 
> PlaybackVolume/=Play Music/=HiFi
> 
> One can also query from just a verb, with/without fallback:
> 
> PlaybackVolume//HiFi
> PlaybackVolume//=HiFi
> 
> Or current verb with no fallback:
> 
> PlaybackVolume//=
> 
> Does this seem useful, and a sane query string syntax?
> 

Sounds fine to me.

> An alternative would be to drop the added "=" stuff, and never auto-
> fallback. However, that'd be a regression relative to current
> functionality, force clients to implement fallback themselves, and make
> querying ValueDefaults hard.
> 

Thanks

Liam
