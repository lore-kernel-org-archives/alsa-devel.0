From: Denis Sbragion <d.sbragion@infotecna.it>
Subject: Re: EWX 24/96 and SPDIF: solved? (with patch)
Date: Tue, 30 Sep 2003 14:50:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.1.20030930143325.01dac280@pop3.infotecna.lcl>
References: <5.1.0.14.1.20030930091950.037fac38@pop3.infotecna.lcl>
 <5.1.0.14.1.20030930091950.037fac38@pop3.infotecna.lcl> <Pine.LNX.4.53.0309301329340.1362@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0309301329340.1362@pnote.perex-int.cz>
References: <5.1.0.14.1.20030930091950.037fac38@pop3.infotecna.lcl>
 <5.1.0.14.1.20030930091950.037fac38@pop3.infotecna.lcl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Jaroslav,

At 13.45 30/09/2003 +0200, Jaroslav Kysela wrote:
...
>But I think that we still need to investigate why the second reset of
>the CS8427 chip failed.

I have double checked your reset code comparing it with the latest data 
sheet, where the weird reset procedure is explained, and in my opinion your 
code is ok. May be this is just a one time procedure, which avoid the 
CS8427 startup problem only the first time it is executed? This seems to be 
loosely confirmed by the fact that if I unload the 8427 kernel module 
(downloading the ICE module first, which uses it) and then reload it, 
sometimes I get weird behaviours, with problems settings the period 
size/buffer size both by arecord and BruteFIR. I know, it seems an 
unrelated problem. I'm supposing here a failure in the 8427 code causing 
also a problem elsewhere.
         Anyway, I still don't understand why this second reset is needed, 
base also on the rate value. When the SPDIF is the master clock the rate is 
defined by the input SPDIF stream, so comparing it with the rate requested 
by the program makes no sense to me. Of course I don't know the ALSA 
architecture enough to be sure that doing it it's really a bug.

Bye,
--
	Denis Sbragion
	InfoTecna
	Tel: +39 0362 805396, Fax: +39 0362 805404
	URL: http://www.infotecna.it



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
