From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Linux driver for cs4281 with TWO cs4299 codecs?
Date: Wed, 22 May 2002 20:33:46 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0205222024530.12692-100000@mailserver.intern.bfad.de>
References: <s5hd6vof3x0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6vof3x0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: twoller@crystal.cirrus.com, pcaudio@crystal.cirrus.com, alsa-devel@lists.sourceforge.net, peter wachtendorf <pew@bfad.de>
List-Id: alsa-devel@alsa-project.org

> ok, now i did a very very quick hack.  could you try the attached
> patch?  (you'll need to pass the module option snd_dual_codec=1)
> it doesn't change the TCID value (it was set to 1).  it might be
> different value.  tune as you like.

You did quite a lot of code in such a short time. Thanks a lot!

Unfortunately does not work:

ALSA ../alsa-kernel/pci/cs4281.c:1476: DLLRDY not seen
CS4281 soundcard not found or device busy

(I have done  modprobe snd-cs4281 snd_dual_codec=1).

Please let me know if you have any other ideas, otherwhise I will go on
to debug it myself. Your patch seems to be a very good start.

BTW I am using 2.4.17 kernel recompiled with HZ=1000 and low-latency patch and
alsa-driver-0.9.0rc1.

In fact I would prefer alsa-driver-0.5.12a to work with this dual codec
(application porting!) but I am aware nobody is going to help me with ALSA5.

Best regards,
--
Tomasz Motylewski
BFAD GmbH & Co. KG


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
