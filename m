From: Mikhail Ramendik <mr@ramendik.ru>
Subject: Compiling the newest code for testing?
Date: Fri, 7 Jan 2005 05:25:45 +0300
Message-ID: <200501070525.45603.mr@ramendik.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

I would like to do some extensive testing of alsa on my Intel 865PE hardware 
(notably the analog vs. SPDIF issues). I have done some bug reporting and 
tested some fixes (thanks go to Takashi) in the past, but then fell out of 
sync on kernel versions because of other kernel-related issues on my hardware 
(now finally resolved).

I would like to test the latest code, in order for this testing to be most 
useful.

But I really got lost in what is that newest code that I should test, and in 
how I should get it to run. So I have some questions:

- Which alsa code version is in the 2.6.10 kernel release? 
(include/sound/version.h says 1.0.6, but there seem to be changelog entries 
and factual changes even from 2.6.10-rc3...)

- Which alsa kernel code should I run for testing? The 2.6.10-kernel version? 
1.0.8rc2? CVS? 1.0.8rc2 plus some files from CVS [those related to i8x0]?

- Is it OK to compile this kernel code by merely copying the relevant 
directories (sound [except for sound/oss] and include/sound) from the alsa 
tree into the kernel tree? I run an RPM-based system, and would like to keep 
the existing approach to kernel building (full RPM rebuild) alive; it's slow 
but reliable. 

- Which alsa-lib and alsa-utils code should I be running? (I know how to 
compile it using RPM, I just need to understand the version).

And an i8x0-specific question: in the above-mentioned current code, should 
output to hw:0,0 go only to analog, or to both analog and spdif? 

-- 
Yours, Mikhail Ramendik



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
