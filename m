From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Subject: Known error with signed samples at high samplerate?
Date: Fri, 18 Jul 2003 14:43:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307181443.09298.gkajmowi@tbaytel.net>
Reply-To: gkajmowi@tbaytel.net
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

Is there a known error requesting signed integer samples at a high (44100+) 
sample rate?

I am using the plughw interface on a SBLive! value card.  When I request 
samples as listed above, snd_pcm_readi always returns -EPIPE.  This does not 
occur at lower sample rates or with unsigned samples.

Thanks for the info.

Garrett Kajmowicz
gkajmowi@tbaytel.net



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
