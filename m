From: Frank Barknecht <fbar@footils.org>
Subject: Re: [ALSA - driver 0000813]: Terratec USB surround broken
Date: Mon, 7 Feb 2005 16:41:24 +0100
Message-ID: <20050207154124.GC4291@fliwatut.scifi>
References: <a83cd635c149cacbdf9253e99879deca@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from 217-114-212-9.kunde.vdserver.de (213-146-165-197.kunde.vdserver.de [213.146.165.197])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 08D0B16E
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2005 16:41:26 +0100 (MET)
Received: from xdsl-84-44-148-163.netcologne.de ([84.44.148.163] helo=fliwatut.scifi)
	by 217-114-212-9.kunde.vdserver.de with asmtp (TLS-1.0:RSA_ARCFOUR_SHA:16)
	(Exim 4.34)
	id 1CyB0u-0000mQ-QJ
	for alsa-devel@alsa-project.org; Mon, 07 Feb 2005 16:41:25 +0100
Received: from freak by fliwatut.scifi with local (Exim 4.34)
	id 1CyB0u-0002AP-JY
	for alsa-devel@alsa-project.org; Mon, 07 Feb 2005 16:41:24 +0100
Content-Disposition: inline
In-Reply-To: <a83cd635c149cacbdf9253e99879deca@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hallo,
bugtrack@alsa-project.org hat gesagt: // bugtrack@alsa-project.org wrote:

> A NOTE has been added to this issue.
> ======================================================================
> <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=813> 
> ======================================================================
> Reported By:                ilikejam
> Assigned To:                Clemens Ladisch
> ======================================================================
> Project:                    ALSA - driver
> Issue ID:                   813
> Category:                   USB - usb-audio
> Reproducibility:            always
> Severity:                   minor
> Priority:                   normal
> Status:                     assigned
> Distribution:               Fedora Core 3
> Kernel Version:             2.6.10 (ALSA compiled in)
> ======================================================================
> Date Submitted:             01-12-2005 19:41 CET
> Last Modified:              02-07-2005 10:40 CET
> ======================================================================
> Summary:                    Terratec USB surround broken
> Description: 
> I'm using a Terratec USB 5.1 card. The 6 channels test correctly using
> './speaker-test -c6', but any attempt to use 5.1 channel in Xine, or using
> 'aplay -Dsurround51 file.wav' results in errors e.g.
> ----------------------------------------------------------------------
>  Clemens Ladisch - 02-07-05 10:40 
> ----------------------------------------------------------------------
> The contents of the stream0 file indicate that your device doesn't support
> any other sample rate than 48 kHz.  So, when recording from a digital
> 44.1kHz source, the data still gets labeled as "48kHz".

If it helps: I have the same card, it is 48kHz only in hardware. The
newer models (slightly smaller, mini-jacks) however support 44.1, too.

Ciao
-- 
 Frank Barknecht                               _ ______footils.org__
             
             _ __latest track: fqdn _ http://footils.org/cms/show/38


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
