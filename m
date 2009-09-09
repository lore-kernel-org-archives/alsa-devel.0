From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: control names
Date: Wed, 9 Sep 2009 17:53:56 +0530
Message-ID: <98769532B4BB14429434178695419EAE66201FCD@bgsmsx501.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE5F76A259@bgsmsx501.gar.corp.intel.com>
	<20090801094626.GA7979@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F76AC7D@bgsmsx501.gar.corp.intel.com>
	<20090803101243.GA5959@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5F937C6A@bgsmsx501.gar.corp.intel.com>
	<20090810163408.GA31393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F9793FA@bgsmsx501.gar.corp.intel.com>
	<20090811104733.GA8221@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE66201FB8@bgsmsx501.gar.corp.intel.com>
	<alpine.LNX.2.00.0909091410480.12929@eeebox2.perex-int.cz>
	<20090909121536.GC9548@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 968412442C
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 14:26:23 +0200 (CEST)
In-Reply-To: <20090909121536.GC9548@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>Sent: Wednesday, September 09, 2009 5:46 PM
>To: Jaroslav Kysela
>Cc: Harsha, Priya; alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] control names
>
>On Wed, Sep 09, 2009 at 02:11:34PM +0200, Jaroslav Kysela wrote:
>> On Wed, 9 Sep 2009, Harsha, Priya wrote:
>
>> > I am using a control name as "PCM Capture Switch". But the alsa mixer
>> > does not display the mute option for me to mute/unmute the capture
>path.
>
>> > Same thing for playback works i.e, "PCM Playback Switch" displays a
>mute
>> > button in alsamixer for me to change....
>
>> Did you press F4 to switch to the capture view?
>
>Also note that alsamixer uses a different display for capture switches
>in the UI - you won't see the same format button you'll see
>
>   ------
>
>if the switch is off or
>
>   L    R
>   CAPTUR
>
>if it's on under the volume control.
You are right... I see it as above. And how do I change the mute to unmute and vice versa using alsamixer?

Another issue am facing is that in "Playback" tab I see all capture and playback controls listed and in "Capture" tab only the capture controls and in "ALL" tab, all the controls listed. Why does capture controls get displayed under "Playback" tab? Following is my control structure that I use

struct snd_kcontrol_new snd_intelmad_controls[MAX_CTRL] __devinitdata = {
{
	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
	.name 		=	"PCM Playback Volume",
	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
	.info 		=	snd_intelmad_playback_volume_info,
	.get 		=	snd_intelmad_volume_get,
	.put		=	snd_intelmad_volume_set,
	.private_value 	=	0,
},
{
	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
	.name 		=	"PCM Playback Switch",
	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
	.info 		=	snd_intelmad_mute_info,
	.get 		=	snd_intelmad_mute_get,
	.put		=	snd_intelmad_mute_set,
	.private_value	=	0,
},
{
	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
	.name 		=	"PCM Capture Volume",
	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
	.info 		=	snd_intelmad_capture_volume_info,
	.get 		=	snd_intelmad_volume_get,
	.put		=	snd_intelmad_volume_set,
	.private_value 	=	0,
},
{
	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
	.name 		=	"PCM Capture Switch",
	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
	.info 		=	snd_intelmad_mute_info,
	.get 		=	snd_intelmad_mute_get,
	.put		=	snd_intelmad_mute_set,
	.private_value 	=	0,
},
{
	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
	.name 		=	"PCM Playback Source",
	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
	.info 		=	snd_intelmad_device_info,
	.get 		=	snd_intelmad_device_get,
	.put		=	snd_intelmad_device_set,
	.private_value	=	0,
},
{
	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
	.name 		=	"PCM Capture Source",
	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
	.info 		=	snd_intelmad_device_info,
	.get 		=	snd_intelmad_device_get,
	.put		=	snd_intelmad_device_set,
	.private_value 	=	0,
},
{
	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
	.name 		=	"Master Playback Switch",
	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
	.info 		=	snd_intelmad_mute_info,
	.get 		=	snd_intelmad_mute_get,
	.put		=	snd_intelmad_mute_set,
	.private_value	=	0,
},
};
