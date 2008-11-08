From: Shane W <shane-alsa@csy.ca>
Subject: Intel G45 HDMI audio - missing samples
Date: Sat, 8 Nov 2008 11:51:52 -0800
Message-ID: <20081108195152.GA9858@csy.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from idcmail-mo1so.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C950103813
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 20:51:54 +0100 (CET)
Received: from shane by continuum.csy.ca with local (Exim 4.69)
	(envelope-from <shane-alsa@csy.ca>) id 1Kytqa-0002Zv-VX
	for alsa-devel@alsa-project.org; Sat, 08 Nov 2008 11:51:53 -0800
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

One issue with Intel audio over HDMI on a DG45-ID
motherboard.  When playing a short sample via HDMI, it
misses the first quarter second or so of the audio.  This
is particularly noticable when using text to speech as the
first word is lost.  I can get around this by having a
seperate program hold the audio device open while using
text to speech, that seems to get the whole sample but it's
a cludgy workaround.  The same issue does not exist on the
optical port.

Best,
Shane
