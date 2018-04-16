From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-lib: add-on configs directory changed to
 /etc/alsa/conf.d
Date: Mon, 16 Apr 2018 15:01:33 +0200
Message-ID: <ff21c743-5bd6-7448-4eb5-656d28f145ec@perex.cz>
References: <a38c315a-e7b8-8531-e010-08c5f486d3b5@perex.cz>
 <s5hd0z7cz0l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id ED7BF267217
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 15:01:35 +0200 (CEST)
In-Reply-To: <s5hd0z7cz0l.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 10.4.2018 v 09:16 Takashi Iwai napsal(a):
> On Wed, 04 Apr 2018 10:12:50 +0200,
> Jaroslav Kysela wrote:
>>
>> Hi,
>>
>>    I pushed two commits to the alsa-lib package which changes the
>> default location for the add-on config files to /etc/alsa/conf.d from
>> /usr/share/alsa/alsa.conf.d . The reason is to follow the scheme like in
>> other packages. Also, the users might want to change or disable contents
>> in those 'default' files.
>>
>>    Example paths from other packages:
>>
>> # find /etc -type d -name conf.d
>> /etc/fonts/conf.d
>> /etc/NetworkManager/conf.d
>> /etc/libblockdev/conf.d
>> /etc/sssd/conf.d
>> /etc/httpd/conf.d
> 
> How about evaluating both paths, with preference of /etc over
> /usr/share?  The change to allow only /etc would break the existing
> alsa-plugins packaging, for example, which still may put the config to
> /usr/share/alsa/conf.d.
>
> In general, /usr/share is the place for global setups while /etc for
> local machines.  So it's more natural to put the package default setup
> to /usr/share while allowing overriding it via /etc.  You can imagine
> /usr/share is shared via NFS.  If anything different is necessary, you
> put it in /etc.

>From the packager perspective, it makes more sense to have only
/etc/alsa/conf.d in the global alsa.conf and make symlinks to /usr/share
like fontconfig does (/etc/fonts/conf.d). The users will modify only
/etc contents as they should for the non-standard configurations. This
variant also looks to me more straight for users. Opinions?

					Thanks,
						Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
