From: Neill Bell <nbell@hoopaloo.org>
Subject: [Fwd: [Alsa-user] Recording with the Midiman Delta DiO 2448 (CMI8738)]
Date: Thu, 10 Oct 2002 20:32:30 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA62A2E.1080705@hoopaloo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080404080300050607010004"
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
--------------080404080300050607010004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I didn't get an answer in alsa-user. Thought I'd forward this to 
alsa-devel.

--------------080404080300050607010004
Content-Type: message/rfc822;
 name="[Alsa-user] Recording with the Midiman Delta DiO 2448 (CMI8738)"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[Alsa-user] Recording with the Midiman Delta DiO 2448 (CMI8738)"

Return-Path: <alsa-user-admin@lists.sourceforge.net>
Delivered-To: nbell@hoopaloo.org
Received: (qmail 15762 invoked from network); 6 Oct 2002 22:18:24 -0000
Received: from unknown (HELO usw-sf-list2.sourceforge.net) (216.136.171.252)
  by h2.hoopaloo.org with SMTP; 6 Oct 2002 22:18:24 -0000
Received: from usw-sf-list1-b.sourceforge.net ([10.3.1.13] helo=usw-sf-list1.sourceforge.net)
	by usw-sf-list2.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17yJe4-0001IQ-00; Sun, 06 Oct 2002 15:13:04 -0700
Received: from h2.hoopaloo.org ([208.177.13.89] helo=merlyn.hoopaloo.org)
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17yJdF-0000HX-00
	for <alsa-user@lists.sourceforge.net>; Sun, 06 Oct 2002 15:12:13 -0700
Received: (qmail 15755 invoked from network); 6 Oct 2002 22:12:12 -0000
Received: from unknown (HELO hoopaloo.org) (10.0.110.26)
  by merlyn.hoopaloo.org with SMTP; 6 Oct 2002 22:12:12 -0000
Message-ID: <3DA0B53C.8080803@hoopaloo.org>
From: Neill Bell <nbell@hoopaloo.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alsa-user@lists.sourceforge.net
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Alsa-user] Recording with the Midiman Delta DiO 2448 (CMI8738)
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
X-Original-Date: Sun, 06 Oct 2002 17:12:12 -0500
Date: Sun, 06 Oct 2002 17:12:12 -0500

[I'm sorry if you get this twice, I posted from the wrong account]


Greetings,

I've read a few postings on here about recording through the S/PDIF
input on CMI8738-based cards, but I haven't seen any solutions. I've
been able to get recording working with my Midiman card by modifying the
cmipci.c file to include the record enable mixer switch. The code to add
this switch is commented out with comments like /* these will be
controlled in pcm device */.

Is this PCM device functionality that has yet to be implemented? Or is
it already implemented and I'm going about this the hard way?

--
Neill Bell




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--------------080404080300050607010004--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
