From: Omer <omer.job@gmail.com>
Subject: Re:
	=?utf-8?q?ASoC=3A_Max98090_Codec_DAPM_Widget_setup_i?=
	=?utf-8?q?n_Open=09Embedded?=
Date: Wed, 25 Mar 2015 07:22:29 +0000 (UTC)
Message-ID: <loom.20150325T081642-60@post.gmane.org>
References: <CAES_P+9kc9Q6TR7e1rdjV8cWHGWJs9bHoMLOz0Z0iHaYZbqpQw@mail.gmail.com>
 <551111C3.3000704@metafoo.de>
 <1BBF0420-296C-435B-9208-5939803DAD57@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id AE34F261B0E
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 08:40:07 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Yafv3-0004fi-At
 for alsa-devel@alsa-project.org; Wed, 25 Mar 2015 08:40:05 +0100
Received: from 99-6-84-247.lightspeed.sntcca.sbcglobal.net ([99.6.84.247])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 08:40:05 +0100
Received: from omer.job by 99-6-84-247.lightspeed.sntcca.sbcglobal.net with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 08:40:05 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Variksla <variksla <at> gmail.com> writes:

> 
> 
> > On Mar 24, 2015, at 12:26 AM, Lars-Peter Clausen <lars <at> metafoo.de> 
> > 
> >> On 03/24/2015 07:54 AM, noman pouigt wrote:
> >> On Mon, Mar 23, 2015 at 11:53 PM, noman pouigt <variksla <at> gmail.com> 
wrote:
> >>>> I would like to know which file I can use to connect/enable
> >>>> DPAM widgets permanently so a simple aplay/record can work?
> >>>> 
> >>>> My environment is:
> >>>> - Yocto Linux Kernel 3.10 - (DTS based)
> >>>> - Max98090 Codec
> >>>> - imx6SL SoC
> >>>> 
> >>>> I thought about doing this in alsa.conf or asound.conf but I couldn't
> >>>> find a single example with DAPM widgets .
> >>> 
> >>> I am also stuck with the same problem. I am sure ALSA experts
> >>> can help here.
> >>> 
> >>> What i want to know is how to set the dapm widgets in open
> >>> embedded? Is it alsa.conf or asound.conf ?
> >>> 
> >>> I need to set something like this:
> >>> amixer cset  name="LEFT MIXER DAC" 1
> >>> 
> >>> Using amixer i am able to playback but i don't know how can i
> >>> modify conf file to have this dapm widgets associated with
> >>> a device.
> >>> 
> >>> Any example would suffice.
> > 
> > Hi,
> > 
> > The whole point of DAPM (dynamic audio power management) is that you don't
 have to manually power up or down
> a widget. Userspace configures the routing of the audio paths and the kernel 
automatically detects which
> parts of the chip need to be powered up for the current routing configuration.
> > 
> > Why do you want to manually enable a widget?
> 
> In android we have ucm files where dapm routings are associated with each
 device. Same way where can I list
> down dapm routings in open embedded?
> We know that user space gives the routings but we need to associate each 
device with certain set of dapm
> routes so i am looking for a place where we can list down dapm routes which
 gets triggered when a specific
> device is chosen for playback or recording. Something analogous to ucm files
 in open embedded? I couldn't
> find a way to associate dapm routes with a specific device in conf files.
 Can we use Asound.conf for this purpose?
> > 
> > - Lars
> > 
> 

In my  case, I do not want users to run these amixer commands to setup DAPM
routing if they just want to use aplay/arecord.

amixer cset name='LINMOD Mux' 1
amixer cset name='Left Receiver Mixer Left DAC Switch' 1
amixer cset name='Right Receiver Mixer Right DAC Switch' 1

When I run aplay without above commands, I can see aplay not able to
connect further than '"DACL" since there are multiple routes available
in codec driver. Only enabling the right DAC switches using above
commands completes routes:
Logs:
dapm_mark_dirty:max98090:dapm enter HiFi Playback
dapm_dirty_widget:max98090:dapm enter HiFi Playback
max98090 2-0010: Marking HiFi Playback dirty due to stream event
dapm_power_widgets:max98090:dapm enter
dapm_reset:max98090:dapm enter
dapm_power_one_widget:max98090:dapm enter
dapm_dac_check_power:max98090:dapm enter
dapm_generic_check_power:max98090:dapm enter
is_connected_input_ep:max98090:dapm HiFi Playback
is_connected_output_ep:max98090:dapm HiFi Playback
is_connected_output_ep:max98090:dapm AIFINL
is_connected_output_ep:max98090:dapm LTENL Mux
is_connected_output_ep:max98090:dapm DACL
is_connected_output_ep:max98090:dapm AIFINR
is_connected_output_ep:max98090:dapm LTENR Mux
is_connected_output_ep:max98090:dapm DACR
is_connected_output_ep:max98090:dapm AIFINL
is_connected_output_ep:max98090:dapm AIFINR


Available DAPM Routes:
{"Right Headphone Mixer", "Left DAC Switch", "DACL"},
{"Left Speaker Mixer", "Left DAC Switch", "DACL"},
{"Right Speaker Mixer", "Left DAC Switch", "DACL"},
{"Left Receiver Mixer", "Left DAC Switch", "DACL"},
{"Right Receiver Mixer", "Left DAC Switch", "DACL"},


I think there must be a way to enable complete DAPM routes all the
 way from "HiFi Playback" to one of the outputs defined in
SND_SOC_DAPM_OUTPUT() from userspace without having to type commands.

asound.state save states however its not dynamic. i.e, it will just reload
 settings. Won't switch between paths.
