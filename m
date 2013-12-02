From: VS <vasan.vs@gmail.com>
Subject: MAXIM 98089 codec support in Linux
Date: Mon, 2 Dec 2013 10:46:36 +0000 (UTC)
Message-ID: <loom.20131202T114044-425@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id CF30226260F
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 11:50:11 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1VnR4n-00067q-0S
 for alsa-devel@alsa-project.org; Mon, 02 Dec 2013 11:50:09 +0100
Received: from 202.141.25.2 ([202.141.25.2])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 02 Dec 2013 11:50:05 +0100
Received: from vasan.vs by 202.141.25.2 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 02 Dec 2013 11:50:05 +0100
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

Hi,

We are trying to integrate MAXIM 98089 (Audio codec) into our Linux product
build. This has 2 DAI's available with it - DAI1 with both Playback and
Capture facility and DAI2 with Playback capability alone.

When we use this codec in our build, we find that the dai1_hw_params and
dai1_set_fmt functions never gets called but it is always dai2_hw_params and
dai2_set_fmt function that gets called because of which apparently, we are
able to hear the voice that is incoming but not able to capture the voice
and send it out externally.

Here are our definitions:

static struct snd_soc_dai_driver max98089_dai[] = {
{
        .name = "max98089.0",
                .playback = {
                .stream_name = "Playback",
                .channels_min = 1,
                .channels_max = 2,
                .rates = MAX98089_RATES,
                .formats = MAX98089_FORMATS,
                },
        .capture = {
                .stream_name = "Capture",
                .channels_min = 1,
                .channels_max = 2,
                .rates = MAX98089_RATES,
                .formats = MAX98089_FORMATS,
        },
         .ops = &max98089_dai1_ops,
},
{
        .name = "max98089.1",
        .playback = {
                .stream_name = "Aux Playback",
                .channels_min = 1,
                .channels_max = 2,
                .rates = MAX98089_RATES,
                .formats = MAX98089_FORMATS,
        },
        .ops = &max98089_dai2_ops,
        .symmetric_rates = 1,
}
};

The codec specific registers only when we put in dai2_ops functions, we are
able to see the effects but there is no effect if we put it in dai1_ops
functions.

Is there any specific way of referring to DAI when we have multiple DAI
support in the codec that we are using?

Thanks in advance for your inputs

VS
