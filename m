From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: multiple devices/ possible bug in aplay or somewhere else?
Date: Tue, 15 Oct 2002 08:49:11 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021015154911.6849.qmail@web11501.mail.yahoo.com>
References: <s5h1y7zp5fp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1y7zp5fp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I have tried playing audio on device 1 of a "pci2103" card through aplay, which
correctly displayed 2 devices and 1 subdevice each (aplay -l). The result was
that audio was still played on device 0, regardless of the -d parameter.

So my questions are:
 - are you aware of any bug in aplay or the ALSA library/driver frame work that
would cause this behaviour?
 - what other cards support multiple devices?


In an unrelated topic, did I miss a standard API for selecting the actual port
that a device captures from / plays out to, and is there any accepted default
mapping?

I would like to see the inclusion of the "pci2103" driver in the ALSA
distribution in the near future and before 1.0 at any rate. Advice on the
procedure for this to happen is welcome.

Cheers!
Guilhem.


__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
