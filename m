From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-lib: add-on configs directory changed to
 /etc/alsa/conf.d
Date: Mon, 16 Apr 2018 21:34:51 +0200
Message-ID: <6a13c02b-1d36-d44d-3f09-ed9f00f1a1e7@perex.cz>
References: <a38c315a-e7b8-8531-e010-08c5f486d3b5@perex.cz>
 <s5hd0z7cz0l.wl-tiwai@suse.de>
 <ff21c743-5bd6-7448-4eb5-656d28f145ec@perex.cz>
 <s5hvacrrplq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id B837F2673D3
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 21:34:53 +0200 (CEST)
In-Reply-To: <s5hvacrrplq.wl-tiwai@suse.de>
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

Dne 16.4.2018 v 20:08 Takashi Iwai napsal(a):
> On Mon, 16 Apr 2018 15:01:33 +0200,
> Jaroslav Kysela wrote:
>>
>> Dne 10.4.2018 v 09:16 Takashi Iwai napsal(a):
>>> On Wed, 04 Apr 2018 10:12:50 +0200,
>>> Jaroslav Kysela wrote:
>>>>
>>>> Hi,
>>>>
>>>>    I pushed two commits to the alsa-lib package which changes the
>>>> default location for the add-on config files to /etc/alsa/conf.d from
>>>> /usr/share/alsa/alsa.conf.d . The reason is to follow the scheme like in
>>>> other packages. Also, the users might want to change or disable contents
>>>> in those 'default' files.
>>>>
>>>>    Example paths from other packages:
>>>>
>>>> # find /etc -type d -name conf.d
>>>> /etc/fonts/conf.d
>>>> /etc/NetworkManager/conf.d
>>>> /etc/libblockdev/conf.d
>>>> /etc/sssd/conf.d
>>>> /etc/httpd/conf.d
>>>
>>> How about evaluating both paths, with preference of /etc over
>>> /usr/share?  The change to allow only /etc would break the existing
>>> alsa-plugins packaging, for example, which still may put the config to
>>> /usr/share/alsa/conf.d.
>>>
>>> In general, /usr/share is the place for global setups while /etc for
>>> local machines.  So it's more natural to put the package default setup
>>> to /usr/share while allowing overriding it via /etc.  You can imagine
>>> /usr/share is shared via NFS.  If anything different is necessary, you
>>> put it in /etc.
>>
>> >From the packager perspective, it makes more sense to have only
>> /etc/alsa/conf.d in the global alsa.conf and make symlinks to /usr/share
>> like fontconfig does (/etc/fonts/conf.d). The users will modify only
>> /etc contents as they should for the non-standard configurations. This
>> variant also looks to me more straight for users. Opinions?
> 
> Well, I'm not sure.  First of all, is this kind of config style
> (symlinking from /usr/share to /etc) generic?  I don't know of
> anything else than fontconfig.
> 
> And, the case of fontconfig looks is somehow hackish: it prepares the
> available configs in /usr/share/fontconfig/conf.avail/*, and
> symlinking to a differently named directory, /etc/fonts/conf.d/*.

The /usr/share fontconfig files are called as templates and it makes
sense to me.

> I think other cases are classified to a few different types:
> 
> - systemd-style:
>   there are two directories, /usr/share/foo/xxx.d/ and
>   /etc/foo/xxx.d/.  Read from both directories, but /etc is
>   preferred.  i.e. if a same file name is present in both /etc and
>   /usr/share, the former is taken and the latter is ignored.

If I imagine the code which is required to read both directories,
compare the clashes and do all those extra stuff I think that the
symlinks are more nice.

> - both /usr/share and /etc directories are evaluated, often in the
>   order of /etc preference, but no conflict check like systemd.
> 
> - only either /etc or /usr/share
> 
> 
> Basically fontconfig belongs to the last type but with some symlink
> hacks.  Honestly speaking, I never understand why they took such an
> approach...

Most of packages is using only /etc.

The systemd is doing the exactly similar thing. Just look to the
/etc/systemd/system tree. Except that those files are managed at runtime
and they are not a part of a package.

> Actually, I'm not objecting to addition of /etc.  But, as already
> mentioned, a slight concern is the case where another package
> (e.g. alsa-plugins-xyz) adds /usr/share/alsa/conf.d/*.conf.
> With the current proposal, we'll silently break.  And the situation
> won't change if we follow the fontconfig pattern.

The question is, if we do have such packages. The only problem might be
to use old plugin packages with the updated alsa-lib's global config,
but it is really a rare case. Usually, all ALSA packages are updated in
the sync and it's really easy to symlink/include/copy files from
/usr/share to /etc or include again /usr/share directory from /etc
config files if users use something special.

If I don't miss something, only the pulse plugin package has (had) an
own config. We have also template configs for other plugins in Fedora
which I pushed with more generic changes to the alsa-plugins package now.

I would assume the minimal impact for the current installations with
this change.

>From my side the whole story for this change began when I was notified
that the /usr/share path should not contain files to be modified by
users (in the standard usage).

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
