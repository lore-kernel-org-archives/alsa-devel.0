From: Ben Saylor <bensaylor@fastmail.fm>
Subject: Audiophile USB samplerate workaround
Date: Tue, 22 Jul 2003 22:59:25 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307222259.25527.bensaylor@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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

I did some investigation to find out why the sample rate can't be set to 
anything but 48khz (or rather, remains 48khz even if it is set to 
something else) on the Audiophile.

In init_usb_sample_rate(), 
	if (fmt->attributes & EP_CS_ATTR_SAMPLE_RATE)
is never true, so the sample rate is not set.  If I just make it if(1) 
the sample rate is settable.  Is this a hardware bug or something else?

Ben



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
