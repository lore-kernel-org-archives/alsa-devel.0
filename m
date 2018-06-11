From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Order of device overrides in config files
Date: Mon, 11 Jun 2018 14:20:45 +0200
Message-ID: <fb4a790c-9559-c706-2064-e3d4e9261cb9@perex.cz>
References: <fde2be1f-1e42-5e23-e1aa-77fb3e9a31bd@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 7350B266E91
 for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2018 14:20:48 +0200 (CEST)
In-Reply-To: <fde2be1f-1e42-5e23-e1aa-77fb3e9a31bd@ivitera.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>
List-Id: alsa-devel@alsa-project.org

Dne 11.6.2018 v 13:33 Pavel Hofman napsal(a):
> Hello,
> 
> Please in what order are devices specified in alsa conf overriden?
> 
> The  pcm.!default device is defined in /usr/share/alsa/pulse-alsa.conf. 
> Also, I redefine this device in my .asoundrc. Strace dump shows my 
> .asoundrc is loaded after /usr/share/alsa/pulse-alsa.conf. Yet the 
> default device remains the pulse plugin.
> 
> Also, what is the exact meaning of the exclamation mark in the device name?

It means operation mode 'override':

http://www.alsa-project.org/alsa-doc/alsa-lib/conf.html

By default, the operation mode is 'merge+create'.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
