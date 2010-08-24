From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [alsa-lib] Query regarding
 snd_config_update_free_global() and threads etc.
Date: Tue, 24 Aug 2010 01:47:18 +0100
Message-ID: <i4v4qm$ak3$1@dough.gmane.org>
References: <i4tflh$8c4$1@dough.gmane.org>	<alpine.LNX.2.00.1008231710320.10278@eeebox2.perex-int.cz>
	<i4u5b2$c4r$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D8B82453B
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 02:47:30 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Onhfj-0003mP-P7
	for alsa-devel@alsa-project.org; Tue, 24 Aug 2010 02:47:27 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2010 02:47:27 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2010 02:47:27 +0200
In-Reply-To: <i4u5b2$c4r$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Colin Guthrie at 23/08/10 16:49 did gyre and gimble:
> 'Twas brillig, and Jaroslav Kysela at 23/08/10 16:13 did gyre and gimble:
>> On Mon, 23 Aug 2010, Colin Guthrie wrote:
>>
>>> Hi there,
>>>
>>> I've got a (hopefully quick) query about snd_config_update_free_global()
>>> and it's general thread safetyness.
>>>
>>>
>>> I'm currently going insane on this bug:
>>> https://bugs.kde.org/show_bug.cgi?id=232068
>>> which revolves around a bug manifested in snd_pcm_close() (or rather
>>> snd_pcm_ioplug_close()) when dealing with the ALSA->PulseAudio plugin.
>>>
>>>> From what I can gather, this problem is related to a KDE module that is
>>> loaded into the library in question which does some alsa probing and
>>> ultimately calls snd_config_update_free_global() several times. The
>>> library itself then goes on to use GStreamer to do actual audio output.
>>> The crash then manifests itself prior to any sound actually being output.
>>>
>>> I can reliably reproduce the machine on two machines (I don't have many
>>> at my disposal), but cannot reproduce on a third. The two I can
>>> reproduce it on are two and four core intel duo's. The one I cannot
>>> reproduce on is an older, single core machine. I am leaning towards some
>>> kind of thread safety issue.
>>>
>>>
>>> In searching for similar problems, I found several references to similar
>>> crashes attributed to snd_dlobj_cache_cleanup() perhaps not being thread
>>> safe.
>>
>> I tried to work on snd_dlobj_cache issues. Please, could you test this 
>> patch?
>>
>> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=91c9c8f1b85e69b4bdc94a777d2767c4906c3f47
> 
> Sure, will try and do so this evening and report back. Thanks!

That patch (along with 09879a4bb58199f64abcb8df506f917c8efc2383: pcm:
add defaults.pcm.minperiodtime parsing - just to avoid conflicts) on top
of 1.0.23 seems to fix the easily reproducible crash case for me. \o/

Awesome. Thanks!

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
