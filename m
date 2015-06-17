From: Jarkko Nikula <jarkko.nikula@intel.com>
Subject: Re: writing an alsa driver
Date: Wed, 17 Jun 2015 09:39:24 +0300
Message-ID: <5581161C.1060508@intel.com>
References: <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>	
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>	
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>	
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>	
 <20150608084951.GA7512@dellaz> <loom.20150613T153708-781@post.gmane.org>	
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AF8F265AB3
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 08:39:31 +0200 (CEST)
In-Reply-To: <1434387868.2434.50.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Michele Curti <michele.curti@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, Luka Karinja <luka.karinja@gmail.com>, "Koul, Vinod" <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On 06/15/2015 08:04 PM, Liam Girdwood wrote:
> We are also a little suspicious that this laptop is using SSP1 for the
> I2S audio connection to the codec. The bad news is that the FW used by
> this BYT ADSP driver does not support the SSP1 port. It's hard coded to
> use SSP0 (Jarrko, please correct the port numbering if it's wrong).
> There are going to be no further releases of this FW.
>
That firmware is hardcoded for SSP2, i.e. 3rd port and low-pin count 
Baytrail packages have only 2 SSP ports. Obviously machines using those 
variants have to use either SSP0 or SSP1.

Please see pages 29-30 for Baytrail package differences:
https://www-ssl.intel.com/content/www/us/en/processors/atom/atom-z36xxx-z37xxx-datasheet-vol-1.html

-- 
Jarkko
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
