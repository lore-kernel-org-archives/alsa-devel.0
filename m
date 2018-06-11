From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Order of device overrides in config files
Date: Mon, 11 Jun 2018 15:34:39 +0200
Message-ID: <8163424e-9373-aeae-23e6-9ebfcc757c3b@perex.cz>
References: <fde2be1f-1e42-5e23-e1aa-77fb3e9a31bd@ivitera.com>
 <fb4a790c-9559-c706-2064-e3d4e9261cb9@perex.cz>
 <ee2da76e-ed55-f7a1-b08a-99744cda8593@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D94C2267196
 for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2018 15:34:41 +0200 (CEST)
In-Reply-To: <ee2da76e-ed55-f7a1-b08a-99744cda8593@ivitera.com>
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
To: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 11.6.2018 v 15:18 Pavel Hofman napsal(a):
> Dne 11.6.2018 v 14:20 Jaroslav Kysela napsal(a):
>>
>> It means operation mode 'override':
>>
>> http://www.alsa-project.org/alsa-doc/alsa-lib/conf.html
>>
>> By default, the operation mode is 'merge+create'.
> 
> Hi Jaroslav,
> 
> Thank you for the information and the link.
> 
> In alsa.conf I see the order of config files which is same as my strace 
> output reveals:
> 
> @hooks [
>          {
>                  func load
>                  files [
>                          {
>                                  @func concat
>                                  strings [
>                                          { @func datadir }
>                                          "/alsa.conf.d/"
>                                  ]
>                          }
>                          "/etc/asound.conf"
>                          "~/.asoundrc"
>                  ]
>                  errors false
>          }
> ]
> 
> 
> The default device is overriden in pulse-alsa.conf which is called by 
> hook_func.pulse_load_if_running defined in alsa.conf.d/pulse.conf read 
> BEFORE processing my .asoundrc . Strace shows that reading 
> pulse-alsa.conf occurs AFTER reading .asoundrc . It works as specified :-)

I cannot confirm that - the order specified in the configuration file
(files compound/array) is retained on my system (as it should):

open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
open("/usr/share/alsa/alsa.conf.d/",
O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
open("/usr/share/alsa/alsa.conf.d//50-pulseaudio.conf", O_RDONLY) = 3
open("/usr/share/alsa/alsa.conf.d//99-pulseaudio-default.conf",
O_RDONLY) = 3
open("/etc/asound.conf", O_RDONLY)      = 3
open("/home/perex/.asoundrc", O_RDONLY) = 3

The snd_config_hook_load() in src/conf.c function handles that.

> Please would it make sense to call .asoundrc (somehow...) after all the 
> config hooks were processed so that redefining the default device in the 
> user's config actually works? Many users get confused by this behavior 
> as it is not really obvious. No matter what they list in their .asoundrc 
> (correctly following alsa documentation), the default device always ends 
> up to be the pulse plugin.

It seems that there's something different in your system, so the
~/.asoundrc file is not parsed as last.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
