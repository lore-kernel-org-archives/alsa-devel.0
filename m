From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Confused about 'default' device
Date: Wed, 24 Oct 2007 14:35:47 +0200
Message-ID: <471F3C23.2000401@keyaccess.nl>
References: <471E4E2A.9090105@freescale.com> <s5h4pggevv8.wl%tiwai@suse.de>
	<1193225838.26984.1217558213@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id B925F2441A
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Oct 2007 14:38:41 +0200 (CEST)
In-Reply-To: <1193225838.26984.1217558213@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 10/24/2007 01:37 PM, Clemens Ladisch wrote:

> Takashi Iwai wrote:
>> Timur Tabi wrote:
>>> I'm having a hard time understand when ALSA does sample rate and format 
>>> conversion, and when it doesn't.
>>>
>>> When I issue the following command:
>>>
>>> 	mplayer -ao alsa filename.mov -v
>>>
>>> I get this output:
>>> ...
>>> alsa-init: using device default
>>> alsa-init: format s24le are not supported by hardware
>>>
>>> I was under the impression that ALSA can do format and sample rate conversion if 
>>> necessary, but I guess that's not always the case.
>> It does.  mplayer seems to try first the hardware device without
>> conversion and falls back to "default" PCM.
> 
> In this case, it uses only the "default" PCM device.  There seems to be
> some problem with its definition.
> 
> Are there any definitions in ~/.asoundrc or /etc/asound.conf?  If not,
> what driver is used, and does it have a file in /usr/share/alsa/cards/?

Just in case you guys missed it -- he posted:

===
alsa-init: using ALSA 1.0.8
===

Isn't 1.0.8 from before ALSA did any mixing by default?

Rene.
