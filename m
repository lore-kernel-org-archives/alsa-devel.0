From: "Wang, Kuirong" <kuirongw@quicinc.com>
Subject: Re: How to trigger a widget?
Date: Tue, 21 Feb 2012 05:09:25 +0000
Message-ID: <D618B7A80E26984A9E4E1FD204983C1AA8AAF4@nasanexd01d.na.qualcomm.com>
References: <D618B7A80E26984A9E4E1FD204983C1AA88700@nasanexd01d.na.qualcomm.com>
	<4F420D6D.4050500@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id DC06C103834
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2012 06:09:31 +0100 (CET)
In-Reply-To: <4F420D6D.4050500@metafoo.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 02/20/2012 1:08 AM, Lars-Peter Clausen wrote:
>
>Hi,
>
>snd_soc_dapm_force_enable_pin is probably what you are looking for.
>
>- Lars

Thanks Lars. I tried the snd_soc_dapm_force_enable_pin, it didn't make different.

I have kcontrol to enable a function of codec on fly.  With or without the function, it cannot impact the established audio routing.  So I created widget as a supply, as long as the audio path is established, this supply widget is triggered. The supply widget has a callback event function.  The kcontrol control has an event callback function as well which calls the enable/disable pin to trigger the widget callback event, so this particular function can be enabled or disabled.

Thanks,
- Kuirong



 
