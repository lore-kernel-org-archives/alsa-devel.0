From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: [RFC] Moving snd-bt87x and btaudio to drivers/media
Date: Wed, 18 Jan 2006 23:04:41 +0400
Message-ID: <43CE9149.10806@gmail.com>
References: <1137590968.32449.46.camel@localhost>
	<s5h8xtdtsej.wl%tiwai@suse.de>
Reply-To: Linux and Kernel Video <video4linux-list@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <s5h8xtdtsej.wl%tiwai@suse.de>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux and Kernel Video <video4linux-list@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>, alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 18 Jan 2006 11:29:28 -0200,
> Mauro Carvalho Chehab wrote:
>   
>> Lee/Andrew/Linus/Takashi and others,
>>
>> 	Currently, we have some audio modules for multimedia devices under
>> drivers/media and others under sound. They also appear under different
>> points at Kconfig menus. 
>>
>> 	So, for BTTV support, current structure at linus -git is (from Kconfig
>> perspective):
>>
>> 	Sound/ALSA/PCI Devices/Bt87x Audio capture
>> 		sound/snd-bt87x.ko - ALSA audio for bttv boards
>> 	Sound/OSS/TV Card (bt848) mixer support
>> 		drivers/media/video/tvmixer.ko
>>
>> 	Multimedia/V4L/BT848 V4L
>> 		drivers/media/video/bttv.ko
>> 	Multimedia/V4L/BT848 V4L/DVB-ATSC support
>> 		drivers/media/dvb/bt8xx/bt878.ko
>> 		drivers/media/dvb/bt8xx/dvb-bt8xx.o
>>
>> 	This I couldn't found at any Kconfig (but module exists, and also an
>> entry at Makefile):
>> sound/oss/Makefile:obj-$(CONFIG_SOUND_BT878)    += btaudio.o
>>
>> 	For SAA7134 and CX88, all are under Multimedia/V4L. All
>> OSS/ALSA/DVB/MPEG options are under the driver name.
>>
>> 	IMHO, from users perspective, it makes much more sense if all BTTV
>> moules (even sound ones) being under bttv video driver. Current module
>> allows using audio driver without video, but this doesn't make sense,
>> since audio will be only available, in practice, after selecting a
>> video/audio input or tuning a channel. These functionalities are
>> provided by bttv. So, we could even disable audio modules if bttv were
>> not compiled.
>>
>> 	Also, bug 5995 showed a problem when user have a bttv card and dvb is
>> also probed. dvb also handles audio, so, currently, it is mutually
>> exclusive with snd-bt87x audio.
>>
>> 	So, my proposal is to move sound/snd-bt87x.ko to drivers/media, moving
>> also its menu, and moving tvmixer menu also. After it, should move some
>> related code at bttv dvb modules, to reduce or eliminate mutually
>> exclusiveness between the two. 
>>
>> 	We might keep supporting btaudio, but I think this is already obsoleted
>> by alsa one, so, IMHO, we can just drop it. We intend to do the same
>> with saa7134-oss after some time (kernel 2.6.15 is the first with this
>> module, so we may remove it on 2.6.18 to give some time for testing).
>>     
>
> Which directory do you suppose exactly?  drivers/media/tv (or
> something like that), or existing one like drivers/media/video?
>   

Since we have the majority of existing bttv code in drivers/media/video, 
i was planning to move some existing dvb code into drivers/media/video. 
If we have alsa code also in the same place, we can have a consolidation 
of code, might be easier to go through the code, but that is my personal 
opinion, but having code related to one chip in one place might make it 
look better probably..


Manu

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
