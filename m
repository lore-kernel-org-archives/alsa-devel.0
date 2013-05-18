From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: dfbmcs320: make the driver common
 for other BT modules
Date: Sat, 18 May 2013 13:32:39 +0200
Message-ID: <519766D7.9080802@metafoo.de>
References: <1368757177-15372-1-git-send-email-Baohua.Song@csr.com>
 <20130517111523.GM1627@sirena.org.uk>
 <CAGsJ_4zjgLhNOiwGcTjvC6dP2XPqnmjzWF12pVPomU-ERH6YYg@mail.gmail.com>
 <20130518112505.GS1627@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-195.synserver.de (smtp-out-195.synserver.de
 [212.40.185.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 244D7260319
 for <alsa-devel@alsa-project.org>; Sat, 18 May 2013 13:33:01 +0200 (CEST)
In-Reply-To: <20130518112505.GS1627@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, lgirdwood@gmail.com, workgroup.linux@csr.com, Graeme Gregory <graeme@openmoko.org>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 05/18/2013 01:25 PM, Mark Brown wrote:
> On Sat, May 18, 2013 at 07:03:24PM +0800, Barry Song wrote:
>> 2013/5/17 Mark Brown <broonie@kernel.org>:
> 
>>> Otherwise this looks OK for ASoC though I'd expect to see a change to
>>> registration of the OpenMoko BT device (perhaps I missed it though).
> 
>> sorry. i don't understand. i would think OpenMOKO can also use this driver?
> 
> If you change the names the driver uses to bind you need to also update
> the users so that they use the new name.
> 

Since there's the platform_device_id table now this should not be necessary.
