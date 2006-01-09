From: David Lang <dlang@digitalinsight.com>
Subject: Re: Re: [OT] ALSA userspace API complexity
Date: Mon, 9 Jan 2006 13:58:00 -0800 (PST)
Message-ID: <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de>
 <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from warden.diginsite.com (warden-p.diginsite.com [208.29.163.248])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id A881212B
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2006 23:02:32 +0100 (MET)
In-Reply-To: <200601091812.55943.rene@exactcode.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Cc: Hannu Savolainen <hannu@opensound.com>, Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Jan 2006, Ren=E9 Rebe wrote:

> On Monday 09 January 2006 16:10, Hannu Savolainen wrote:
>
>>>> I don't think so. The library can do such conversions (and alsa-lib =
does)
>>>> quite easy. If we have a possibility to remove the code from the ker=
nel
>>>> space without any drawbacks, then it should be removed. I don't see =
any
>>>> advantage to have such conversions in the kernel.
>>>
>>> Also, when the data is already available as single streams in a user-=
space
>>> multi track application, why should it be forced interleaved, when th=
e hardware
>>> could handle the format just fine?
>> Because the conversion doesn't cost anything. Trying to avoid it by
>> making the API more complicated (I would even say confusing) is extrem=
e
>> overkill.
>
> Since when doesn't cost convesion anything? I'm able to count a lot of =
wasted
> CPU cycles in there ...

if the data needed to be accessed by the CPU anyway it's free becouse=20
otherwise the CPU would stall waiting for the next chunk of memory. you=20
can do quite a bit of work on data in cache while you are waiting for the=
=20
next cache line to load.

in this same way, checksumming a network packet is free if the CPU needs=20
to copy the data anway, it only costs something if the data could bypass=20
the CPU.

David Lang

--=20
There are two ways of constructing a software design. One way is to make =
it so simple that there are obviously no deficiencies. And the other way =
is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
