From: Andrei Boros <andrei@srr.ro>
Subject: alsa-driver, make 3.79, cvscompile
Date: Thu, 20 Mar 2003 10:20:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E7979E5.C5FC9BF6@srr.ro>
References: <3E784A3C.133F177B@srr.ro> <s5h7kavtwzs.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I got make 3.79 installed, hopefully the sequencer module problems will
be solved, but I get a tiny error that didn't appear before when runing
cvscompile :

I updated the cvs tree, did a make clean, deleted Makefile, then ran
./cvscompile.
This is the first line it outputs:
make: *** No rule to make target `all-deps'.  Stop.

Then the configure script starts and runs fine apparently. 


-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
