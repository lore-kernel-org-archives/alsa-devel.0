From: Anders Torger <torger@ludd.luth.se>
Subject: Minor bug(s) in hdsp.c (RME HDSP driver)
Date: Sat, 19 Jul 2003 19:24:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307191924.15922.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


In hdsp.c (CVS):

The function hdsp_set_rate() returns -1 on error, which equals -EPERM. 
snd_hdsp_hw_params() returns the return value of hdsp_set_rate() on 
failure, thus if hdsp_set_rate() cannot be set, then -EPERM is coming 
out of alsa-lib.

I also think that the behaviour of hdsp_set_rate() should change. If the 
card is set to AutoSync, and there is no input signal, hdsp_set_rate() 
will fail on line 888. In this case, I think the proper behaviour would 
be to set the card in Master mode with the given rate.

----

At the same time I'd like to ask a question. The card I have on my hands 
is a HDSP 9652 PCI card. I have noticed that it has some DSP mixer, and 
that there are volume control settings in the driver. I want the card 
to work just like a good ol' RME9652 (that is no volume control no 
mixing, what comes in comes in, what goes out goes out), will it do 
that per default, or do I have to raise some volume controls and do 
other stuff to deactivate the mixer?

I would test if I could, the problem is that the HDSP card I'm working 
with sits in a computer across the pond, and my only access is through 
a slow internet connection, so I'm very limited when it comes to 
hearing sound and moving cables. For the same reason it is not suitable 
that I would write patches for the above, since I can't hear if I have 
broken something.

/Anders Torger



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
