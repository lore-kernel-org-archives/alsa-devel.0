From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: How to trigger a widget?
Date: Mon, 20 Feb 2012 10:07:57 +0100
Message-ID: <4F420D6D.4050500@metafoo.de>
References: <D618B7A80E26984A9E4E1FD204983C1AA88700@nasanexd01d.na.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-025.synserver.de
	[212.40.185.25]) by alsa0.perex.cz (Postfix) with ESMTP id A4981246F0
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 10:06:23 +0100 (CET)
In-Reply-To: <D618B7A80E26984A9E4E1FD204983C1AA88700@nasanexd01d.na.qualcomm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Wang, Kuirong" <kuirongw@quicinc.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 02/20/2012 08:13 AM, Wang, Kuirong wrote:
> As I saw many examples to use the snd_soc_dapm_enable_pin() to trigger a particular widget. But I saw the widget has to be like a speaker, mic, lineout, etc. Could I use the snd_soc_dapm_enable_pin() to trigger any type of widget I want?  I tried to use it to trigger a supply widget, but I never see it works even I did snd_soc_dapm_sync() after the enable_pin.  Could someone provide some inputs?
> 
> Appreciated your time.
> 
> Thanks,
> 
> Kuirong Wang

Hi,

snd_soc_dapm_force_enable_pin is probably what you are looking for.

- Lars
