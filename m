From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH 0/3] Fallback mechanism for pulse plugin
Date: Wed, 14 Sep 2011 11:35:15 +0100
Message-ID: <4E708363.9050802@colin.guthr.ie>
References: <s5hk4b5w7aq.wl%tiwai@suse.de> <4E624761.5000305@colin.guthr.ie>
	<s5hipoy89ss.wl%tiwai@suse.de> <4E6DC6DB.7080204@colin.guthr.ie>
	<s5hbouq868a.wl%tiwai@suse.de> <4E6E51FF.9070508@colin.guthr.ie>
	<s5hty8gvpuz.wl%tiwai@suse.de> <4E6F188A.1040404@colin.guthr.ie>
	<4E70791E.8050007@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id 86FCA2436E
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 12:35:19 +0200 (CEST)
In-Reply-To: <4E70791E.8050007@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and David Henningsson at 14/09/11 10:51 did gyre and gimble:
> On 09/13/2011 10:47 AM, Colin Guthrie wrote:
>> 'Twas brillig, and Takashi Iwai at 13/09/11 08:55 did gyre and gimble:
>>>> Yup I think so. I'll put this on my list (I did try and suggest
>>>> something like this a while back, but got little in the way of
>>>> responses
>>>> - I wanted to standardise things rather than have distro hacks
>>>> everywhere - can't seem to find the email now, so I'll just resend it
>>>> when I have some time to think straight)
>>>
>>> Yeah, we want to have some really easy way to check whether PA is
>>> enabled or not.  For example, in the case of X11, you can check
>>> $DISPLAY (or options are given explicitly) as a primary check.
>>
>> Yeah, but sadly I don't think this is possible. The Ubuntu solution for
>> example works differently to yours. (Disclaimer, I've already said I
>> think this is ugly). It works by altering the config file dynamically
>> such that the default is either dmix or pulse depending on whether PA is
>> running. Of course "PA is running" is a broken check in the first place
>> (see the "ugly" word in my disclaimer!) as we could be dealing with thin
>> clients and remote PA daemons only, in which case there is no running
>> PA.
> 
> I think adding a function in libpulse named is_PA_enabled() makes sense,
> as discussed somewhere else in this thread. Once we have that, we should
> change "PA is running" to "file_exists(libpulse.so.x) &&
> dlopen(libpulse.so.x) && is_PA_enabled()". Does that seem to be a
> reasonable solution?

It depends on how clever the check is.


I've maintained that we need to connect to check (mainly due to remote
connections), but in actual fact the check could just be:

bool is_PA_enabled()
{
 if (local && (!daemon_binary_exists || conf->enabled=="no"))
 	return false;
 return true;
}

If the user has managed to run PA daemon (e.g. it's running from before
the config was changed to set enabled=no) then we still won't use it, so
a "connection check" isn't really needed.

And if the connection is refused or it doesn't autospawn, that's just an
error we want to see and we wouldn't process a fallback in that case anyway.

So actually this check could be pretty simply defined as that.

The only slight "boundary" that is crossed here is the parsing of the
daemon config from the client library... which is a bit wrong, but I
think somewhat justified.

If it's genuinely ugly to check the daemon.conf in the client, we could
just process the autospwan and check the daemon return value (with a
specific return value meaning - "I'm disabled") and get the same result
so either way, this approach should work I think.



Of course the "local" check is a bit complicated as we can have multiple
strings defined in the server config and the first one in the list is
always our local one:

e.g. here I have:
{6cb2a4b2bd6df042e57da8a4000001d4}unix:/home/colin/.pulse/6cb2a4b2bd6df042e57da8a4000001d4-runtime/native
tcp:jimmy:4713 tcp6:jimmy:4713

So for the "local" check to succeed the first entry in that string has
to be a local socket that machines our current dbus machine id.

Anything else and we consider ourselves as having a non-local connection
and PA should be used. Of course if the server config is totally empty,
that's also considered local.


Does this work?

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
