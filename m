From: "Philip A. Prindeville" <philipp@redfish-solutions.com>
Subject: Resend: Stripped down configs for digital-only
Date: Thu, 14 Jul 2005 12:19:17 -0600
Message-ID: <42D6ACA5.5050500@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010907060600060507070502"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010907060600060507070502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'll try on alsa-devel instead...



--------------010907060600060507070502
Content-Type: message/rfc822;
 name="[Alsa-user] Stripped down configs for digital-only"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[Alsa-user] Stripped down configs for digital-only"

Return-Path: <alsa-user-admin@lists.sourceforge.net>
Received: from mail.redfish-solutions.com ([unix socket])
	 by mail.redfish-solutions.com (Cyrus v2.2.12-Invoca-RPM-2.2.12-1.1.fc3) with LMTPA;
	 Tue, 12 Jul 2005 19:40:41 -0600
X-Sieve: CMU Sieve 2.2
Received: from lists-outbound.sourceforge.net (lists-outbound.sourceforge.net [66.35.250.225])
	by mail.redfish-solutions.com (8.13.1/8.13.1) with ESMTP id j6D1efn0018607
	for <philipp_subx@redfish-solutions.com>; Tue, 12 Jul 2005 19:40:41 -0600
Received: from projects.sourceforge.net (sc8-sf-list2-b.sourceforge.net [10.3.1.8])
	by sc8-sf-spam2.sourceforge.net (Postfix) with ESMTP
	id 4D758FC67; Tue, 12 Jul 2005 18:40:39 -0700 (PDT)
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list2.sourceforge.net with esmtp (Exim 4.30)
	id 1DsWCO-0003kj-15
	for alsa-user@lists.sourceforge.net; Tue, 12 Jul 2005 18:38:08 -0700
Received: from mail.redfish-solutions.com ([71.36.29.88])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DsWCN-0007d9-Pu
	for alsa-user@lists.sourceforge.net; Tue, 12 Jul 2005 18:38:08 -0700
Received: from [192.168.1.5] ([192.168.1.5])
	by mail.redfish-solutions.com (8.13.1/8.13.1) with ESMTP id j6D1c68L018601
	for <alsa-user@lists.sourceforge.net>; Tue, 12 Jul 2005 19:38:07 -0600
Message-ID: <42D4707E.4090002@redfish-solutions.com>
From: Philip Prindeville <philipp_subx@redfish-solutions.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alsa-user@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to http://sf.net/tracker/?func=add&group_id=1&atid=200001
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 SF_CHICKENPOX_SLASH    BODY: Text interparsed with /
	0.0 SF_CHICKENPOX_MINUS    BODY: Text interparsed with -
	0.0 SF_CHICKENPOX_APOSTROPHE BODY: Text interparsed with '
	0.0 AWL                    AWL: From: address is in the auto white-list
Subject: [Alsa-user] Stripped down configs for digital-only
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
X-BeenThere: alsa-user@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: Advanced Linux Sound Architecture - User <alsa-user.lists.sourceforge.net>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
X-Original-Date: Tue, 12 Jul 2005 19:38:06 -0600
Date: Tue, 12 Jul 2005 19:38:06 -0600

I have a hardware set up that includes both analog and digital
capture/playback...

I can't use the analog playback because... well, various reasons.

I was wondering if there would be a mini-HOWTO on how to
pare down a configuration to only the digital components...

For example, if you're using SPDIF, you can usually pipe a variety
of formats into it... 44.1kHz at 2x16bit, 48kHz at 2x16bit, 96kHz
at 2x 16bit, 96kHz at 2x 24 bit, DTS at 192kb/s, DTS at 224kb/s,
etc....

I don't require any sort of mixing, resampling, equalization, etc.

I figure with the less stuff to tweak, the less likely I am to get it wrong.

Anyone have any sort of advice that I can compile into a HOWTO?

Thanks,

-Philip



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--------------010907060600060507070502--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
