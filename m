From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Unable to play MP3 using TinyCompress and
 bytcr-rt5640
Date: Wed, 30 Aug 2017 14:40:06 -0500
Message-ID: <7aee5c90-e2aa-1f67-39a1-48868784eb9c@linux.intel.com>
References: <CAOmiHe+qmw34f_-yTqj6zy96bLXyGntd4qLAiQ8Aimmh5+rH=Q@mail.gmail.com>
 <8f328187-c23c-618c-3d62-73e6643a3e60@linux.intel.com>
 <CAOmiHeJRLDix5A_2--HEihKic3jifLxSeSi-kyr=NSCNFCxhBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E95892665D5
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 21:40:10 +0200 (CEST)
In-Reply-To: <CAOmiHeJRLDix5A_2--HEihKic3jifLxSeSi-kyr=NSCNFCxhBg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lambdadroid <lambdadroid@gmail.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/30/17 2:31 PM, Lambdadroid wrote:
> On Wed, Aug 30, 2017 at 9:20 PM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> The firmware available upstream does not contain MP3/AAC or proprietary
>> libraries due to redistribution rights. Some of patents may start to expire
>> soon but in general we steer clear of such components for freely available
>> binary firmware. Not my choice btw, this is a minefield that's all too
>> common for all open-source projects.
>>
>> The benefits of mp3 offload on Baytrail are quite limited anyway due to
>> internal SoC design choices, I wouldn't recommend you pursue this work if
>> power optimization was the goal. Offload was mostly used for Medfield,
>> Clovertrail, Merrifield and Anniedale platforms.
>>
> 
> Alright, thanks a lot for letting me know! I was mostly just curious
> if it works when I saw that it's (theoretically) supported on
> bytcr-rt5640. Is there any way to check if the firmware supports it
> from the kernel side? It would be helpful if either the compressed
> ALSA device wasn't even available or if there was at least a readable
> error when attempting to use it. It's quite confusing when it appears
> to be supported but it isn't working and other people might run into
> this issue as well.

Agree, I just don't think the kernel can know what the contents of the 
firmware is, it's mostly opaque.

For more recent firmware based on the topology this sort of problems 
should go away, the streams exposed to userpace are not hard-coded in 
the kernel and if one tried to enable/configure a component that's not 
part for the firmware you would get an error.
