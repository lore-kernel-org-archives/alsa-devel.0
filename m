From: Itay Ben-Yaacov <nib_maps@yahoo.com>
Subject: apm corrupts intel8x0 on a dell inspiron 8200
Date: Sun, 6 Apr 2003 16:28:07 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030406232807.57160.qmail@web21004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Hi,

This is again concerning sound corruption after apm calls on a dell inspiron 8200 with an
intel8x0.
I thought at first that upgrading to bios A09 solved the problem, but it didn't, it just made it
less frequent (instead of getting sound corrpution after every apm call, you get it after a
few...)
Still, playing long samples is impossible.
When this happens, the corruption is not total: one can still identify what is being played, but
it is distorted till the end of the sample.  I read somewhere a suggestion that this may be due to
lost interrupts.

On the other hand, some software plays music without getting it corrupted: maybe this depends on
the precise encoding/rate/whatever of the sample in question, and the internal components involved
in its processing?

Unfortunately, I do not have much experience in debugging kernel (or modules), and don't know the
first thing about sound drivers or alsa.  I got the sources, though, and would be glad to start
playing with them if I knew where to start.
For example, how can I find out the characteristics of the sample being played when a corruption
occurs, how it is processed by the driver or the sound card, etc?  And what is this ac97 thing???
(Yes, I know I must be sounding like a complete ignorant).
Please, a few leads?

Thanks,
Itay.

Just for the record, I am currently using linux 2.4.20 with alsa 0.9.2, but this happens with
other kernel/alsa versions.  This does not happen though with the OSS driver.


__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
