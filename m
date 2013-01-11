From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/8] ASoC: Add support for virtual switch
	controls
Date: Fri, 11 Jan 2013 13:38:55 +0100
Message-ID: <50F007DF.9000606@metafoo.de>
References: <1357833977-3682-1-git-send-email-lars@metafoo.de>
 <1357833977-3682-2-git-send-email-lars@metafoo.de>
 <20130111121912.GY20956@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-054.synserver.de (smtp-out-054.synserver.de
 [212.40.185.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 245CD26260A
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 13:38:13 +0100 (CET)
In-Reply-To: <20130111121912.GY20956@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/11/2013 01:19 PM, Mark Brown wrote:
> On Thu, Jan 10, 2013 at 05:06:11PM +0100, Lars-Peter Clausen wrote:
> 
>> More specific this will be used by the ADAU1361 driver where the hardware has
>> a mute control for each of the DAC output paths, but we have to make sure that
>> the path is muted whenever the DAC is disabled. So the mute switches needs
>> to be controlled by DAPM so it can disable them before disabling the DAC. On the
>> other hand we still want to be to mute individual paths. This will be
>> accomplished by using virtual switch controls.
> 
> This doesn't sound like it does quite what you want - it means you don't
> actually end up with a mute control, only a power control (which is also
> going to affect everything else in the path).  I'd expect to see
> something like this implemented by having a control that has a specified
> value forced in the register while the control is enabled (kind of the
> opposite of a supply).  This is a fairly common need for older parts
> though it's unusual to see it on a new device.

I think I want the opposite of what you just described. I want to be able to
overwrite the control setting based on the power state.

The hardware setup looks a bit like this.
                                  +------------+
                /---- [Mute] ---- | Left Mixer | ....
+----------+   /                  +------------+
| Left DAC | -<
+----------+   \                  +-------------+
                \---- [Mute] ---- | Right Mixer | ...
                                  +-------------+

Same for the Right DAC. The DAC output goes to GND when the DAC is disabled.
If the mute control is enabled its output goes to midscale otherwise. So
whenever the DAC is disabled we need to make sure that all mute controls
after the DAC output are also enabled to avoid pop noises.
Still we want to be able to enable a mute control even if the DAC is
enabled. For example to route only the left DAC to the left mixer and the
right DAC to the right mixer.

In ASoC I modeled this by letting DAPM take care of mute controls. E.g. the
mute control gets disabled if there is an active path from the DAC through
the mixer to one of the outputs and gets disabled otherwise. This makes sure
that when the DAC is powered down (when there is no active path from the DAC
to any of the outputs) each mute control is also enabled. The virtual
switches now allow disable a path from the DAC to the mixer, which in turn
will cause DAPM to enable the mute control. This is similar to how the
virtual enums already work.

- Lars
