From: Frank Barknecht <barknech@ph-cip.uni-koeln.de>
Subject: Re: [ANNOUNCE] USB MIDI support for ALSA
Date: Tue, 14 May 2002 12:05:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020514120542.C4144@fliwatut.scifi>
References: <3CE01254.901318C3@ladisch.de> <s5h3cwv85k7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.netcologne.de (smtp.netcologne.de [194.8.194.112])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA24703
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 13:43:26 +0200
Received: from fliwatut.scifi (dial-213-168-73-128.netcologne.de [213.168.73.128])
	by smtp.netcologne.de (8.12.2/8.12.2) with ESMTP id g4EBghJt001237
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 13:42:46 +0200 (MEST)
Received: (from freak@localhost)
        by fliwatut.scifi (8.12.0.Beta5/8.12.0.Beta5/Debian 8.12.0-1) id g4EA5iuv004899
        for alsa-devel@alsa-project.org; Tue, 14 May 2002 12:05:44 +0200
Content-Disposition: inline
In-Reply-To: <s5h3cwv85k7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi,
Takashi Iwai hat gesagt: // Takashi Iwai wrote:
> > I've written a daemon which connects the ALSA sequencer with the
> > usbdevfs device file of a USB MIDI device. You can get it at
> > <http://www.informatik.uni-halle.de/~ladischc/usbmidid.html>.
> it's a very clean solution.  definitely the right way for usb midi,
> rather than writing a driver module for each.
Would a daemon to connect alsa to usb devices be the way for USB-audio
as well?

ciao,
-- 
 Frank Barknecht                                  _ _______footils__


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
