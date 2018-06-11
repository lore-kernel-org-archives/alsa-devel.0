From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Order of device overrides in config files
Date: Mon, 11 Jun 2018 17:30:27 +0200
Message-ID: <bdd4bfff-6123-a104-fce5-b92db192000f@ivitera.com>
References: <fde2be1f-1e42-5e23-e1aa-77fb3e9a31bd@ivitera.com>
 <fb4a790c-9559-c706-2064-e3d4e9261cb9@perex.cz>
 <ee2da76e-ed55-f7a1-b08a-99744cda8593@ivitera.com>
 <8163424e-9373-aeae-23e6-9ebfcc757c3b@perex.cz>
 <22a07e99-17cb-b2de-485b-1d7150a65d26@ivitera.com>
 <4845ff6e-d6db-909f-74d7-67bd74b43b77@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id A37CB266E76
 for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2018 17:30:29 +0200 (CEST)
In-Reply-To: <4845ff6e-d6db-909f-74d7-67bd74b43b77@perex.cz>
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
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Dne 11.6.2018 v 17:19 Jaroslav Kysela napsal(a):
> 
> This configuration comes from Ubuntu (debian). We do not have such
> config in the upstream (nor Fedora) where we expect to change the pulse
> configuration file or uninstall the alsa-plugins-pulseaudio package
> (which contains the default configuration file) when the pulseaudio is
> not used:
> 
> http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=pulse/50-pulseaudio.conf
> http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=pulse/99-pulseaudio-default.conf.example
> 
> Unfortunately @hooks from the alsa.conf.d files (or any other files
> loaded from the @hooks in alsa.conf) are expanded dynamically on request
> when the 'pcm' definitions are parsed. So yes, pulse-alsa.conf is loaded
> later than other configuration files in this case.

Jaroslav, I very much apprecite your expert advice. Next time I will 
remove the ubuntu-added configuration to avoid this problem.

Best regards,

Pavel.
