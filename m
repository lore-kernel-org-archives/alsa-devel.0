From: Andrei Boros <andrei@srr.ro>
Subject: alsa-tools [CVS]
Date: Wed, 15 Oct 2003 11:37:48 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8D075C.1C77ADD8@srr.ro>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


 Attempting to build the alsa-tools from the cvs tree I see that it does
not handle properly the missing fltk library when it attempts to build
hdspmixer.

cvscompile runs configure then attempts to run make on this tool even
after configure gave the error that it did not find fltk and the
attempted compilation is aborted on each target with lot's of missing
files.

I think it should skip hdspmixer if it's configure detects missing
dependencies.

-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
