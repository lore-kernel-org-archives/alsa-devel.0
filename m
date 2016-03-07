From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH v5 22/22] sound/usb: Use Media Controller API to share
 media resources
Date: Mon, 7 Mar 2016 13:03:47 -0700
Message-ID: <56DDDEA3.4010600@osg.samsung.com>
References: <1456937431-3794-1-git-send-email-shuahkh@osg.samsung.com>
 <20160305070055.6e17edcd@recife.lan> <56DD8D4A.1070901@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <56DD8D4A.1070901@osg.samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: tiwai@suse.com, clemens@ladisch.de, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com, javier@osg.samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, perex@perex.cz, arnd@arndb.de, dan.carpenter@oracle.com, tvboxspy@gmail.com, crope@iki.fi, ruchandani.tina@gmail.com, corbet@lwn.net, chehabrafael@gmail.com, k.kozlowski@samsung.com, stefanr@s5r6.in-berlin.de, inki.dae@samsung.com, jh1009.sung@samsung.com, elfring@users.sourceforge.net, prabhakar.csengg@gmail.com, sw0312.kim@samsung.com, p.zabel@pengutronix.de, ricardo.ribalda@gmail.com, labbott@fedoraproject.org, pierre-louis.bossart@linux.intel.com, ricard.wanderlof@axis.com, julian@jusst.de, takamichiho@gmail.com, dominic.sacre@gmx.de, misterpib@gmail.com, daniel@zonque.org, gtmkramer@xs4all.nl, normalperson@yhbt.net, joe@oampo.co.uk, linuxbugs@vittga
List-Id: alsa-devel@alsa-project.org

On 03/07/2016 07:16 AM, Shuah Khan wrote:
> On 03/05/2016 03:00 AM, Mauro Carvalho Chehab wrote:
>> Em Wed,  2 Mar 2016 09:50:31 -0700
>> Shuah Khan <shuahkh@osg.samsung.com> escreveu:
>>
>>> Change ALSA driver to use Media Controller API to
>>> share media resources with DVB and V4L2 drivers
>>> on a AU0828 media device. Media Controller specific
>>> initialization is done after sound card is registered.
>>> ALSA creates Media interface and entity function graph
>>> nodes for Control, Mixer, PCM Playback, and PCM Capture
>>> devices.
>>>
>>> snd_usb_hw_params() will call Media Controller enable
>>> source handler interface to request the media resource.
>>> If resource request is granted, it will release it from
>>> snd_usb_hw_free(). If resource is busy, -EBUSY is returned.
>>>
>>> Media specific cleanup is done in usb_audio_disconnect().
>>>
>>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>>> Acked-by: Takashi Iwai <tiwai@suse.de>
>>
>> Shuah, by looking at the produced graphs:
>> 	https://mchehab.fedorapeople.org/mc-next-gen/au0828_test/
>>
>> I'm noticing the lack of ALSA I/O entities in the diagram
>> (MEDIA_ENT_F_AUDIO_CAPTURE). The mixer there is not connected.
>>
>> Could you please check what's happening?
> 
> Mauro,
> 
> Did you pull in this patch that fixes the graph problem:
> 
> https://www.mail-archive.com/linux-media@vger.kernel.org/msg95047.html
> 
> If you haven't, could you please pull this in.
> 

You do have the above patch in the latest linux_media
git. I couldn't reproduce the problem you are seeing.

Here is what I did.
- Blacklisted au0828 and forcing snd_usb_audio
  probe first. Then I generated a graph that shows just
  the audio nodes.
- And then did a modprobe and generated full graph.

https://drive.google.com/folderview?id=0B0NIL0BQg-AlejFpR19Cb1RGYVk&usp=drive_web

I see that in you graph, mixer gets connected to decoder, but the rest
of the audio nodes are missing from the graph.

MEDIA_ENT_F_AUDIO_CAPTURE gets created from  snd_usb_pcm_open()
and gets deleted from free_substream(). Is it possible, for
some reason, either snd_usb_pcm_open() fails or free_substream()
is called?


thanks,
-- Shuah


-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
