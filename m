From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: New dapm panic on beaver with next-20130730
Date: Wed, 31 Jul 2013 13:09:55 -0600
Message-ID: <51F96103.6000603@wwwdotorg.org>
References: <CAOesGMig6jry1GJLoTnOqxom1KjtBTUtZz-_-SiZLpGTc3VkqA@mail.gmail.com>
 <51F8A933.4080708@metafoo.de>
 <CAOesGMjqyF7zPoGsW6oBRFey7Bc_umnoGob7oQ=_c3n7oevuaQ@mail.gmail.com>
 <51F8B045.8030303@metafoo.de> <20130731103610.GH9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 352A62610D2
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 21:10:00 +0200 (CEST)
In-Reply-To: <20130731103610.GH9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Olof Johansson <olof@lixom.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 07/31/2013 04:36 AM, Mark Brown wrote:
> On Wed, Jul 31, 2013 at 08:35:49AM +0200, Lars-Peter Clausen
> wrote:
> 
>> 0x6b6b6b6b is poisoned freed memory. According to the source
>> neither the INR Mux nor the INL Mux widget should have any sinks.
>> Can you add a couple more printks:
> 
> Dan Carpenter sent a patch which is probably the issue - I'm trying
> to figure out how to boot my Beaver board so hopefully I can test,
> it'll be in -next tomorrow anyway.

I assume that is "[patch] ASoC: dapm: using freed pointer in
dapm_kcontrol_add_widget()". That doesn't fix the issue. Do you need
me to debug any further?
