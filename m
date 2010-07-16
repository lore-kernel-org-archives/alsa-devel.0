From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Which project to choose?
Date: Fri, 16 Jul 2010 07:40:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007160733020.4208@eeebox2.perex-int.cz>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>
	<1279071115.29042.0.camel@localhost.localdomain>
	<AANLkTimNSRELBq7i1Ypi9K2tmFu9NKLvQAOOqPwuU13x@mail.gmail.com>
	<1279074303.29042.3.camel@localhost.localdomain>
	<AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>
	<1279145758.29042.11.camel@localhost.localdomain>
	<AANLkTinN15BWNC2cn78rc5xCSXNo79SDE2_WkBNEg5I2@mail.gmail.com>
	<1279157921.2668.1.camel@localhost.localdomain>
	<i1n0mf$87c$1@dough.gmane.org>
	<alpine.LNX.2.00.1007151603320.4208@eeebox2.perex-int.cz>
	<1279234479.2668.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id EA493103934
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 07:40:47 +0200 (CEST)
In-Reply-To: <1279234479.2668.3.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris <cpollock@embarqmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Jul 2010, Chris wrote:

> On Thu, 2010-07-15 at 16:07 +0200, Jaroslav Kysela wrote:
>> On Thu, 15 Jul 2010, Colin Guthrie wrote:
>>
>>> 'Twas brillig, and Chris at 15/07/10 02:38 did gyre and gimble:
>>>> On Thu, 2010-07-15 at 08:08 +0800, Raymond Yau wrote:
>>>>
>>>>>> I posted both of those bug reports. Honestly, I just want it to work
>>>>>> without all the error output to syslog and thrashing of my HD for
>>>>>> minutes at a time. As I said, I've got the output of pulseaudio -vvvvv
>>>>>> if anyone would like to look at it and tell me what I need to do to fix
>>>>>> the problem.
>>>>>>
>>>>>> Chris
>>>>>>
>>>>>>
>>>>>>
>>>>> Just upload your current pulseaudio.log and output of alsa-info.sh to
>>>>> mandriva 's bugzilla
>>>>>
>>>>> Cannot obtain any conclusion based on the log which you have posted last
>>>>> year ( xmms)
>>>>>
>>>>> as Jaroslav Kysela said , need the real system time between I/O operations
>>>>> and you'll see if it's issue in the ALSA driver or a task scheduling
>>>>> problem.
>>>>
>>>> Here is the bug report with the outputs uploaded.
>>>>
>>>> https://qa.mandriva.com/show_bug.cgi?id=60169
>>>
>>> Well seeing as my process when getting such a bug is to report it here
>>> on behalf of the user, I suspect that this has reached a stalemate....
>>
>> Please, provide also /var/log/messages output for xrun_debug=11 - see
>> http://www.alsa-project.org/main/index.php/XRUN_Debug for more details. We
>> can detect the ALSA ring buffer issues in this way, too.
>>
>>  						Jaroslav
>>
> See pastebin file http://pastebin.com/MdENbSNd
> Hopefully I did this correctly.

Thanks. The hardware ring buffer pointers looks OK so it does not appear 
like a problem in our ALSA code. I would really consult these problems 
with PulseAudio developers. Return back, if they say that it's really
ALSA issue, not the system scheduler issue.

Note that for your configuration, you have the ring buffer containing only 
0.1 second (it means that standard underruns can happen more frequently 
- usuall symptom is for example moving a window in X GUI).

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
