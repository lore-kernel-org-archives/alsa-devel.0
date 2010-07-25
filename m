From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Which project to choose?
Date: Sun, 25 Jul 2010 15:14:21 +0100
Message-ID: <i2hgrq$ub3$1@dough.gmane.org>
References: <1279062131.24837.22.camel@localhost.localdomain>	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>	<1279065709.24837.29.camel@localhost.localdomain>	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>	<1279071115.29042.0.camel@localhost.localdomain>	<AANLkTimNSRELBq7i1Ypi9K2tmFu9NKLvQAOOqPwuU13x@mail.gmail.com>	<1279074303.29042.3.camel@localhost.localdomain>	<AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>	<1279145758.29042.11.camel@localhost.localdomain>	<AANLkTinN15BWNC2cn78rc5xCSXNo79SDE2_WkBNEg5I2@mail.gmail.com>	<1279157921.2668.1.camel@localhost.localdomain>	<i1n0mf$87c$1@dough.gmane.org>
	<AANLkTinXvthWBZ4oQg9D18cfAtkXveWHkB08vsXknGgB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EF8E24B21
	for <alsa-devel@alsa-project.org>;
	Sun, 25 Jul 2010 16:14:28 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Od1yE-0007EC-VO
	for alsa-devel@alsa-project.org; Sun, 25 Jul 2010 16:14:26 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 25 Jul 2010 16:14:26 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 25 Jul 2010 16:14:26 +0200
In-Reply-To: <AANLkTinXvthWBZ4oQg9D18cfAtkXveWHkB08vsXknGgB@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 24/07/10 04:51 did gyre and gimble:
> 2010/7/15 Colin Guthrie <gmane@colin.guthr.ie>
> 
>> 'Twas brillig, and Chris at 15/07/10 02:38 did gyre and gimble:
>>> On Thu, 2010-07-15 at 08:08 +0800, Raymond Yau wrote:
>>>
>>>>> I posted both of those bug reports. Honestly, I just want it to work
>>>>> without all the error output to syslog and thrashing of my HD for
>>>>> minutes at a time. As I said, I've got the output of pulseaudio -vvvvv
>>>>> if anyone would like to look at it and tell me what I need to do to fix
>>>>> the problem.
>>>>>
>>>>> Chris
>>>>>
>>>>>
>>>>>
>>>> Just upload your current pulseaudio.log and output of alsa-info.sh to
>>>> mandriva 's bugzilla
>>>>
>>>> Cannot obtain any conclusion based on the log which you have posted last
>>>> year ( xmms)
>>>>
>>>> as Jaroslav Kysela said , need the real system time between I/O
>> operations
>>>> and you'll see if it's issue in the ALSA driver or a task scheduling
>>>> problem.
>>>
>>> Here is the bug report with the outputs uploaded.
>>>
>>> https://qa.mandriva.com/show_bug.cgi?id=60169
>>
>> Well seeing as my process when getting such a bug is to report it here
>> on behalf of the user, I suspect that this has reached a stalemate....
>>
>>
>>
> Can I remove pulseaudio from mandriva 2000 ?
> 
> I just want to test libcanberra-alsa alone ( i.e. libcanberra without
> pulseaudio )
> 
> when PA server abort, and libcanberra-pulse cannot connect to PA server ,
> 
> Will libcanberra use libcanberra-alsa connect to PA using alsa-pulse plugin
> ?

Use draksound (or via Mandriva Control Center) to disable pulseaudio and
the ALSA backend for canberra should be used instead.

It's based on the alternatives system and the file
/etc/sound/profiles/alsa/canberra.conf


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
