From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Driver for daisy-chained AD1938 audio codecs?
Date: Wed, 12 Oct 2011 11:13:24 +0200
Message-ID: <4E955A34.3020608@metafoo.de>
References: <CAGrmWbz8v=NoLnQcmBUyiBX=p43UX2o0jOZyf6eWZJtWE9ygtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-103.synserver.de (smtp-out-126.synserver.de
	[212.40.185.126])
	by alsa0.perex.cz (Postfix) with SMTP id 0CDC2103921
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 11:13:26 +0200 (CEST)
In-Reply-To: <CAGrmWbz8v=NoLnQcmBUyiBX=p43UX2o0jOZyf6eWZJtWE9ygtA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: steve.strobel@link-comm.com
Cc: alsa-devel@alsa-project.org, Steve Strobel <steve.strobel3@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/11/2011 06:04 PM, Steve Strobel wrote:
> I am considering a Blackfin DSP hardware design which would need eight
> channels of audio input/output. I haven't been able to find a single
> audio codec with more than six input channels, so I am looking at
> daisy-chaining AD1938 codecs as described on page 19 of its datasheet
> [1].
> 
> In the past I worked on a prototype that used two AD1938 chips on
> separate SPORT interfaces. It worked, but having to deal with two ALSA
> sound devices made the software relatively complicated (error
> recovery, synchronization, etc). It would be nice if all of the
> channels appeared as a single ALSA device.  I believe that
> daisy-chained AD1938 chips would work that way, but I haven't found an
> ALSA driver for that configuration.
> Does such a driver already exist?  Any suggestions for making one?
> Thanks for any input.
> Steve
> [1] - http://www.analog.com/static/imported-files/data_sheets/AD1938.pdf


Hi,

the existing driver should work fine, at least for daisy-chained ADCs.
Just setup the number of TDM slots using snd_soc_dai_set_tdm_slot. You'll
need to register one of the codecs as primary codec and the other as an
auxdev in your snd_soc_card structure.

- Lars
