From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH v2] [media] media-device: use kref for media_device
 instance
Date: Mon, 21 Mar 2016 07:42:34 -0600
Message-ID: <56EFFA4A.6040002@osg.samsung.com>
References: <9d8830150475bc4d4dde2fa1f5163aef82a35477.1458347578.git.mchehab@osg.samsung.com>
 <3052381.o5ho2okSRi@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <3052381.o5ho2okSRi@avalon>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hans Verkuil <hans.verkuil@cisco.com>, Javier Martinez Canillas <javier@osg.samsung.com>, =?UTF-8?Q?Rafael_Louren=c3=a7o_de_Lima_Chehab?= <chehabrafael@gmail.com>, alsa-devel@alsa-project.org, Shuah Khan <shuahkh@osg.samsung.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2016 05:10 AM, Laurent Pinchart wrote:
> Hi Mauro,
> 
> Thank you for the patch.
> 
> On Friday 18 Mar 2016 21:42:16 Mauro Carvalho Chehab wrote:
>> Now that the media_device can be used by multiple drivers,
>> via devres, we need to be sure that it will be dropped only
>> when all drivers stop using it.
> 
> I've discussed this with Shuah previously and I'm surprised to see that the 
> problem hasn't been fixed : using devres for this purpose is just plain wrong. 
> The empty media_device_release_devres() function should have given you a hint.
> 
> What we need instead is a list of media devices indexed by struct device (for 
> this use case) or by struct device_node (for DT use cases). It will both 
> simplify the code and get rid of the devres abuse.
> 
> Shuah, if I recall correctly you worked on implementing such a solution after 
> our last discussion on the topic. Could you please update us on the status ?
> 

It is work in progress. I have a working prototype for au0828 which is an easier
case. I am working on resolving a couple of issues to differentiate media devices
allocated using the global media device list vs. the ones embedded in the driver
data structures. We have many of those.

I had to put this work on the back burner to get the au0882 and snd-usb-audio
wrapped up. I can get the RFC patches on top of the au0882 and snd-usb-audio.
We can discuss them at the upcoming media summit.

> In the mean time, let's hold off on this patch, and merge a proper solution 
> instead.

I think Mauro's restructure helps us with such differentiation and it will be
easy enough to change out devres to get media get API.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
