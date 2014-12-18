From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: alsa-firmware: Re: [PATCH 3/3] asihpi: update to HPI
	version 4.14
Date: Thu, 18 Dec 2014 18:03:37 +1300
Message-ID: <54926029.3020507@blennerhassett.gen.nz>
References: <1418878635-18960-1-git-send-email-eliot@blennerhassett.gen.nz>
 <1418878635-18960-3-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from omr2.mail.isx.net.nz (omr2.mail.isx.net.nz [111.65.230.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 057002614AF
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 06:03:41 +0100 (CET)
In-Reply-To: <1418878635-18960-3-git-send-email-eliot@blennerhassett.gen.nz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

there is a corresponding update to alsa-firmware/asihpi
to go with the new HPI version.

You can download the new firmware here (or would you prefer a binary
patch generated from the git repo?)

https://drive.google.com/open?id=0B8ccScr8Ew74LVVpYnNlZlc0ZUE&authuser=0

If possible can you remove dsp2400.bin from the repo, it is not used by
any plug-in adapter (it is meant for a networked device, and got into
alsa-firmware by mistake)

Contents of download:

asihpi_firmware.7z
Date      Time    Attr         Size   Compressed  Name
------------------- ----- ------------ ------------  ---------------
2014-10-04 02:32:40 ....A       186764      1564580  dsp5000.bin
2014-12-04 03:33:21 ....A       853340               dsp6200.bin
2014-12-04 03:27:52 ....A        59388               dsp6205.bin
2014-12-04 03:35:44 ....A       646672               dsp6400.bin
2014-12-04 03:38:11 ....A       649636               dsp6600.bin
2014-12-04 03:41:05 ....A      1565436               dsp8900.bin
2014-10-04 02:41:20 ....A       365476       144838  dsp8700.bin
------------------- ----- ------------ ------------  ----------------
                               4326712      1709418  7 files, 0 folders

--
Eliot
P.S: I haven't forgotten your request to replace tasklet in asihpi
