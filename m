From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Atomic operators in alsa driver
Date: Tue, 10 Aug 2004 21:51:54 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040810215154.8910.h006.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

A question to clarify which 'operators' are atomic i.e. inside spinlock.

As far as I can make out from Takashi's Writing an Alsa driver, Chapter 5,
section "Operators" (am I correct?)

Atomic:
trigger callback
pointer callback

Non-atomic:
open callback
close callback
ioctl callback
hw_params callback
hw_free callback
prepare callback
copy and silence callbacks
ack callback
page callback

This could be clarified explicitly in the section "Atomicity"

thanks

Eliot


Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
