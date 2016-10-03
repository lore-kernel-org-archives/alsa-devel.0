From: Petr Kulhavy <brain@jikos.cz>
Subject: Re: [PATCH 1/5] ASoC: tas571x: fix missing bias save
 level
Date: Mon, 3 Oct 2016 21:00:57 +0200
Message-ID: <429a96e7-1eb4-9d30-9b38-ea7d8c95ffd3@jikos.cz>
References: <1475505650-8572-1-git-send-email-brain@jikos.cz>
 <1475505650-8572-2-git-send-email-brain@jikos.cz>
 <505a8248-dcc6-ee31-b381-72c661d1b373@metafoo.de>
Reply-To: brain@jikos.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep14.mx.upcmail.net (fep14.mx.upcmail.net [62.179.121.34])
 by alsa0.perex.cz (Postfix) with ESMTP id E7FD9266971
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 21:00:58 +0200 (CEST)
Received: from edge03.upcmail.net ([192.168.13.238]) by viefep14-int.chello.at
 (InterMail vM.8.01.05.18 201-2260-151-151-20140610) with ESMTP
 id <20161003190058.TZZX29981.viefep14-int.chello.at@edge03.upcmail.net>
 for <alsa-devel@alsa-project.org>; Mon, 3 Oct 2016 21:00:58 +0200
In-Reply-To: <505a8248-dcc6-ee31-b381-72c661d1b373@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 03/10/16 19:09, Lars-Peter Clausen wrote:
> On 10/03/2016 04:40 PM, Petr Kulhavy wrote:
>> The tas571x_set_bias_level() was not saving the new bias level to
>> codec->dapm.bias_level. This had the effect that bias was switching between
>> standby and off levels and never entered the on level.
>>
>> This fix saves the bias level before returning from the function.
>>
> This is done by the ASoC core after the function completes, so this should
> not be necessary.
Hi Lars,

since what kernel version is it handled by the ASoC core?
I've been testing it on a 4.1 based iMX kernel and there the bias levels 
were handled improperly...

Thanks
Petr
