From: =?iso-8859-1?Q?J=E9r=F4me_Forissier?= <jerome@taodyne.com>
Subject: Re: [PATCH 0/2] Fix thread safety issues
Date: Thu, 31 Jan 2013 10:48:27 +0100
Message-ID: <712BEC00-37D2-458C-B8C1-A0EECBF6C608@taodyne.com>
References: <1359559337-15533-1-git-send-email-jerome@taodyne.com>
 <s5hfw1i64k0.wl%tiwai@suse.de>
 <DBCAE20C-2070-4D0C-A7C0-E62D85846AD4@taodyne.com>
 <s5hwqutwx3z.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id F03482616FE
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 10:48:30 +0100 (CET)
Received: by mail-wg0-f41.google.com with SMTP id ds1so266759wgb.0
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 01:48:30 -0800 (PST)
In-Reply-To: <s5hwqutwx3z.wl%tiwai@suse.de>
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


On 31 janv. 2013, at 09:54, Takashi Iwai wrote:

> At Wed, 30 Jan 2013 19:13:54 +0100,
> J=E9r=F4me Forissier wrote:
>> =

>> On 30 janv. 2013, at 17:03, Takashi Iwai wrote:
>> =

>>> At Wed, 30 Jan 2013 16:22:15 +0100,
>>> Jerome Forissier wrote:
<...>
>>> snd_device_name_hint() should use snd_config_update_r() and pass the
>>> local config space to others instead of snd_config.
>> =

>> I tried following this path, but there is a problem: try_config() calls =
snd_lib_error_set_handler() so I fail to see how we can make this code reen=
trant.
>> In fact, the random errors I've seen when running my multi-threaded test=
 were probably just a side-effect of fiddling with the global error handler=
 from multiple threads. Probably harmless, but still it makes snd_device_na=
me_hint() not thread-safe, strictly speaking.
> =

> Yeah, I see the issue now, too.
> =

> The problem is that the error handler is really global, not only used
> in conf.c and co.  Thus applying a lock locally doesn't suffice.
> =

>> Any suggestion? Should I consider moving snd_lib_error to thread-local s=
torage?
> =

> TLB would be an option, indeed.  But blindly moving snd_lib_error to
> TLS breaks the current behavior, so we should avoid it.

One could argue that the current behavior with multi-threaded apps is undef=
ined anyways. But I see what you mean.

> How about a patch like below?  It adds another error redirection.
> Unless local_error is set, the behavior is identical.

Nice suggestion. Will try that. After all, "all problems in computer scienc=
e can be solved by another level of indirection..." ;-)

> (Maybe we can name it better, yeah.  I just wanted to avoid to put a
> word "thread" in the function because it should be usable in both
> thread- and non-thread-capable environment.)

Well you can consider that, in a non-threaded environment, there is just on=
e thread (the main thread). =


Thanks for your help. I will post an updated patch when done.

-- =

Jerome
