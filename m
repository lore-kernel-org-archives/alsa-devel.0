From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: aplay bug?
Date: Wed, 26 Nov 2003 19:02:48 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031126190248.9916.h006.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

At line 200 of aplay.c (1.0.0pre3)
		if ((err = snd_ctl_open(&handle, name, 0)) < 0) {
			error("control open (%i): %s", card, snd_strerror(err));
			continue;
		}
if this error occurs, 'card' is never updated, the while loop becomes infinite.
because this bit from the end of the while loop is missed by the continue:

			if (snd_card_next(&card) < 0) {
			    error("snd_card_next");
			    break;
			}

I see this problem because when I load alsa drivers, I don't get the correct
permissions on files in /dev (I think).

Just found that the specific problem is that directory /dev/snd has permissions 
drw-rw----, should be drwxrwx--x

Can anybody help me about where this is configured?
I have options snd device_mode=0660 in my modules.conf which seems right for the
actual device files inside /dev/snd - is this wrong...?

thanks


Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
