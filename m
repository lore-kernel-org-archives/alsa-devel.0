From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Memory and Cycles overhead in <snd_soc_init>
Date: Tue, 10 Feb 2015 17:50:51 +0100
Message-ID: <54DA36EB.7010007@metafoo.de>
References: <CAJWVF-wkq5xdH0WqOj+rWk4UEO4aZCcuv5JthvtDkEh8spDiaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-117.synserver.de (smtp-out-117.synserver.de
 [212.40.185.117])
 by alsa0.perex.cz (Postfix) with ESMTP id C7E7626151C
 for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2015 17:50:54 +0100 (CET)
In-Reply-To: <CAJWVF-wkq5xdH0WqOj+rWk4UEO4aZCcuv5JthvtDkEh8spDiaA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bhaskara rao Budiredla <bhaskarbudiredla@gmail.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On 02/10/2015 12:58 PM, Bhaskara rao Budiredla wrote:
> Hi - May I know the purpose of the call to snd_soc_init( ) from kernel_init
> thread? snd_soc_init( ) is trying to register a dummy platform device
> "snd-soc-dummy" containing (dummy_codec/dummy_platform) and a sound card
> device. Neither of those devices are added to platform bus before they are
> making a call to platform_driver_register( ). Due to that platform_match(
> ) will fail and they will not be added to platform bus . Thus,
> snd_soc_init( ) is not doing any useful task during kernel boot time.
>
> Could someone help me if my understanding is correct? If I am correct,
> shall we remove the call to snd_soc_init( ) in kernel_init thread to save
> boot time and memory? Otherwise please suggest me where those dummy devices
> and sound card gets added to platform bus and the purpose of creating them?

All of the devices and driver registered in snd_soc_init() are used.

- Lars
