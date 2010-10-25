From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Constraining the number of frames per period
Date: Mon, 25 Oct 2010 09:48:02 +0200
Message-ID: <4CC53632.3080008@ladisch.de>
References: <AANLkTi=v2DKXfptubtwEPfH_4eZJ-vwLqVHAkmf3iE2D@mail.gmail.com>
	<alpine.LNX.2.00.1010211649160.29422@eeebox2.perex-int.cz>
	<AANLkTikAf+o7e-=hosi+dwEywK-Mt5UTvJtqzT=i_5Fz@mail.gmail.com>
	<4CC13153.7040002@ladisch.de>
	<AANLkTikr0ttrWCOiJEO-7GLvfLLUfRMA8Bii6wSD7qV6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E1F4F1037F9
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Oct 2010 09:46:19 +0200 (CEST)
In-Reply-To: <AANLkTikr0ttrWCOiJEO-7GLvfLLUfRMA8Bii6wSD7qV6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Rosenberg wrote:
>> Set the snd_pcm_hardware fields so that all sample formats are supported.
> 
> I do not understand why I need to add all of the sample formats,

Sorry, I actually meant to say "all of the sample formats supported
by your hardware", where "formats" includes all the field of the
snd_pcm_hardware structure.

The idea is to set the snd_pcm_hardware fields so that anything
supported by the hardware is allowed by these settings.  Then, if there
is any combination of settings that is allowed by these fields but not
supported by the hardware, add more constraints in the open callback.


Regards,
Clemens
