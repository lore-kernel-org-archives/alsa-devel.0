From: Sagi Bashari <sagi@boom.org.il>
Subject: [Fwd: Re: [Alsa-user] playng several files at the same time]
Date: Sat, 05 Oct 2002 21:29:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D9F3D84.4040102@boom.org.il>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010102050801010103000100"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010102050801010103000100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

No answer on the users list, forwarding to devel.

--------------010102050801010103000100
Content-Type: message/rfc822;
 name="Re: [Alsa-user] playng several files at the same time"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: [Alsa-user] playng several files at the same time"

Return-Path: <alsa-user-admin@lists.sourceforge.net>
Delivered-To: sagi@boom.org.il
Received: from aresworld.net [64.38.234.90]
	by localhost with POP3 (fetchmail-5.9.0)
	for sagi@localhost (single-drop); Sat, 05 Oct 2002 20:03:38 +0300 (IDT)
Received: (qmail 25706 invoked from network); 5 Oct 2002 16:07:26 -0000
Received: from usw-sf-fw2.sourceforge.net (HELO usw-sf-list2.sourceforge.net) (216.136.171.252)
  by 0 with SMTP; 5 Oct 2002 16:07:26 -0000
Received: from usw-sf-list1-b.sourceforge.net ([10.3.1.13] helo=usw-sf-list1.sourceforge.net)
	by usw-sf-list2.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17xs7y-0005QV-00; Sat, 05 Oct 2002 09:50:06 -0700
Received: from m3.bezeqint.net ([192.115.106.4])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17xs79-0001fD-00
	for <alsa-user@lists.sourceforge.net>; Sat, 05 Oct 2002 09:49:16 -0700
Received: from domino.lan.boom.org.il (bzq-179-185-47.dsl.bezeqint.net [212.179.185.47])
	by m3.bezeqint.net (Mirapoint Messaging Server MOS 3.1.0.58-GA)
	with ESMTP id AEX56306;
	Sat, 5 Oct 2002 19:49:04 +0300 (IDT)
Received: from boom.org.il (beep.lan.boom.org.il [192.168.0.2])
	by domino.lan.boom.org.il (Postfix) with ESMTP
	id 3D9354A3BA; Sat,  5 Oct 2002 12:50:16 -0400 (EDT)
Message-ID: <3D9F2611.1030805@boom.org.il>
From: Sagi Bashari <sagi@boom.org.il>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: AthlonRob <athlonrob@data.4t3.com>
Cc: alsa-user@lists.sourceforge.net
Subject: Re: [Alsa-user] playng several files at the same time
References: <3D9EAF35.3060708@boom.org.il> <1033835682.26224.4.camel@duron>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
X-BeenThere: alsa-user@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Id: Advanced Linux Sound Architecture - User <alsa-user.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-user>
X-Original-Date: Sat, 05 Oct 2002 19:49:05 +0200
Date: Sat, 05 Oct 2002 19:49:05 +0200

On 10/5/2002 6:34 PM, AthlonRob wrote:

>On Sat, 2002-10-05 at 02:21, Sagi Bashari wrote:
>
>  
>
>>I installed ALSA on computer running RedHat 8.0 with Hercules Game 
>>Theater XP Sound Card.
>>
>>According to the ALSA website, this card should support hardware mixing, 
>>so I should be able to play more than one file in the same time.
>>
>>After I start to play the first file, every file I'm trying to play will 
>>simply hang until the first one finishes.
>>
>>I read somewhere that this is the intended behavior and if a programmer 
>>wants to he can disable it in his program code (using nonblock or 
>>something like that).
>>
>>However, I would like to enable it globally.
>>    
>>
>
>Well.... I just posted a somewhat similar question last night about my
>nForce chip.  :-)
>
>Are you sure 'Hardware mixing' is what you need to play multiple files
>... I got the impression it was 'Multiple I/O' (but I could be totally
>mistaken).
>

Yes, I'm sure. See section 3.9 in 
http://www.alsa-project.org/~jfulmer/alsa-faq.html.

I had a Trident 4DWave card some years ago, and back then it did work 
with multiopen. I think it's disabled now - I read it in one of the 
packages documentation. My current GTXP card is much more advanced and 
supports mixing as well according to the site (I belive most modern 
soundcards do, only that alsa does not support this feature in all of them).

>
>Where on the ALSA website, exactly, did you find out your card supported
>'Hardware mixing'?  While I'm pretty sure my card *does* support
>whatever is required to play multiple files at once (I learned a
>SoundBlaster PCI128 does as does a SB Live, so surely it must be common
>in nice cards, right?) I would like to see if I can find out for sure.
>
I found in in the "SoundCard Matrix" section in the ALSA site - 
http://www.alsa-project.org/alsa-doc/ the '(4)' note means that a card 
supports hardware mixing.

>
>Sadly, I haven't received any responses to my original query.  I'm
>somewhat at a loss as far as all this sound stuff goes, but may (or may
>not) take it to the developers list if nobody has a clue...  :-)
>
>Rob
>
>
>  
>

Sagi




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user


--------------010102050801010103000100--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
