From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-lib PATCH 2/4] Search-and-replace improve
 documentation language
Date: Thu, 05 Jan 2012 09:37:48 +0100
Message-ID: <4F05615C.4030800@ladisch.de>
References: <a0053dfb39d22118fce92031e4d6adac948b02fc.1325707699.git.aeikum@codeweavers.com>	<20120104201137.GD9868@foghorn.codeweavers.com>
	<CAN8cciYsbbMVgsvb3FDDVOob8C8sLNW5KLxb1sx9BRX0LAkZ+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 242C024586
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 09:38:21 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9274020DB4
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 03:38:11 -0500 (EST)
Received: from [192.168.42.121] (unknown [46.115.39.213])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 165738E00AE
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 03:38:10 -0500 (EST)
In-Reply-To: <CAN8cciYsbbMVgsvb3FDDVOob8C8sLNW5KLxb1sx9BRX0LAkZ+w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
>> + * This function should only be called when the configuration space
>> + * contains a single configuration. Call #snd_pcm_hw_params to choose
>> + * a single configuration from the configuration space.
>>  */
>> int snd_pcm_hw_params_can_pause(const snd_pcm_hw_params_t *params)
>
> What is the meaning of the configuration space contains a single configuration ?
>
> since the hardware either support pause or does not support pause

You cannot guarantee this for all future hardware, and not for plugins
that select different hardware depending on parameters.


Regards,
Clemens
