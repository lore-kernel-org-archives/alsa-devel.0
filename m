From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Removal of /proc/asound ?
Date: Sat, 17 May 2003 08:16:25 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030517081625.6ef24458.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi all, 

I noticed this in a recent post from Takashi Iwai :

> (note that you need to run snddevices script once with the recent cvs
> version, since we removed the dynamic device files on /proc.)

Anybody care to fill me in on :

    0) Why this is being done?
    1) What replaces it?
    2) How do user space programmers ensure backwards and forwards 
       compatibility?

Thanks,
Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"The happiness you have demanded is now mandatory." 
    -- Jello Biafra


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
