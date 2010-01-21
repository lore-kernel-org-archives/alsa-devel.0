From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 0/5] Add Voice Codec support for DaVinci
	platforms
Date: Thu, 21 Jan 2010 13:18:43 -0600
Message-ID: <4B58A893.1050804@ridgerun.com>
References: <4B58904E.4030108@ridgerun.com>
	<1264099975.3207.176.camel@linux-1lbu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 696592450B
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 20:22:03 +0100 (CET)
In-Reply-To: <1264099975.3207.176.camel@linux-1lbu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Chen <schen@mvista.com>
Cc: Santiago Nunez <santiago.nunez@ridgerun.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, clarkbecker <clark.becker@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

Steve,

I'm not sure that this is the same case, please take a look into this thread 
between Mark and me, where I pointed the problem in the machine driver for 
handling the two codecs:

 >Hi Mark,
 >
 >I have a specific doubt about the codec_dev element snd_soc_device struct of
 >the DM365 EVM.
 >
 >Since I have two codecs on the EVM, I have two snd_soc_codec_device structures:
 >
 > * AIC3x
 >
 > struct snd_soc_codec_device soc_codec_dev_aic3x = {
 >    .probe = aic3x_probe,
 >    .remove = aic3x_remove,
 >    .suspend = aic3x_suspend,
 >    .resume = aic3x_resume,
 >};
 >
 >* Voice Codec
 >
 >struct snd_soc_codec_device soc_codec_dev_cq93vc = {
 >    .probe = cq93vc_probe,
 >    .remove = cq93vc_remove,
 >    .suspend = cq93vc_suspend,
 >    .resume = cq93vc_resume,
 >};
 >
 >But I can set only one at a time in the dm365_evm_snd_devdata:
 >
 >/* evm audio subsystem */
 >static struct snd_soc_device dm365_evm_snd_devdata = {
 >    .card = &dm365_snd_soc_card_evm,
 >***
 >    .codec_dev = &soc_codec_dev_aic3x,
 >or
 >    .codec_dev = &soc_codec_dev_cq93vc,
 >***
 >    .codec_data = &aic3x_setup,
 >};
 >
 >So in case what is the proper way to do this?
 >
 >Thanks,
 >
 >Miguel Aguilar


Mark's answer:

On Tue, Jan 19, 2010 at 02:47:16PM -0600, Miguel Aguilar wrote:

 > > But I can set only one at a time in the dm365_evm_snd_devdata:

 > > ...

 > > So in case what is the proper way to do this?

 >For now use an ifdef in the machine driver.  There's some work due to
 >begin fairly shortly (I've CCed in my co-maintainer Liam who's actually
 >going to be doing the work) to allow multiple CODECs to work
 >simultaneously, if you put the ifdef in the machine driver now then it
 >should be straightforward to update the machine driver to make use of
 >this new feature when it's ready.

Regards,
Miguel Aguilar

Steve Chen wrote:
> On Thu, 2010-01-21 at 11:35 -0600, Miguel Aguilar wrote:
>> Hi,
>>
>> The following patch series adds support for the Voice Codec in the Davinci 
>> platform and in this particular case for the DM365 EVM.
>>
>> The DM365 EVM has two codecs the AIC3x and the Voice Codec, however at this 
>> point is not possible to have both enabled simultaneously since the soc-core 
>> doesn't support that, so a patch for enable both simultaneously will be sent 
>> when this support is available in the soc-core.
> 
> I thought, perhaps incorrectly, that soc-core already has the ability to
> support multiple codecs.  When I worked on ALSA soc support for DM6467,
> one of the McASP was connected to AIC3x and the other is SPDIF output.
> Both interface can work at the same time.  I just assumed that if we
> have two  McASP (or other audio controllers) connected to two codecs.
> They would both just work under ALSA soc.  Please let me know if I'm
> mistaken.
> 
> Thanks,
> 
> Steve
> 
