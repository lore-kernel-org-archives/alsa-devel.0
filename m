From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Memory and Cycles overhead in <snd_soc_init>
Date: Wed, 11 Feb 2015 13:47:22 +0100
Message-ID: <54DB4F5A.9060603@metafoo.de>
References: <CAJWVF-wkq5xdH0WqOj+rWk4UEO4aZCcuv5JthvtDkEh8spDiaA@mail.gmail.com>	<54DA36EB.7010007@metafoo.de>
 <CAJWVF-zH=L3wtQRtQDh1hkWH=YqmAJtJ9HoEpNXO=1VZZpJxgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-161.synserver.de (smtp-out-161.synserver.de
 [212.40.185.161])
 by alsa0.perex.cz (Postfix) with ESMTP id 40B592605DF
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 13:47:22 +0100 (CET)
In-Reply-To: <CAJWVF-zH=L3wtQRtQDh1hkWH=YqmAJtJ9HoEpNXO=1VZZpJxgg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bhaskara rao Budiredla <bhaskarbudiredla@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/11/2015 10:40 AM, Bhaskara rao Budiredla wrote:
> Thanks Lars for the help. Could you please tell me the use case for those
> devices and drivers creation? Even pointing to the code snippet is helpful.

The soc-audio platform driver is used by some board drivers which register 
the matching platform device. Just grep for soc-audio. And both the 
snd-soc-dummy driver and device are registered in snd_soc_util_init(). So 
the device should actually bind immediately. Both the dummy codec and the 
dummy platform are sue by some DPCM platforms. Again just grep for them to 
find the examples.

I'm not sure what this discussion is about. Registering the devices and 
drivers should talk up a pretty much insignificant slice of the whole boot 
time, so I don't understand why you want to remove this.

- Lars

> Thanks,
> Bhaskara
> On Tue, Feb 10, 2015 at 10:20 PM, Lars-Peter Clausen <lars@metafoo.de
> <mailto:lars@metafoo.de>> wrote:
>
>     On 02/10/2015 12:58 PM, Bhaskara rao Budiredla wrote:
>
>         Hi - May I know the purpose of the call to snd_soc_init( ) from
>         kernel_init
>         thread? snd_soc_init( ) is trying to register a dummy platform device
>         "snd-soc-dummy" containing (dummy_codec/dummy_platform) and a sound card
>         device. Neither of those devices are added to platform bus before
>         they are
>         making a call to platform_driver_register( ). Due to that
>         platform_match(
>         ) will fail and they will not be added to platform bus . Thus,
>         snd_soc_init( ) is not doing any useful task during kernel boot time.
>
>         Could someone help me if my understanding is correct? If I am correct,
>         shall we remove the call to snd_soc_init( ) in kernel_init thread to
>         save
>         boot time and memory? Otherwise please suggest me where those dummy
>         devices
>         and sound card gets added to platform bus and the purpose of
>         creating them?
>
>
>     All of the devices and driver registered in snd_soc_init() are used.
>
>     - Lars
>
>
> .
