From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Subject: Assertion `!snd_interval_empty(i)' failed
Date: Fri, 11 Jul 2003 16:18:14 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307111618.14449.gkajmowi@tbaytel.net>
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

I am working on software designed for VOIP, but it dynamically changes sample 
rates and so forth on the fly.  So prior to doing a  snd_pcm_readi, I check 
to see if I need to change any parameters.  If so I used the existing 
hw_params object and apply the required changes to sample rate, data type, 
etc.

I then call pcm_drop to close the pcm device, followed by 
snd_pcm_hw_params(pcm_handle, hwparams) which should properly apply the 
configuration.  Instead I get:

interval.c:108: snd_interval_refine_min: Assertion `!snd_interval_empty(i)' 
failed.
Aborted

How do I go about fixing this problem?

Garrett Kajmowicz
gkajmowi@tbaytel.net



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
