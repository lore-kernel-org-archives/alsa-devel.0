From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: CVS changes, rc4 release in H-9
Date: Tue, 22 Oct 2002 23:50:19 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB565AB.3080304@boosthardware.com>
References: <s5hsmyy3gv4.wl@alsa2.suse.de>	<Pine.LNX.4.33.0210221245470.521-100000@pnote.perex-int.cz> <s5hlm4q3fpr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id QAA03060
	for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2002 16:51:42 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 22 Oct 2002 12:46:19 +0200 (CEST),
> Jaroslav wrote:
> 
>>On Tue, 22 Oct 2002, Takashi Iwai wrote:
>>
>>
>>>At Tue, 22 Oct 2002 11:14:39 +0200 (CEST),
>>>Jaroslav wrote:
>>>
>>>>Hi all,
>>>>
>>>>	I've applied a patch from Chris Rankin to fix module options for
>>>>core directory. Everything seems working on my side. I've added
>>>>explanation for module options to INSTALL file and added
>>>>alsa-driver/utils/module-options script for easy conversion to new names.
>>>>I'll release 0.9.0beta4 after 9 hours (if a critical bug doesn't appear).
>>>
>>>I added a check to make install whether snd_ prefix is defined in the
>>>current module configuration.  Hopefully this works enough for tests.
>>>
>>>Also, i've updated my alsaconf script, which now supports both with
>>>and without snd_ prefix.
>>>
>>>	ftp://ftp.suse.com/pub/projects/alsa/misc/alsaconf
>>>
>>>It might take a couple of hours to be exported.
>>>If you need this script urgently, please let me know.
>>>
>>>Or, this script can go into alsa-driver package, if many of you
>>>want...
>>
>>Yep, please, commit it for more wide use...
> 
> 
> ok, it's now on alsa-driver/utils.
> should it be installed to the public directory via "make install" ?
> 

I'm updating the site docs now. what should I do with the usb midi doc? 
Just link it into the usb-audio page or merge them together completely?

Also can people send me a list of all the new cards that are working now 
please.



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
