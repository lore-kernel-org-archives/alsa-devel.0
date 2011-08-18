From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [PATCH] Prefer kernel-versioned firmware directory.
Date: Fri, 19 Aug 2011 09:57:05 +1200
Message-ID: <4E4D8AB1.9090406@audioscience.com>
References: <1313551163-819-1-git-send-email-linux@audioscience.com>
	<s5hy5yrt4dq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 002AD2412D
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 23:57:25 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LQ500AOA8Z5IM30@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 19 Aug 2011 09:57:05 +1200 (NZST)
In-reply-to: <s5hy5yrt4dq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 18/08/11 22:12, Takashi Iwai wrote:
>> From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
>>
>> Different kernel versions may have different driver versions installed,
>> which in turn require different firmware versions.
>>
>> If /lib/firmware/$(uname -r) exists, use it in preference to the
>> generic /lib/firmware.
> 
> It's no good idea.  The installation of the firmware has nothing to
> do with the running kernel version.  

But running version of the kernel module may depend on a particular
firmware version.

> The firmware in kernel-tree may
> be installed in the kernel-version specific directory, but it's
> basically not for external firmware.

External modules are not renamed, they are put in a kernel-versioned
directory, so why not the firmware that they need?

On this ubuntu installation, there is all sorts of firmware in
/lib/firmware/$(uname -r) and in /lib/firmare
Some files are duplicated in these locations, some aren't.

The former is searched before the latter when firmware is requested.
Now, if the system has installed firmware in a versioned directory, and
the someone 'updates' from alsa-firmware, they won't get the expected
result because the old firmware will be used in preference to the new.

> 
> In principle, if a firmware is 
not?
> compatible, you must rename it, e.g.
> with a version suffix, etc.  Or, if a firmware is backward compatible,
> we may keep using the same name.

--
Eliot



-- 
Eliot Blennerhassett
AudioScience Inc.
