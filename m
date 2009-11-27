From: "A. Porodko" <panda@chelcom.ru>
Subject: Re: [alsa-devel] Sound support for Neuros OSD2 Davinci based board.
Date: Fri, 27 Nov 2009 18:14:26 +0500
Message-ID: <4B0FD0B2.9070303@chelcom.ru>
References: <4B0E7D5E.3080906@chelcom.ru> <002e01ca6e9c$2dab6040$890220c0$@com> <20091127111254.GB29512@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752265AbZK0NZb@vger.kernel.org>
In-Reply-To: <20091127111254.GB29512@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Chaithrika U S <chaithrika@ti.com>, 'Liam Girdwood' <lrg@slimlogic.co.uk>, 'Jaroslav Kysela' <perex@perex.cz>, 'Takashi Iwai' <tiwai@suse.de>, 'Troy Kisky' <troy.kisky@boundarydevices.com>, 'David Brownell' <dbrownell@users.sourceforge.net>, 'Kevin Hilman' <khilman@deeprootsystems.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Nov 26, 2009 at 06:57:19PM +0530, Chaithrika U S wrote:
>
>   
>> @@ -246,6 +249,9 @@ static int __init evm_init(void)
>>  	if (machine_is_davinci_evm()) {
>>  		evm_snd_dev_data = &evm_snd_devdata;
>>  		index = 0;
>> +	} else if (machine_is_neuros_osd2()) {
>> +		evm_snd_dev_data = &evm_snd_devdata;
>> +		index = 0;
>>     
>
>   
>> The above can be combined with the check for DaVinci EVM
>> 	if (machine_is_davinci_evm() ||
>> 				(machine_is_neuros_osd2()) {
>>  		evm_snd_dev_data = &evm_snd_devdata;
>>  		index = 0;
>>     
>
> I raised the same query when Andrey sent an off-list copy to me by
> mistake - he said that in future he intends to extend the driver to 
> have additional features not present on the EVM (though for me that
> could always change the || later).
>
> Andrey, with Linux kernel patches reply to all is generally the way
> forward.
>   
Mark,

Understood. Shall I change if if to if || then?

-- 
Best regards
Andrey A. Porodko
 
