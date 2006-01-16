From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: How are multiple capture sources confusing alsamixer?
Date: Mon, 16 Jan 2006 11:51:53 +1030 (CST)
Message-ID: <200601160121.k0G1LrSU013170@auster.physics.adelaide.edu.au>
References: <20060115233401.2AB0F12666@sc8-sf-spam2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060115233401.2AB0F12666@sc8-sf-spam2.sourceforge.net> from "alsa-devel-request@lists.sourceforge.net" at Jan 15, 2006 03:33:01 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi all

I've noticed the following comment in a variety of drivers:

  /* The multiple "Capture Source" controls confuse alsamixer
   * So call somewhat different..
   * FIXME: the controls appear in the "playback" view!
   */
  /* .name = "Capture Source", */

I've been working on adding the second capture source to the ALC260 Fujitsu
configuration and have not really seen any major problems with alsamixer's
interpretation when two capture sources are declared.  What seems to happen
for me is that each potential source gets two capture switches; one switches
to the first capture source and the other switches to the second capture
source.  Furthermore, all this appears to work fine.

So, in what way(s) does the presence of multiple capture sources confuse
alsamixer and give rise to the source-code comment quoted above?

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
