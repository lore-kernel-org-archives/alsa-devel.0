From: =?ISO-8859-2?Q?Miroslav_=A9ulc?= <fordfrog@gmail.com>
Subject: acer aspire 8943g with alc670
Date: Thu, 29 Jul 2010 04:09:37 +0200
Message-ID: <4C50E2E1.3030800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5641310391F
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 04:09:44 +0200 (CEST)
Received: by bwz4 with SMTP id 4so51443bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2010 19:09:44 -0700 (PDT)
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

 hello,

i'd like to help with making the above soundcard to fully work, but have
no clue what to do exactly. currently the soundcard works pretty weird,
though at least sound goes out :-)

i tried hda analyzer but did not find any documentation for it so have
no idea what to do exactly. also, when clicking AUD_IN nodes, i get this
error:

** (hda_analyzer.py:10063): WARNING **: column number is a boolean, but
will be interpreted as an integer; this is likely not what you intended
Traceback (most recent call last):
  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 308, in
selection_changed_cb
    self.__refresh()
  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 276, in __refresh
    self.load()
  File "/dev/shm/hda-analyzer/hda_analyzer.py", line 336, in load
    self.node_window.add(NodeGui(node=n))
  File "/dev/shm/hda-analyzer/hda_guilib.py", line 86, in __init__
    self.__build_node(node, doframe)
  File "/dev/shm/hda-analyzer/hda_guilib.py", line 682, in __build_node
    vbox.pack_start(self.__build_amps(node), False, False)
  File "/dev/shm/hda-analyzer/hda_guilib.py", line 365, in __build_amps
    node.in_amp and node.amp_vals_in or None)
  File "/dev/shm/hda-analyzer/hda_guilib.py", line 328, in build_caps
    if ctl.hdactl.amp_index_match(idx):
  File "/dev/shm/hda-analyzer/hda_proc.py", line 170, in amp_index_match
    count = (self.amp_chs & 1) + ((self.amp_chs >> 1) & 1)
TypeError: unsupported operand type(s) for &: 'NoneType' and 'int'


can anybody pls direct me to some documentation that could help me to
master hda analyzer and find the way to make the card work correctly?

miroslav
