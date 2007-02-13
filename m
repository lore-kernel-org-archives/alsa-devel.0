From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: Q: How to detect which USx2y is connected?
Date: Tue, 13 Feb 2007 20:03:43 +0100
Message-ID: <200702132003.44102.annabellesgarden@yahoo.de>
References: <20070205065636.GA1652@elte.hu> <s5hire6c5jo.wl%tiwai@suse.de>
	<45D1FE83.7000301@rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45D1FE83.7000301@rncbc.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 13. Februar 2007 schrieb Rui Nuno Capela:
> Takashi Iwai wrote:
> > At Tue, 13 Feb 2007 18:36:35 +0100,
> > Karsten Wiese wrote:
> >> Hi Rui,
> >>
> >> Am Dienstag, 13. Februar 2007 schrieb Rui Nuno Capela:
> >>> Hi Karsten,
> >>>
> >>> In my quest in completing us428control implementation, I'm now stumbling
> >>> on a fundamental question regarding the number of tracks/channel-faders
> >>> (per bank) each particular usx2y device supports. The question boils down
> >>> to what is the actual numeric value of the y in the actual usx2y model
> >>> name :)
> >>>
> >>> In practice, I need to know which usx2y model is actually connected.
> >>>
> >>> So, what is the best/deterministic way to detect (programmatically)
> >>> whether us428control is connecting to a US224 (y=4, as mine) _or_ a US428
> >>> (y=8, as yours) ?
> >>>
> >>> Is snd_hwdep_info_get_name() expected to be the most correct method?
> >> Yes, I fear. this gives the /proc/bus/usb/002/004 filename.
> >> I just did cat /proc/bus/usb/004/005 > x
> >> and check x with hexedit: the 1604 and 8001 is in there.
> >> I don't know how to portably interpret a read from
> >> /proc/bus/usb/004/005 though.
> > 
> > Note that /proc/bus/usb is deprecated on many distros...
> > 
> 
> How about using snd_pcm_hw_params_get_channels_max() ?
> At least on capture the US224 should give 2 and the US428 should give 4
> as the maximum number of channels.
> 
> It would be handful for me if the attached test program could be ran
> against a US428, just for the records ;)
> 
> On my US224 it gives:
> 
> $ snd_hwdep_info hw:3
> ---hwdep---
> snd_hwdep_info_get_id   (hw:3) = 'USX2Y Loader'
> snd_hwdep_info_get_name (hw:3) = '/proc/bus/usb/001/004'
> ---pcm (capture)---
> snd_pcm_hw_params_get_channels_min(hw:3) = 2
> snd_pcm_hw_params_get_channels_max(hw:3) = 2
> ---pcm (playback)---
> snd_pcm_hw_params_get_channels_min(hw:3) = 2
> snd_pcm_hw_params_get_channels_max(hw:3) = 2
> 
> Karsten?

 ./a.out hw:1
---hwdep---
snd_hwdep_info_get_id   (hw:1) = 'USX2Y Loader'
snd_hwdep_info_get_name (hw:1) = '/proc/bus/usb/004/007'
---pcm (capture)---
snd_pcm_hw_params_get_channels_min(hw:1) = 2
snd_pcm_hw_params_get_channels_max(hw:1) = 2
---pcm (playback)---
snd_pcm_hw_params_get_channels_min(hw:1) = 2
snd_pcm_hw_params_get_channels_max(hw:1) = 2

The 428's 4 capture channels are only visible to the raw-usb jack thing.
and this is only there for module param nrpacks=1.....

What do you see in your /sys/bus/usb/devices/... ?
(Not that I knew how to deduce the sysfs file from the hwdep->name)

      Karsten

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
