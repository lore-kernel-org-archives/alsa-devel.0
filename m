From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: Max98090 Codec DAPM Widget setup in Open
	Embedded
Date: Tue, 24 Mar 2015 08:26:59 +0100
Message-ID: <551111C3.3000704@metafoo.de>
References: <CAES_P+9kc9Q6TR7e1rdjV8cWHGWJs9bHoMLOz0Z0iHaYZbqpQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-168.synserver.de (smtp-out-168.synserver.de
 [212.40.185.168])
 by alsa0.perex.cz (Postfix) with ESMTP id EE07E260564
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 08:27:05 +0100 (CET)
In-Reply-To: <CAES_P+9kc9Q6TR7e1rdjV8cWHGWJs9bHoMLOz0Z0iHaYZbqpQw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>, tiwai@suse.de, perex@perex.cz
Cc: alsa-user@lists.sourceforge.net, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, omer.job@gmail.com
List-Id: alsa-devel@alsa-project.org

On 03/24/2015 07:54 AM, noman pouigt wrote:
> On Mon, Mar 23, 2015 at 11:53 PM, noman pouigt <variksla@gmail.com> wrote:
>>> I would like to know which file I can use to connect/enable
>>> DPAM widgets permanently so a simple aplay/record can work?
>>>
>>> My environment is:
>>> - Yocto Linux Kernel 3.10 - (DTS based)
>>> - Max98090 Codec
>>> - imx6SL SoC
>>>
>>> I thought about doing this in alsa.conf or asound.conf but I couldn't
>>> find a single example with DAPM widgets .
>>
>> I am also stuck with the same problem. I am sure ALSA experts
>> can help here.
>>
>> What i want to know is how to set the dapm widgets in open
>> embedded? Is it alsa.conf or asound.conf ?
>>
>> I need to set something like this:
>> amixer cset  name="LEFT MIXER DAC" 1
>>
>> Using amixer i am able to playback but i don't know how can i
>> modify conf file to have this dapm widgets associated with
>> a device.
>>
>> Any example would suffice.

Hi,

The whole point of DAPM (dynamic audio power management) is that you don't 
have to manually power up or down a widget. Userspace configures the routing 
of the audio paths and the kernel automatically detects which parts of the 
chip need to be powered up for the current routing configuration.

Why do you want to manually enable a widget?

- Lars
