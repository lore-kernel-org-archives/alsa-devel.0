From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Re: ANN: AudioScience driver beta  0.3 (0.9.6)
Date: Tue, 16 Sep 2003 21:56:56 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030916215657.18748.h006.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>>>any chance to get the whole things into alsa tree?
>>
>>Takashi,
>>
>>I would love to get this into the ALSA tree.  
>>How do I go about doing this? 
>>Are there changes I need to make to the code to make it "acceptable"?
> 
> 
> firstly, Jaroslav and I will review the patch.
> the patch itself looks almost ok, if the indentation follows the
> standard kernel style (see linux/Documentation/CondingStyle).

Getting asihpi.c into standard style should not be too much work.

>>When you say the "whole thing", do you mean the ALSA part of our driver, or
>>including our underlying HPI driver.
> 
> i meant the latter, including HPI driver.
> 
> since the HPI driver part is the essential part of the driver, we
> surely need more review for that, too.

Please, go ahead... tell me the worst - I won't be surprised.
 
> IIRC, the HPI driver is GPL, so won't it be problem, right? 

No problem with using the code.  However, it is extremely unlikely that we will
redo all the HPI files to meet the CodingStandard.  I have read it and it does
say "preferred" not "mandatory".

If its just a matter of running them all through "indent -kr -i8" then thats OK.

> when the audioscience driver is promoted to the linux 2.6.0 kernel
> tree, it must be anyway a complete set.  then putting the whole stuffs
> into alsa directory tree would be the easiest solution, i think.
> 
> 
> Takashi


Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
