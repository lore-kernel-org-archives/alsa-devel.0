From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Order of device overrides in config files
Date: Mon, 11 Jun 2018 17:19:31 +0200
Message-ID: <4845ff6e-d6db-909f-74d7-67bd74b43b77@perex.cz>
References: <fde2be1f-1e42-5e23-e1aa-77fb3e9a31bd@ivitera.com>
 <fb4a790c-9559-c706-2064-e3d4e9261cb9@perex.cz>
 <ee2da76e-ed55-f7a1-b08a-99744cda8593@ivitera.com>
 <8163424e-9373-aeae-23e6-9ebfcc757c3b@perex.cz>
 <22a07e99-17cb-b2de-485b-1d7150a65d26@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id DC3C0266E76
 for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2018 17:19:33 +0200 (CEST)
In-Reply-To: <22a07e99-17cb-b2de-485b-1d7150a65d26@ivitera.com>
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

Dne 11.6.2018 v 15:45 Pavel Hofman napsal(a):
> Dne 11.6.2018 v 15:34 Jaroslav Kysela napsal(a):
>> Dne 11.6.2018 v 15:18 Pavel Hofman napsal(a):
>>> Dne 11.6.2018 v 14:20 Jaroslav Kysela napsal(a):
>>
>> It seems that there's something different in your system, so the
>> ~/.asoundrc file is not parsed as last.
> 
> Ubuntu 16:04 (Mint 17)
> 
> It is parsed by the same order as specified in
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
> But the last "default" redefinition occurs from 
> usr/share/alsa/pulse-alsa.conf, which is "scheduled" by 
> alsa.conf.d/pulse.conf:
> 
> 
> hook_func.pulse_load_if_running {
>          lib "libasound_module_conf_pulse.so"
>          func "conf_pulse_hook_load_if_running"
> }
> 
> @hooks [
>          {
>                  func pulse_load_if_running
>                  files [
>                          "/usr/share/alsa/pulse-alsa.conf"
>                  ]
>                  errors false
>          }
> ]
> 
> According to strace, the function pulse_load_if_running opens 
> /usr/share/alsa/pulse-alsa.conf AFTER ~/.asoundrc:
> 
> strace aplay -v -D default /home/hestia/Hudba/192.wav 2>&1 | nl | grep 
> -E '/usr/share/alsa|asoundrc'
>      88	stat("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, 
> st_size=9182, ...}) = 0
>      89	open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
>     100	access("/usr/share/alsa/alsa.conf.d/", R_OK) = 0
>     101	stat("/usr/share/alsa/alsa.conf.d/", {st_mode=S_IFDIR|0755, 
> st_size=123, ...}) = 0
>     102	openat(AT_FDCWD, "/usr/share/alsa/alsa.conf.d/", 
> O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
>     106	open("/usr/share/alsa/alsa.conf.d//50-pulseaudio.conf", 
> O_RDONLY) = 3
>     114	open("/usr/share/alsa/alsa.conf.d//bluetooth.conf", O_RDONLY) = 3
>     122	open("/usr/share/alsa/alsa.conf.d//pulse.conf", O_RDONLY) = 3
>     131	access("/home/hestia/.asoundrc", R_OK)  = 0
>     132	stat("/home/hestia/.asoundrc", {st_mode=S_IFREG|0644, 
> st_size=215, ...}) = 0
>     133	open("/home/hestia/.asoundrc", O_RDONLY) = 3
>     540	access("/usr/share/alsa/pulse-alsa.conf", R_OK) = 0
>     541	stat("/usr/share/alsa/pulse-alsa.conf", {st_mode=S_IFREG|0644, 
> st_size=340, ...}) = 0
>     542	open("/usr/share/alsa/pulse-alsa.conf", O_RDONLY) = 6

This configuration comes from Ubuntu (debian). We do not have such
config in the upstream (nor Fedora) where we expect to change the pulse
configuration file or uninstall the alsa-plugins-pulseaudio package
(which contains the default configuration file) when the pulseaudio is
not used:

http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=pulse/50-pulseaudio.conf
http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=pulse/99-pulseaudio-default.conf.example

Unfortunately @hooks from the alsa.conf.d files (or any other files
loaded from the @hooks in alsa.conf) are expanded dynamically on request
when the 'pcm' definitions are parsed. So yes, pulse-alsa.conf is loaded
later than other configuration files in this case.

						Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
