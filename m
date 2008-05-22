From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_kcontrol questions
Date: Thu, 22 May 2008 12:58:31 +0200
Message-ID: <483551D7.1000500@ladisch.de>
References: <827ad74d0805212315o7e55bf92q6aa81cfa9c1e461e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2286D1037F1
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 12:58:36 +0200 (CEST)
In-Reply-To: <827ad74d0805212315o7e55bf92q6aa81cfa9c1e461e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha priya gupta <harshapriya@gmail.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Harsha priya gupta wrote:
> 1. I want to define a snd_kcontrol that is of type mono.

In the control's info callback, set the count element of the
snd_ctl_elem_info structure to 1.

> 2. My input controls give out 9 channels when i say 'split channels' in
> kmix. can anyone help me how to fix that to 2 channels

There's something wrong in your code.  Which you didn't show.

> 3. I would want to get the individual setting of each channel from KMIX into
> my ALSA driver. How do I get them?

The snd_ctl_elem_value structure contains an array of values.


HTH
Clemens
