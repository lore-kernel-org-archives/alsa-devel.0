From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 4/4] ASoC: DaVinci: pcm,
	fix underrun by using sram
Date: Wed, 14 Jul 2010 10:46:59 -0700
Message-ID: <4C3DF813.4050908@boundarydevices.com>
References: <51883.1279047660@boundarydevices.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E7B42662@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpoproxy2-pub.bluehost.com (cpoproxy2-pub.bluehost.com
	[67.222.39.38]) by alsa0.perex.cz (Postfix) with SMTP id A20CC1037EC
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 19:47:23 +0200 (CEST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7B42662@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "broonie@sirena.org.uk" <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Nori, Sekhar wrote:
> On Wed, Jul 14, 2010 at 00:31:00, troy.kisky@boundarydevices.com wrote:
>> On Tue 13/07/10 6:00 AM , "Nori, Sekhar" nsekhar@ti.com sent:
>>
>
>>       The reason is so that the IRAM data can be fetched and used
>> while
>>
>>       EVENTQ_1 fetches the next buffer of data from sdram into IRAM.
> 
> Thanks for the explanation. That sounds reasonable.
> 
> Just curious as to whether you actually faced an issue
> when using the same event queue for both transfers?
> 
> I just tested this on DM365 with both transfers on EDMAQ_0
> with 16K each of capture and playback IRAM at 48KHz
> sampling rate and did not find any issue.
> 
> Anyway it makes sense to make provision for platform to choose
> different queues for both transfers so will implement my patch
> that way.
> 
> Thanks,
> Sekhar
> 

IIRC, the DM365 has a fifo, the 6443/6446 doesn't. So, the 365 doesn't
need to use IRAM and shouldn't use it. Test using the same controller
on a board without a fifo.

Troy
