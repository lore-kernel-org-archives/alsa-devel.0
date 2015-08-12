From: Matt Campbell <mcampbell@izotope.com>
Subject: Questions about ASoC driver implementation
Date: Wed, 12 Aug 2015 10:01:22 -0400
Message-ID: <CAMDowVVj26LdUz5hgp6J9kfB=g5gEfq1L_ycGbHymEYJ-_k+MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 57D39260438
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 16:01:24 +0200 (CEST)
Received: by ykdt205 with SMTP id t205so14458643ykd.1
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 07:01:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

I'm diving into adding support for a new codec (AK4621) targeting IMX6 SoC
and as this is my first dive into ALSA driver code (and first deep dive in
to Linux driver development) I've come up with a few questions. I've done a
lot of digging in available documentation as well as reading a lot of code,
but some things remain unclear.

First, I'm a little confused with what appears to be inconsistent
terminology. The SoC overview.txt lists three types of component drivers:
codec, platform and machine. However, in the code there are four types of
snd_soc_register_* functions: card, platform, codec and component. From
looking at the underlying structs and how these are used in existing code
this is my best guess but please correct me if I'm wrong:

codec -> snd_soc_register_codec
machine -> snd_soc_register_card
platform -> snd_soc_register_component and snd_soc_register_platform? (not
sure about this, from what I can gather at some point there was an API
switch to using component rather than platforms for the DAIs)

My second question is around adding support for an amplifier external to
the codec. The amplifier is a PGA controlled over SPI. One possible way I
can see to adding this is to create a SPI based codec driver for the PGA
that exposes an ALSA control for the gain level and give it a dummy DAI
then add it to the card as an aux_dev. This feels a little kludgy as the
PGA isn't a perfect fit for the codec class.

Another option would be to have PGA driver separate from the ASoC
framework, add the controls for the gain level directly in the ASoC card
and put the glue code to interact with the device in the machine driver.
This feels somewhat better to me, but has two problems. First, I don't know
the best way to interact with the external PGA driver from the machine
driver. Second, this leaves the PGA driver outside of the ASoC framework,
If it was in ASoC it could be useful for others that come across this chip
when writing machine drivers.

Sorry for the long email, but there has been a bit of a learning curve up
front. I tried to do my best with documentation and code reading before
coming to the mailing list. I'll greatly appreciate any help the community
can offer and look forward to contributing to the ALSA project.

Best,
~Matt
