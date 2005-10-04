From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Hotplug firmware problems
Date: Tue, 04 Oct 2005 20:04:44 +0100
Message-ID: <1128452684.5085.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linuxsh-dev@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am attempting to load the firmware my device (AICA sound on Dreamcast)
needs via hotplug...

	/* Load the firmware */
	const struct firmware *fw_entry;
	err = request_firmware(&fw_entry, "aica_firmware.bin", &pd->dev);
	if (err) goto freepcm;

(all the code can be seen at http://newgolddream.dyndns.info/repos)

But the firmware load fails... you can see the log at
http://newgolddream.dyndns.info/hotplug_fail.txt  -- but I have to
confess I don't know much about what the messages mean. Anybody able to
help me out?

Adrian



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
