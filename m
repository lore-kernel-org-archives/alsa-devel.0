From: zhejiang <zhe.jiang@intel.com>
Subject: Re: patch for Dell 1210 which using stac9221 codec
Date: Mon, 22 Oct 2007 14:08:19 +0800
Message-ID: <1193033299.26715.34.camel@localhost.localdomain>
References: <1192675756.3701.30.camel@localhost.localdomain>
	<s5hve94zd3a.wl%tiwai@suse.de>
	<1192773763.4306.31.camel@localhost.localdomain>
	<s5hejfrekan.wl%tiwai@suse.de>
	<1192779729.4628.5.camel@localhost.localdomain>
	<s5hk5pjzefs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id CF2D524887
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Oct 2007 08:10:16 +0200 (CEST)
In-Reply-To: <s5hk5pjzefs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-10-19 at 10:39 +0200, Takashi Iwai wrote:
> At Fri, 19 Oct 2007 15:42:09 +0800,
> zhejiang wrote:
> > 
> > On Fri, 2007-10-19 at 07:38 +0200, Takashi Iwai wrote:
> > > At Fri, 19 Oct 2007 14:02:43 +0800,
> > > zhejiang wrote:
> > > > 
> > > > On Thu, 2007-10-18 at 22:55 +0800, Takashi Iwai wrote:
> > > > > At Thu, 18 Oct 2007 10:49:16 +0800,
> > > > > zhejiang wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Dell 1210 have three jacks on the front.
> > > > > > Two of them serve as output jack and one serve as microphone.
> > > > > > The microphone can be switched to output model too.
> > > > > >
> > > > > > There are some problems with current dell 1210 driver:
> > > > > > 1.Unable to use the front microphone
> > > > > > 2.Unable to switch the microphone
> > > > > > 3.If plug the left hp,another hp will be muted,so it's impossible to
> > > > > > work as 6-channel
> > > > > >
> > > > > > According to the issue 0003427 on alsa-bugzilla,
> > > > > 
> > > > > Oops is bad.  Does it still happen with the latest HG tree?
> > > > > This should be fixed urgently at first.
> > > > > 
> > > > The oops won't happen with the latest HG tree.
> > > > The reason of the oops is that there is no input pin.
> > > > 
> > > > Now the snd_hda_input_mux_put() will check the input_mux.num_items,
> > > > if it is equal to zero,snd_hda_input_mux_put() will return directly
> > > > and avoid the oops.
> > > 
> > > OK, good to hear.
> > > 
> > > > > > I wrote a patch and the reporter helped me to test it on his
> > > > > machine.
> > > > > > It can support the front microphone. When switch the microphone to
> > > > > > output model, it can mute/unmute the internal speaker with
> > > > > jack-sensing.
> > > > > 
> > > > > Thanks for the patch.  I have little time right now for checking in
> > > > > details, but the changes appear in fairly deep level.
> > > > 
> > > > Yes,It's hard to support such kind of machine with current
> > > > stac92xx_parse_auto_config().So my patch changed so many generic
> > > > functions. :-).
> > > > 
> > > > > I think we should rather fix the current code to handle multiple
> > > > > headphones better than the ad-hoc fixes.  Surely there will be other
> > > > > models that require similar fixes (if you see Dell has shipped how
> > > > > many different variants :)
> > > > > Takashi
> > > > > 
> > > > 
> > > > Great!
> > > > I think this model should support:
> > > > 1.Each headphone can mute the internal speaker.
> > > > 2.Even the Front mic can work output jack
> > > > 3.When mic works as output jack,it can mute the internal speaker too.
> > > > 
> > > > Does this make sense? Thanks!
> > > 
> > > This sounds good.
> > > 
> > > Does Dell 1210 have both front and rear mic jacks?  I don't know of
> > > this machine, so it'd be helpful to understand if you describe the
> > > available I/O (PINs and jacks) and expected behavior briefly here.
> > > Since sigmatel patch uses the single detection code for every device,
> > > we need to cover all possible scenarios with different I/O mappings.
> > > 
> > 
> > Dell 1210 doesn't have rear mic jacks.
> > There are three jacks in the front :
> > "Headphone","Headphone","Microphone".
> > According to the spec,the mic need to work as output to support 6
> > channels mode.
> > 
> > Here is the picture of the jacks:
> > http://www.notebookreview.com/assets/12583.jpg
> 
> Ah, then it's basically similar like 3-stack model but with two
> headphones instead of a pair of line-out and line-in.
> 
> Without your modification of pin config, how the driver detects?
> Do you have an output of kernel message with debug option about auto
> pin configs?
> 
I don't have the hardware.
I have asked the bug reporter to do the experiment,
I will post it here if i get any response.
> Looking through the sigmatel code, we have several known use cases:
> 
> 1. desktop
> 1a. 3stack + front panel
>     front HP, front mic, rear line-out, rear line-in, rear mic
> 
> 1b. 6stack + front panel
>     front HP, front mic, rear line-out, rear surr, rear CLFE
>     rear side, rear line-in, rear mic
> and variants without front panel.
> 
> In the case 1a, rear line-in and rear mic can be used as surround
> outputs.
> 
> 2. laptop
> 2a. minimal
>     HP, speaker, mic, built-in mic
> 2b. a la desktop
>     HP, speaker, line-in, mic, built-in mic
> 2c. dell
>     HP x 2, speaker(s), mic, built-in mic
> 
> Now, the case 2c requires a similar hack.  But, before going more
> deeply, it's better to recheck patch_sigmatel.c again.  Basically, it
> has already the code to add output sharing using line-in/mic-in.  The
> problem is that it checks only limited use-cases (1a) and it adds
> cfg->line_outs and thus this influences on all other places.
> 

The call graph of stac92xx_parse_auto_config() :

1.snd_hda_parse_pin_def_config()

2.stac92xx_add_dyn_out_pins()
It check the cfg->line_outs and input_pins[] to add dynamic lineouts.

3.stac92xx_auto_fill_dac_nids()
It only fills the dac_nids from the cfg->line_out_pins[],

4.stac92xx_auto_create_multi_out_ctls()
It add controls according to the cfg->line_outs.

we can see that they heavily depend on the line_outs[] info.

How about this method?

In stac92xx_add_dyn_out_pins(),we check the cfg->hp_outs,IF IT IS 2,then
we switch the cfg->hp_pins[] with cfg->line_out_pins[].
The 2,3,4 may work without change.
At the end of the stac92xx_parse_auto_config(),we restore the
cfg->hp_pins[] and cfg->line_out_pins[].

Another things to change :
1.snd_hda_parse_pin_def_config()
	Should sort the hp_pins[] by sequence.
2.stac92xx_auto_fill_dac_nids()
	Support the "Front Mic" switch as well.
3.stac92xx_io_switch_put()
	If Mic work as output for laptop,enable pin detect too.

Does it make sense?

> So, above all, a bit more cleaner implementation would be preferred...
> 
> 
> Takashi
