From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [alsa-lib] Query regarding
 snd_config_update_free_global() and threads etc.
Date: Mon, 23 Aug 2010 16:49:54 +0100
Message-ID: <i4u5b2$c4r$1@dough.gmane.org>
References: <i4tflh$8c4$1@dough.gmane.org>
	<alpine.LNX.2.00.1008231710320.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B8B2A2436F
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 17:50:05 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OnZHg-0007GD-0G
	for alsa-devel@alsa-project.org; Mon, 23 Aug 2010 17:50:04 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 17:50:03 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 17:50:03 +0200
In-Reply-To: <alpine.LNX.2.00.1008231710320.10278@eeebox2.perex-int.cz>
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

'Twas brillig, and Jaroslav Kysela at 23/08/10 16:13 did gyre and gimble:
> On Mon, 23 Aug 2010, Colin Guthrie wrote:
> 
>> Hi there,
>>
>> I've got a (hopefully quick) query about snd_config_update_free_global()
>> and it's general thread safetyness.
>>
>>
>> I'm currently going insane on this bug:
>> https://bugs.kde.org/show_bug.cgi?id=232068
>> which revolves around a bug manifested in snd_pcm_close() (or rather
>> snd_pcm_ioplug_close()) when dealing with the ALSA->PulseAudio plugin.
>>
>>> From what I can gather, this problem is related to a KDE module that is
>> loaded into the library in question which does some alsa probing and
>> ultimately calls snd_config_update_free_global() several times. The
>> library itself then goes on to use GStreamer to do actual audio output.
>> The crash then manifests itself prior to any sound actually being output.
>>
>> I can reliably reproduce the machine on two machines (I don't have many
>> at my disposal), but cannot reproduce on a third. The two I can
>> reproduce it on are two and four core intel duo's. The one I cannot
>> reproduce on is an older, single core machine. I am leaning towards some
>> kind of thread safety issue.
>>
>>
>> In searching for similar problems, I found several references to similar
>> crashes attributed to snd_dlobj_cache_cleanup() perhaps not being thread
>> safe.
> 
> I tried to work on snd_dlobj_cache issues. Please, could you test this 
> patch?
> 
> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=91c9c8f1b85e69b4bdc94a777d2767c4906c3f47

Sure, will try and do so this evening and report back. Thanks!

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
