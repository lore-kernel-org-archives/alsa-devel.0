From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: Two codecs on a single CPU DAI
Date: Tue, 20 May 2014 15:46:12 +0200
Message-ID: <537B5CA4.8010607@metafoo.de>
References: <537B53C9.6000900@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-133.synserver.de
 [212.40.185.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 4440A261ADE
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 15:46:16 +0200 (CEST)
In-Reply-To: <537B53C9.6000900@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 05/20/2014 03:08 PM, Petr Kulhavy wrote:
> Hi,
>
> I'm writing a driver for a custom DaVinci board, which has two codecs
> (Wolfson and STA323 amplifier) connected to the same CPU DAI. The intention
> is that both codecs always play the same audio, only the volume/mixer
> settings are controlled separately. In addition to that the design is
> atypical by the fact, that the Wolfson is the clock master. So in order to
> play audio on the amplifier the Wolfson must be initialized as well.
>
> My question is: how to reflect this architecture in a SOC platform driver?
>
> As the first approach I tried to create two DAI links, one for each codec.
> That worked if audio was first played on the Wolfson link (clock master was
> initialized) and then on the second link, using the same sampling rate.
>
> But in fact I would need only one DAI link to both. So then I tried to make
> just one link to Wolfson and put the amplifier as an "aux_dev". However
> there I need to set hw_params and format for the amplifier codec DAI and
> those functions were not called. In fact there was no codec DAI created for
> the amplifier. I've also seen that one can define rtd_aux runtimes, but have
> nowhere found how to use it.
>
> Could someone please help me?

Hi,

Benoit is currently working on adding support for this to the ASoC 
framework, see this patch series: 
http://comments.gmane.org/gmane.linux.alsa.devel/122160

- Lars
