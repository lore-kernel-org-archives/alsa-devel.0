From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 5/6] sound/usb: pcm changes to use media
 token api
Date: Wed, 22 Oct 2014 14:26:41 -0500
Message-ID: <544804F1.7090606@linux.intel.com>
References: <cover.1413246370.git.shuahkh@osg.samsung.com> <cf1059cc2606f20d921e5691e3d59945a19a7871.1413246372.git.shuahkh@osg.samsung.com> <543FB374.8020604@metafoo.de> <543FC3CD.8050805@osg.samsung.com> <s5h38aow1ub.wl-tiwai@suse.de> <543FD1EC.5010206@osg.samsung.com> <s5hy4sgumjo.wl-tiwai@suse.de> <543FD892.6010209@osg.samsung.com> <s5htx34ul3w.wl-tiwai@suse.de> <54467EFB.7050800@xs4all.nl> <s5hbnp5z9uy.wl-tiwai@suse.de> <CAGoCfixD-zv1MMHUXLnjGV5KVB-DGdp2ZqZ0hUTR14UvLh-Gvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGoCfixD-zv1MMHUXLnjGV5KVB-DGdp2ZqZ0hUTR14UvLh-Gvw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Devin Heitmueller <dheitmueller@kernellabs.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Linux Media Mailing List <linux-media@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "ramakrmu@cisco.com" <ramakrmu@cisco.com>, Shuah Khan <shuahkh@osg.samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, Sander Eikelenboom <linux@eikelenboom.it>, prabhakar.csengg@gmail.com, Antti Palosaari <crope@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Tim Gardner <tim.gardner@canonical.com>, "olebowle@gmx.com" <olebowle@gmx.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 10/21/14, 11:08 AM, Devin Heitmueller wrote:
>> Sorry, I'm not convinced by that.  If the device has to be controlled
>> exclusively, the right position is the open/close.  Otherwise, the
>> program cannot know when it becomes inaccessible out of sudden during
>> its operation.
>
> I can say that I've definitely seen cases where if you configure a
> device as the "default" capture device in PulseAudio, then pulse will
> continue to capture from it even if you're not actively capturing the
> audio from pulse.  I only spotted this because I had a USB analyzer on
> the device and was dumbfounded when the ISOC packets kept arriving
> even after I had closed VLC.

this seems like a feature, not a bug. PulseAudio starts streaming before 
clients push any data and likewise keeps sources active even after for 
some time after clients stop recording. Closing VLC in your example 
doesn't immediately close the ALSA device. look for 
module-suspend-on-idle in your default.pa config file.
I also agree that the open/close of the alsa device is the only way to 
control exclusion.
-Pierre
