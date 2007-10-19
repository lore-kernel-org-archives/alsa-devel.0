From: zhejiang <zhe.jiang@intel.com>
Subject: Re: patch for Dell 1210 which using stac9221 codec
Date: Fri, 19 Oct 2007 15:42:09 +0800
Message-ID: <1192779729.4628.5.camel@localhost.localdomain>
References: <1192675756.3701.30.camel@localhost.localdomain>
	<s5hve94zd3a.wl%tiwai@suse.de>
	<1192773763.4306.31.camel@localhost.localdomain>
	<s5hejfrekan.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DF82245E3
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Oct 2007 09:45:59 +0200 (CEST)
In-Reply-To: <s5hejfrekan.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-10-19 at 07:38 +0200, Takashi Iwai wrote:
> At Fri, 19 Oct 2007 14:02:43 +0800,
> zhejiang wrote:
> > 
> > On Thu, 2007-10-18 at 22:55 +0800, Takashi Iwai wrote:
> > > At Thu, 18 Oct 2007 10:49:16 +0800,
> > > zhejiang wrote:
> > > >
> > > > Hi,
> > > >
> > > > Dell 1210 have three jacks on the front.
> > > > Two of them serve as output jack and one serve as microphone.
> > > > The microphone can be switched to output model too.
> > > >
> > > > There are some problems with current dell 1210 driver:
> > > > 1.Unable to use the front microphone
> > > > 2.Unable to switch the microphone
> > > > 3.If plug the left hp,another hp will be muted,so it's impossible to
> > > > work as 6-channel
> > > >
> > > > According to the issue 0003427 on alsa-bugzilla,
> > > 
> > > Oops is bad.  Does it still happen with the latest HG tree?
> > > This should be fixed urgently at first.
> > > 
> > The oops won't happen with the latest HG tree.
> > The reason of the oops is that there is no input pin.
> > 
> > Now the snd_hda_input_mux_put() will check the input_mux.num_items,
> > if it is equal to zero,snd_hda_input_mux_put() will return directly
> > and avoid the oops.
> 
> OK, good to hear.
> 
> > > > I wrote a patch and the reporter helped me to test it on his
> > > machine.
> > > > It can support the front microphone. When switch the microphone to
> > > > output model, it can mute/unmute the internal speaker with
> > > jack-sensing.
> > > 
> > > Thanks for the patch.  I have little time right now for checking in
> > > details, but the changes appear in fairly deep level.
> > 
> > Yes,It's hard to support such kind of machine with current
> > stac92xx_parse_auto_config().So my patch changed so many generic
> > functions. :-).
> > 
> > > I think we should rather fix the current code to handle multiple
> > > headphones better than the ad-hoc fixes.  Surely there will be other
> > > models that require similar fixes (if you see Dell has shipped how
> > > many different variants :)
> > > Takashi
> > > 
> > 
> > Great!
> > I think this model should support:
> > 1.Each headphone can mute the internal speaker.
> > 2.Even the Front mic can work output jack
> > 3.When mic works as output jack,it can mute the internal speaker too.
> > 
> > Does this make sense? Thanks!
> 
> This sounds good.
> 
> Does Dell 1210 have both front and rear mic jacks?  I don't know of
> this machine, so it'd be helpful to understand if you describe the
> available I/O (PINs and jacks) and expected behavior briefly here.
> Since sigmatel patch uses the single detection code for every device,
> we need to cover all possible scenarios with different I/O mappings.
> 

Dell 1210 doesn't have rear mic jacks.
There are three jacks in the front :
"Headphone","Headphone","Microphone".
According to the spec,the mic need to work as output to support 6
channels mode.

Here is the picture of the jacks:
http://www.notebookreview.com/assets/12583.jpg

> 
> Thanks,
> 
> Takashi
