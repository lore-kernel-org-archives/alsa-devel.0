From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Changing default card using its name
Date: Tue, 23 Nov 2010 10:11:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011231009590.8433@eeebox2.perex-int.cz>
References: <4CE98AB0.4030601@ivitera.com> <4CEB8158.6010809@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D5EA24337
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 10:11:45 +0100 (CET)
In-Reply-To: <4CEB8158.6010809@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Nov 2010, Pavel Hofman wrote:

> Pavel Hofman napsal(a):
>> Hi,
>>
>> Please excuse my ignorance but I have not been able to figure out this
>> simple task. Nowadays most PCs have multiple soundcards (onboard plus
>> HDMI, often another PCI card). Order of the cards is not stable. How do
>> I define in /etc/asound.conf another default card using its name and
>> keep the PCMs defined by its corresponding alsa card/pcm config files?
>>
>> In my case aplay -L:
>>
>> defaults.ctl.card "CMI8768"
>>
>> which IMO would have been the simplest solution.
>>
>
> Well, adding the exclamation mark
>
> !defaults.pcm.card "CMI8768"

What about:

defaults.pcm.!card "CMI8768"

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
