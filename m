From: "Dr. med. =?iso-8859-15?q?G=FCnther?= Montag" <Safari.Doktor@addcom.de>
Subject: I/O Error in mmapping ES 1969
Date: Fri, 10 Oct 2003 14:29:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310101427.43458.Safari.Doktor@addcom.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
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

I mentioned my ham radio realtime program with mmap
in a posting on 3. Oct and before.
It works now with ALSA 0.9.7 with AC97 and maybe some other cards, thanks!!!
With ESS ES1969 mmap(ibuf, isize, PROT_READ, MAP_FILE | MAP_SHARED | 
MAP_FIXED, fd_audio, 0)
(and I tried also all other MAP_ options) it breaks with I / O error.
Do You know some help about mmap besides man,
or can I do something with "Scatter Gather" in ALSA API,
or does it help if i work myself into JACK for this problem?
hints welcome, tnx!!!

Safari.Doktor@addcom.de


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
