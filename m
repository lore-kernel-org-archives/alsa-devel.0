From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-cvslog] [ALSA GIT]ALSA utilities repository
 branch master updated. v1.0.26-26-ge05b903
Date: Tue, 09 Apr 2013 17:52:23 +0200
Message-ID: <51643937.5020602@perex.cz>
References: <20130408125154.6264F2651CD@alsa0.perex.cz>
 <s5hbo9nyipb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 352C8265E3E
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 17:52:26 +0200 (CEST)
In-Reply-To: <s5hbo9nyipb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 9.4.2013 14:47, Takashi Iwai wrote:
> At Mon,  8 Apr 2013 14:51:54 +0200 (CEST),
> GIT server wrote:
>>
>> This is an automated email from the git hooks/post-receive script. It was
>> generated because a ref change was pushed to the repository containing
>> the project "ALSA utilities repository".
>>
>> The branch, master has been updated
>>        via  e05b903b1fb16e967d838edac408304cd4470fee (commit)
>>       from  46cb355d4ff41c8065b02644b0534ab42d16cb72 (commit)
>>
>> Those revisions listed above that are new to this repository have
>> not appeared on any other notification email; so we list those
>> revisions in full, below.
>>
>> - Log -----------------------------------------------------------------
>> commit e05b903b1fb16e967d838edac408304cd4470fee
>> Author: Jaroslav Kysela <perex@perex.cz>
>> Date:   Mon Apr 8 14:49:31 2013 +0200
>>
>>     alsactl: move systemd config to the daemon mode
>>     
>>     Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> 
> I'm not thrilled by the silent default behavior change like this.
> This will affect all systems using systemd from now on.
> 
> I understand the reason behind it, but I wonder whether it's an
> overkill.  Yet another daemon, unconditionally no matter whether
> hotplug or not?  Hmm...

The question is, how we can detect the hotplug scheme. Almost all
systems have USB today and laptops have PCI express card slots, so....
Fedora has the systemd configs in the alsa-utils package. A removal of
this package is sufficient do disable the daemon. Eventually, we can
save the state periodically using cron (without the changes tracking),
but my measurement is that the alsactl daemon eats approx. 150kb of memory.

Some other quick ideas:

- make the static/hotplug schemes depending on an environment variable
  passed through the bootloader
- another two packages on top of alsa-utils with two configs
- save the last state inside the driver and offer it to the userspace
  upon the card removal (seems overkill)
- run multiple daemon instances per hotplug card; the question is how
  to detect the static card in the system (perhaps checking the PCI
  config?) to avoid the daemon startup for those static cards

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
