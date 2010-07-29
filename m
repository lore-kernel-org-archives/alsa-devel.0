From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: acer aspire 8943g with alc670
Date: Thu, 29 Jul 2010 17:10:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007291704120.4068@eeebox2.perex-int.cz>
References: <4C50E2E1.3030800@gmail.com>
	<AANLkTindqKL769hKUk9z18RkABL4SwEubWzn_D0DuAb5@mail.gmail.com>
	<4C5184B6.4040503@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-343642383-1280416212=:4068"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 2305F24427
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 17:10:13 +0200 (CEST)
In-Reply-To: <4C5184B6.4040503@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Miroslav_=C5=A0ulc?= <fordfrog@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-343642383-1280416212=:4068
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 29 Jul 2010, Miroslav =C5=A0ulc wrote:

> Dne 29.7.2010 15:20, Raymond Yau napsal(a):
>> 2010/7/29 Miroslav =C5=A0ulc <fordfrog@gmail.com>
>>>  hello,
>>>
>>> i'd like to help with making the above soundcard to fully work, but hav=
e
>>> no clue what to do exactly. currently the soundcard works pretty weird,
>>> though at least sound goes out :-)
>>>
>>> i tried hda analyzer but did not find any documentation for it so have
>>> no idea what to do exactly. also, when clicking AUD_IN nodes, i get thi=
s
>>> error:
>>>
>>> ** (hda_analyzer.py:10063): WARNING **: column number is a boolean, but
>>> will be interpreted as an integer; this is likely not what you intended
>>> Traceback (most recent call last):
>>>  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 308, in
>>> selection_changed_cb
>>>    self.__refresh()
>>>  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 276, in __refresh
>>>    self.load()
>>>  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 336, in load
>>>    self.node_window.add(NodeGui(node=3Dn))
>>>  File "/dev/shm/hda-analyzer/hda_guilib.py", line 86, in __init__
>>>    self.__build_node(node, doframe)
>>>  File "/dev/shm/hda-analyzer/hda_guilib.py", line 682, in __build_node
>>>    vbox.pack_start(self.__build_amps(node), False, False)
>>>  File "/dev/shm/hda-analyzer/hda_guilib.py", line 365, in __build_amps
>>>    node.in_amp and node.amp_vals_in or None)
>>>  File "/dev/shm/hda-analyzer/hda_guilib.py", line 328, in build_caps
>>>    if ctl.hdactl.amp_index_match(idx):
>>>  File "/dev/shm/hda-analyzer/hda_proc.py", line 170, in amp_index_match
>>>    count =3D (self.amp_chs & 1) + ((self.amp_chs >> 1) & 1)
>>> TypeError: unsupported operand type(s) for &: 'NoneType' and 'int'

I fixed this issue in the alsa.git repo now.

>>> can anybody pls direct me to some documentation that could help me to
>>> master hda analyzer and find the way to make the card work correctly?
>>>
>>> miroslav
>>
>> By using alc670 alsa-info.txt in the alsa bugtracker ,
> ok, i will post one once i restart my pc as i played with the settings
> of the driver so i guess the output might be affected.
>> the latest version
>> hda_analyzer don't has any error message when clicking AUD_IN node
> well, in the night i downloaded the app from
> http://www.alsa-project.org/hda-analyzer.py and have the issue. now also
> tried alsa git repo and the result is the same, so the bug really is
> there, at least for me. i can try to debug it in netbeans if i find out
> how (i do not code in python nor do i use it as coder).
>> Not sure your error is due to using  /proc instead of text file since I
>> don't have your codec
> i tried both, using proc and passing alsa-info.txt file to
> hda-analyzer.py, both with the same result.

Put alsa-info.txt somewhere to download or point me to this file in a=20
bugreport.

>> There are error messages when click the "graph" button to generate the
>> graph.
>>
>> About the graph
>> the blue line - connected audio path
>> the grey line - unconncted audio path
>> the line turn red when you put the mouse cursor near any line ,
> so hovering over gray connection makes the connection in the card
> driver, and hovering over blue connection disables the connection?

No, you need to edit the node (use open in context menu - right click on=20
node).

 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-343642383-1280416212=:4068
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-343642383-1280416212=:4068--
