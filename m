From: <fmoraes74@netzero.net>
Subject: Renaming mixer controls
Date: Thu, 10 Jun 2004 18:20:22 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040610.112056.12909.28393@webmail03.nyc.untd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from outbound20-2.nyc.untd.com (outbound20-2.nyc.untd.com [64.136.20.160])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 3F7B8238
	for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2004 20:21:40 +0200 (MEST)
Received: from outbound21-sr.nyc.untd.com (webmail03.nyc.untd.com [10.140.30.143])
	by smtpout05.nyc.untd.com with SMTP id AABANTKXGA7AC5KA
	for <alsa-devel@alsa-project.org> (sender <fmoraes74@netzero.net>);
	Thu, 10 Jun 2004 11:21:26 -0700 (PDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Is there a standard/easy way to rename mixer controls?

While playing with the capture on the emu10k1x driver, I found that the Mic control in the alsamixer does not correspond to the attached microphone. Instead, I had to use the Capture control.

The same is true for playback, where channel 0 is controlled by PCM control and channel 1 is controlled by a control called Sigmatel.

I still have not found a way to control channel 2.

Francisco

________________________________________________________________
The best thing to hit the Internet in years - NetZero HiSpeed!
Surf the Web up to FIVE TIMES FASTER!
Only $14.95/ month -visit www.netzero.com to sign up today!


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
