From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] Initialize volumes of HD-audio slave ctls
Date: Mon, 12 Mar 2012 10:35:30 +0800
Message-ID: <CAN8cciYAvq8G_G9ARVFHi3PvxoXo5KucwbuQwujDSs-dpn6b1Q@mail.gmail.com>
References: <s5haa3ryuxb.wl%tiwai@suse.de> <4F594709.6090303@canonical.com>
	<s5h7gyuntea.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 4D40624681
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 03:35:31 +0100 (CET)
Received: by werg1 with SMTP id g1so2956782wer.38
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 19:35:30 -0700 (PDT)
In-Reply-To: <s5h7gyuntea.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

2012/3/9, Takashi Iwai <tiwai@suse.de>:
> At Fri, 09 Mar 2012 00:55:53 +0100,
> David Henningsson wrote:
>>
>> On 03/08/2012 04:27 PM, Takashi Iwai wrote:
>> > Hi,
>> >
>> > the patch below is an attempt to initialize the volume / mutes of
>> > slave controls (such as "Headphone", "Speaker") with vmaster in
>> > HD-audio, so that the sound can come out only by changing the master
>> > volume/mute.
>> >
>> > We have thought that such initializations could be done well in
>> > alsactl init, but it seems that not everyone installs the latest and
>> > greatest alsactl, and there is always a risk that any new controls may
>> > be added before alsactl is updated and released.  Since the master
>> > volume is set muted, the risk by this change should be low.
>> >
>> > patch_cirrus.c still doesn't support this because it's handling
>> > vmaster by itself, but it can be fixed later, too.
>> >
>> > If anyone has a concern by this, please let me know.
>>
>> I think it is good to initialise the volume controls to a sane value in
>> general. I guess the risk of causing unnecessary pops is possible, but
>> not common.
>
> Actually this doesn't initialize the all volumes to "sane" values.  As
> mentioned, Master is still zero/muted.  Only slaves are raised so that
> you don't need to adjust two or more volumes but only master for
> getting some sound.
>
> The reason I wrote it is because of a likely happening scenario:
> I modify the driver to support individual speaker and headphone
> volumes from a single volume.  Then people without proper alsactl init
> setup would get both controls muted.  And they complain.
>
>> I'm a little surprised by the implementation though; partly because the
>> functions added to hda_codec.c does not seem to be HDA specific, partly
>> by the need to mess around with set_fs. I trust you to know what you're
>> doing w r t to the set_fs stuff, but maybe it would be more elegant if
>> these functions could be in the core and either using, or together with,
>> other functions that need to do set_fs to read/write TLV information?
>
> The volume initialization is a very sensitive topic.  It's really
> depending on the hardware which value to be set.  In the case of
> vmaster, it's relatively easy.  At least, the slave output volumes can
> be set to 0dB just to follow the master volume.
>
> Then I thought of implementing it in the common vmaster code, but
> found that it's not so trivial.  The vmaster slaves may contain also
> input volumes like line-in.  Raising such a control automatically is
> obviously wrong.  Thus the selection of slaves must be selective.
> Also the handling of dB TLV would be more complicated when we allow
> all dB TLV types, to be more generic.  That's why I decided to start
> from the HD-audio specific code.
>
> About set_fs: yes, it's ugly and I want to get rid of it, too.
> Currently it's needed because the TLV callback is supposed to handle
> the user-space pointer directly.  Handling the user-space pointer
> allows us to access to a large data without too much copying.
>
> OTOH, it's true that the direct access would be easier for the
> lowlevel driver no matter with our without set_fs.  Since the TLV data
> size is limited (practically in 4kB or such), we may pass it to
> kmalloc'ed buffer and let the core copying to user-space.  It's not so
> frequently accessed type, anyway.
>
> So, both your points are correct.  They are to be improved in future.
>
>> Another thought is whether you need to do snd_ctl_notify or if that is
>> handled automatically inside kctl->put. Or if you're just counting on
>> nobody to listen at that point.
>
> It's done in the build_controls, so it's far before the device
> registration.  Even if it's called in reconfigure, it's guaranteed
> that the device is free of access.
>

The main reason for ad1984 is the thinkpad model have "PCM Playback
Volume" , "Headphone Playback Switch" and "Speaker Playback Switch"



static const struct snd_kcontrol_new ad1984_thinkpad_mixers[] = {
	HDA_CODEC_VOLUME("PCM Playback Volume", 0x04, 0x0, HDA_OUTPUT),
	/* HDA_CODEC_VOLUME_IDX("PCM Playback Volume", 1, 0x03, 0x0, HDA_OUTPUT), */
	HDA_CODEC_MUTE("Headphone Playback Switch", 0x11, 0x0, HDA_OUTPUT),
	HDA_CODEC_MUTE("Speaker Playback Switch", 0x12, 0x0, HDA_OUTPUT),

The fix in ubuntu is just turn the switch on

+
+ # AD1984 -- Thinkpad T61/X61
+ switch_control "Speaker" on
+ switch_control "Headphone" on

https://bugs.launchpad.net/ubuntu/+source/alsa-utils/+bug/190393


I think the proper way is to let HP use DAC0 and Speaker use DAC1
