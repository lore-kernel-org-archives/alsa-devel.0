From: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
Subject: snd-timer oops when unloading
Date: Sat, 23 Feb 2002 15:07:21 +0100
Message-ID: <3C77A219.8010300@epost.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080107090009060409040605"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080107090009060409040605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Recently I switched to 2.5.5. Compilation with egcs-2.91.66 went fine. 
However unloading the alsa module stack oopsed. It happened both with 
snd-cmipci and snd-trident but not with snd-dummy. By manual rmmod'ing I 
could track down the error to snd-timer. However modprobe'ing snd-timer 
alone does not show the problem - must be in combination with some card.

BTW: The alsasound rc script does not work with alsa support built into 
the kernel since '/proc/asound' is always present even if no driver 
dependant modules have been loaded.

Appened are my oops report and kernel config.

cu Marcus

--------------080107090009060409040605
Content-Type: application/gzip;
 name="marcus_info.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="marcus_info.tar.gz"

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
Nt7G23gbb+NtvI238Tbexp87/gdpOOPoACgAAA==
--------------080107090009060409040605--


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
