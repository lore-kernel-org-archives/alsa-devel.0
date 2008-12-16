From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: alsa-utils: alsactl restore not working after system
	restart
Date: Tue, 16 Dec 2008 13:58:02 +0100
Message-ID: <d9690f190812160458t79cef08dt56ad7bd68e174d8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 9607C24345
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 13:58:03 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so1263217ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 04:58:02 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi there.

I am running Ubuntu 8.10 - and latest ALSA.

After restart amixer defaults to default settings.

I am not really sure if this is Ubuntu/Debian specific or an
Alsa issue.

It seems that either a link  /var/lib/alsa/asound.state to /etc/asound.state
is needed
or that /etc/init.d/alsa-utils needs to be updated within the restore
section accordingly.

With the link workaround I managed to get it working.

Cheers
Klaus
