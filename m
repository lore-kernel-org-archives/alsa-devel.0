From: Andrei Boros <andrei@srr.ro>
Subject: Re: dummy sequencer module problems
Date: Thu, 20 Mar 2003 10:28:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E797BC9.F4EB1348@srr.ro>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

<<<<<<< Makefile.conf.in
CONFIG_SND_SEQ_DUMMY    = @CONFIG_SND_SEQ_DUMMY@
=======
CONFIG_SND_SEQ_DUMMY    = @CONFIG_SND_SEQUENCER@
>>>>>>> 1.52

I got again this inconsistency in Makefile.conf.in when updateing the
cvs tree. 

I am wandering, this looks to me that snd-seq-dummy.o will be built
always if sequencer is built, regardless of the fact that the dummy
soundcard driver is built or not. I checked the Makefile in
alsa-kernel/core/seq.


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
