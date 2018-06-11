From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Order of device overrides in config files
Date: Mon, 11 Jun 2018 15:18:57 +0200
Message-ID: <ee2da76e-ed55-f7a1-b08a-99744cda8593@ivitera.com>
References: <fde2be1f-1e42-5e23-e1aa-77fb3e9a31bd@ivitera.com>
 <fb4a790c-9559-c706-2064-e3d4e9261cb9@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id B2F55267196
 for <alsa-devel@alsa-project.org>; Mon, 11 Jun 2018 15:18:58 +0200 (CEST)
In-Reply-To: <fb4a790c-9559-c706-2064-e3d4e9261cb9@perex.cz>
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

Dne 11.6.2018 v 14:20 Jaroslav Kysela napsal(a):
> 
> It means operation mode 'override':
> 
> http://www.alsa-project.org/alsa-doc/alsa-lib/conf.html
> 
> By default, the operation mode is 'merge+create'.

Hi Jaroslav,

Thank you for the information and the link.

In alsa.conf I see the order of config files which is same as my strace 
output reveals:

@hooks [
         {
                 func load
                 files [
                         {
                                 @func concat
                                 strings [
                                         { @func datadir }
                                         "/alsa.conf.d/"
                                 ]
                         }
                         "/etc/asound.conf"
                         "~/.asoundrc"
                 ]
                 errors false
         }
]


The default device is overriden in pulse-alsa.conf which is called by 
hook_func.pulse_load_if_running defined in alsa.conf.d/pulse.conf read 
BEFORE processing my .asoundrc . Strace shows that reading 
pulse-alsa.conf occurs AFTER reading .asoundrc . It works as specified :-)

Please would it make sense to call .asoundrc (somehow...) after all the 
config hooks were processed so that redefining the default device in the 
user's config actually works? Many users get confused by this behavior 
as it is not really obvious. No matter what they list in their .asoundrc 
(correctly following alsa documentation), the default device always ends 
up to be the pulse plugin.

Thanks a lot for your time and opinion.

Best regards,

Pavel.
