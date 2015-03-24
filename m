From: Variksla <variksla@gmail.com>
Subject: Re: ASoC: Max98090 Codec DAPM Widget setup in Open
	Embedded
Date: Tue, 24 Mar 2015 09:02:40 -0700
Message-ID: <1BBF0420-296C-435B-9208-5939803DAD57@gmail.com>
References: <CAES_P+9kc9Q6TR7e1rdjV8cWHGWJs9bHoMLOz0Z0iHaYZbqpQw@mail.gmail.com>
 <551111C3.3000704@metafoo.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 0598926047A
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 17:02:43 +0100 (CET)
Received: by pdbni2 with SMTP id ni2so225490817pdb.1
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 09:02:42 -0700 (PDT)
In-Reply-To: <551111C3.3000704@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "omer.job@gmail.com" <omer.job@gmail.com>
List-Id: alsa-devel@alsa-project.org





> On Mar 24, 2015, at 12:26 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> On 03/24/2015 07:54 AM, noman pouigt wrote:
>> On Mon, Mar 23, 2015 at 11:53 PM, noman pouigt <variksla@gmail.com> wrote:
>>>> I would like to know which file I can use to connect/enable
>>>> DPAM widgets permanently so a simple aplay/record can work?
>>>> 
>>>> My environment is:
>>>> - Yocto Linux Kernel 3.10 - (DTS based)
>>>> - Max98090 Codec
>>>> - imx6SL SoC
>>>> 
>>>> I thought about doing this in alsa.conf or asound.conf but I couldn't
>>>> find a single example with DAPM widgets .
>>> 
>>> I am also stuck with the same problem. I am sure ALSA experts
>>> can help here.
>>> 
>>> What i want to know is how to set the dapm widgets in open
>>> embedded? Is it alsa.conf or asound.conf ?
>>> 
>>> I need to set something like this:
>>> amixer cset  name="LEFT MIXER DAC" 1
>>> 
>>> Using amixer i am able to playback but i don't know how can i
>>> modify conf file to have this dapm widgets associated with
>>> a device.
>>> 
>>> Any example would suffice.
> 
> Hi,
> 
> The whole point of DAPM (dynamic audio power management) is that you don't have to manually power up or down a widget. Userspace configures the routing of the audio paths and the kernel automatically detects which parts of the chip need to be powered up for the current routing configuration.
> 
> Why do you want to manually enable a widget?

In android we have ucm files where dapm routings are associated with each device. Same way where can I list down dapm routings in open embedded?
We know that user space gives the routings but we need to associate each device with certain set of dapm routes so i am looking for a place where we can list down dapm routes which gets triggered when a specific device is chosen for playback or recording. Something analogous to ucm files in open embedded? I couldn't find a way to associate dapm routes with a specific device in conf files. Can we use Asound.conf for this purpose?
> 
> - Lars
> 
