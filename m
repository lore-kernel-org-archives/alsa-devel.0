From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 04 Aug 2004 08:24:41 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408041224.i74COghx020422@localhost.localdomain>
References: <4110C586.3030100@wildgooses.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 04 Aug 2004 12:16:22 BST."
             <4110C586.3030100@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I humbly suggest that you stop what you're trying to do and shift your
focus a little. I know that you just want to get MPlayer to work on
your audio interface, and I understand your frustration. But MPlayer's
audio layer was clearly written by people who see the audio
programming world through the same rather simplistic model that OSS
presented. Note that even by OSS standards, the code is wrong: OSS
makes it clear that the app *must* be prepared for some of the
parameters to fail and must adopt a fallback position. MPlayer should
have more num_periods options than it does - to not do so is simple
incorrect even for the OSS API.

There are other people in the community who want to see MPlayer
support JACK. This will require (as I understand it) a bit of a
redesign of MPlayer to accomodate the callback design that JACK uses.
MPlayer is still clearly (from the output you added) based on the
"write-whatever-i-want-whenever-i-want-to" model of audio i/o. This
just isn't going to work for low(ish) latency work, and it doesn't
integrate with a callback model particularly easily. When MPlayer
supports JACK, it won't matter what the audio interface is.

So either fix the audio layer in MPlayer to handle configuration
failures properly (i.e. trying other values) or help get MPlayer
working with JACK.

In the meantime, which version of ALSA are you using? The 8192 issue
was present in an older version, but was fixed, oh, at least 6 months
ago.

--p


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
