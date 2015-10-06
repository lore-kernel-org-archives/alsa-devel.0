From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: Audio Mini Summit 2015, 8th October, Dublin
Date: Tue, 6 Oct 2015 10:59:03 +0000
Message-ID: <1444129142.25504.7.camel@intel.com>
References: <20151004231752.GA22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B6B82650D4
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 12:59:07 +0200 (CEST)
In-Reply-To: <20151004231752.GA22609@sirena.org.uk>
Content-Language: en-US
Content-ID: <850A6364BB14BD48AB36E08E745469F8@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-10-05 at 00:17 +0100, Mark Brown wrote:
> [This message is BCCed to everyone currently on the signup list]
> 
> As previously announce the audio mini-summit for this year will be this
> Thursday (8th August) at CCD in Dublin.  Topics we currently have on the
> list for discussion are:
> 
>  - Power saving and general system design decisions (is what we're doing
>    lining up with modern hardware with things like multiple output
>    streams?).
>  - What to do with HDMI and its integration with graphics.
>  - Test tools (Intel BAT and others).
>  - BATCH flag.
>  - ACPI simple-card and general generic card support.
>  - Topology & media controller integration.
>  - Kernel tinification.
>  - Android <-> alsa-lib configuration translation.
>  - HDA restructuring.
>  - PCM core simplification - the code is currently quite complex!
>  - Soundwire driver support plans.

Few more topics:

- tinycompress release with alsa lib. And when is next alsa-lib release?

- ASoC Multichannel support. We have talked about it, I want recheck assumption
before we implement something

- ASoC/DAPM Changes we would like to do:
	- add kcontrol suport for PGA so that we cna add user controls for DSPs
	- add internal sink in DAPM for DSPs, like siggen
	- Fix TLV byte controls
	- Discuss BE-BE loops

Thanks
-- 
~Vinod
