From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: amixer simple control commands fail
Date: Thu, 20 May 2004 16:41:47 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040520164148.1766.h003.c012.wm@mail.icqmail.com.criticalpath.net>
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

alsa-1.0.4.
The card driver is my own Audioscience driver.

I have three cards installed, and the following problem only happens with one of
them.
The only difference as far as alsa controls go is that the failure occurs with a
card that has 287 controls, while the others have 127 and 35 respectively.

Problem:
Running amixer with any of the s commands (scontrols etc) it fails with the
message
"amixer: Mixer hw:1 load error: Invalid argument"

The ordinary commands (controls,contents,set,get) work OK for all cards.

The problem also happens with alsamixer, so I guess the problem is in alsa-lib
somewhere.

What should I be looking for? I am just guessing that the problem relates to
number of controls. I could be quite wrong.

regards


Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
