From: De Fuuss <fuuss@hotmail.com>
Subject: Re: intel-hd on an intel G33 motherboard
Date: Fri, 28 Dec 2007 01:53:58 +0000
Message-ID: <BAY109-W26A10E12EBD66E23EA9FA7A9550@phx.gbl>
References: <BAY109-W10EC413FC1F19625739A28A95B0@phx.gbl>
	<1198697428.3732.176.camel@razman.gruemaster.com>
	<BAY109-W373CBC57EE1663E94F98D8A9540@phx.gbl>
	<1198716447.3732.193.camel@razman.gruemaster.com>
	<BAY109-W163C6B7386D97E65192FBBA9540@phx.gbl>
	<75b66ecd0712270942w3a2d1ab5h26647304dddae3ee@mail.gmail.com>
	<1198805106.3176.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s28.bay0.hotmail.com (bay0-omc3-s28.bay0.hotmail.com
	[65.54.246.228]) by alsa0.perex.cz (Postfix) with ESMTP id E65062451F
	for <alsa-devel@alsa-project.org>; Fri, 28 Dec 2007 02:53:59 +0100 (CET)
In-Reply-To: <1198805106.3176.5.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiang zhe <zhe.jiang@intel.com>, Lee Revell <rlrevell@joe-job.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi,

I tried with the corrected syntax (alsamixer -D hw:1,0), to no avail. I get the following:

# alsamixer -D hw:1,0
ALSA lib conf.c:3840:(parse_args) Unknown parameter 1
ALSA lib conf.c:3966:(snd_config_expand) Parse arguments error: No such file or directory
ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL hw:1,0

alsamixer: function snd_ctl_open failed for hw:1,0: No such file or directory


I'm not sure I understand your question about extending the jacks. The SG33G5M has indeed 5 jacks on the back:

1 front out l/r
1 center/bass
1 sourround back l/r
1 side sourround
1 line in

+ an spdif out

All the jacks are directly soldered on the motherboard. The XPC motherboard is promoted as 7.1 capable.

The motherboard also exists in a SG33G5M "Deluxe" version with a supplementary spdif in + bluetooth + ...

Regards,

Patrick

> Subject: Re: [alsa-devel] intel-hd on an intel G33 motherboard
> From: zhe.jiang@intel.com
> To: rlrevell@joe-job.com
> CC: fuuss@hotmail.com; alsa-devel@alsa-project.org
> Date: Fri, 28 Dec 2007 09:25:06 +0800
>
> On Thu, 2007-12-27 at 12:42 -0500, Lee Revell wrote:
>> On Dec 27, 2007 5:38 AM, De Fuuss  wrote:
>>>
>>> Thank you for taking interest in my problem.
>>>
>>> I tried alsamixer -D hw:1.0 and similar combinations, but the card doesn't speak to me:
>>>
>>> #alsamixer -D hw:1.0
>>> alsamixer: function snd_ctl_open failed for hw:1.0: No such device
>>>
>>
>> Wrong syntax. Try alsamixer -D hw:1,0
>>
>> Lee
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> Hi,
>
> I googled some document about the G33 motherboard and the "Shuttle XPC
> SG33G5M".
>
> The G33 have 3 jacks on the back panel, while the "XPC SG33G5M" have 5
> jacks on the back panel.
>
> Does it mean that the XPC extend the jacks?
>
>
>

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/
