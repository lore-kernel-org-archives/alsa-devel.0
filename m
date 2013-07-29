From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Broken headphone and speaker amplifier
 suppliesforthe rt5640 driver
Date: Mon, 29 Jul 2013 08:14:51 +0200
Message-ID: <51F6085B.1080900@metafoo.de>
References: <51F29064.8080003@metafoo.de> <20130727173509.GJ9858@sirena.org.uk>
 <1121E117AD4ECE49880A389A396215BB935C48A592@rtitmbs7.realtek.com.tw>
 <20130729060716.GQ9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-111.synserver.de (smtp-out-114.synserver.de
 [212.40.185.114])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FDCE261A24
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 08:13:58 +0200 (CEST)
In-Reply-To: <20130729060716.GQ9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Bard Liao <bardliao@realtek.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On 07/29/2013 08:07 AM, Mark Brown wrote:
> On Mon, Jul 29, 2013 at 11:04:46AM +0800, Bard Liao wrote:
> 
>> The mute/unmute control is written in rt5640_snd_controls[] now.
>> It allows user to unmute speaker or headphone before dapm power on the related power.
>> And it will bring a pop noise.
>> So I prefer to do the unmute/mute step in the widget event.
>> Is that ok?
> 
> If you need to do that you should really still present the mute control
> to the user; store the current state in a variable in the private data
> so that the user always sees the control and then only write the value
> out while the widget is powered.  Mute is expected to be fast and some
> userspaces like to be able to mute individual outputs.
> 
> Ideally the core would be able to do this.
> 

Yea, so the stuff I was working on while I stumbled upon this was more or
less that. Support for letting DAPM mute controls, which are also exposed to
userspace, if necessary in order to avoid clicks and pops. Once muted by
DAPM userspace will only see a cached value of the controls state and once
DAPM unmutes the control the userspace state will be restored.

- Lars
